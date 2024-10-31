import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../provider/category_expenses_model.dart';
import '../provider/subtract_model.dart';

class CategoryExpensesPieChart extends StatefulWidget {
  @override
  _CategoryExpensesPieChartState createState() =>
      _CategoryExpensesPieChartState();
}

class _CategoryExpensesPieChartState extends State<CategoryExpensesPieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    // Pobranie instancji CategoryExpensesModel z Providera
    final categoryExpensesModel = Provider.of<CategoryExpensesModel>(context);
    final expenses = categoryExpensesModel.categoryExpenses;
    final processedExpenses = _processExpenses(expenses);
    final subtractModel = Provider.of<SubtractModel>(context, listen: false);

    return Center(
      child: processedExpenses.isEmpty
          ? Text("Brak wydatków do wyświetlenia")
          : Stack(
              alignment: Alignment.center,
              children: [
                // Wykres kołowy
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return PieChart(
                      PieChartData(
                        sections:
                            _generateAnimatedSections(processedExpenses, value),
                        sectionsSpace: 2,
                        centerSpaceRadius: 45,
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                _touchedIndex = -1;
                                return;
                              }
                              _touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                // Tekst w środku wykresu
                Container(
                  child: Text(
                    '${subtractModel.substract}\nPLN',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
    );
  }

  // Funkcja generująca listę sekcji wykresu na podstawie kategorii i ich wydatków
  List<PieChartSectionData> _generateAnimatedSections(
      Map<String, double> expenses, double animationValue) {
    final categories = expenses.entries.toList();

    return List.generate(categories.length, (index) {
      final category = categories[index].key;
      final expense = categories[index].value * animationValue;
      final isTouched = index == _touchedIndex;

      return PieChartSectionData(
        color: _getCategoryColor(category),
        value: expense,
        title: '${expense.toStringAsFixed(1)} \nPLN',
        radius: isTouched ? 50 : 45,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  Color _getCategoryColor(String category) {
    final colorMap = {
      'Jedzenie': Colors.greenAccent,
      'Zakupy': Colors.blueAccent,
      'Dom': Colors.pinkAccent,
      'Samochód': Colors.redAccent,
      'Transport': Colors.orangeAccent,
      'Sport': Colors.greenAccent,
      'Zdrowie': Colors.purpleAccent,
      'Inne': Colors.grey,
    };
    return colorMap[category] ?? Colors.grey;
  }

  Map<String, double> _processExpenses(Map<String, double> expenses) {
    final colorMap = {
      'Jedzenie': Colors.greenAccent,
      'Zakupy': Colors.blueAccent,
      'Dom': Colors.pinkAccent,
      'Samochód': Colors.redAccent,
      'Transport': Colors.orangeAccent,
      'Sport': Colors.greenAccent,
      'Zdrowie': Colors.purpleAccent,
      'Inne': Colors.grey,
    };

    final processedExpenses = <String, double>{};
    double otherCategorySum = expenses['Inne'] ?? 0;

    expenses.forEach((category, expense) {
      if (colorMap.containsKey(category) && category != 'Inne') {
        processedExpenses[category] = expense;
      } else if (category != 'Inne') {
        otherCategorySum += expense;
      }
    });

    if (otherCategorySum > 0) {
      processedExpenses['Inne'] = otherCategorySum;
    }

    return processedExpenses;
  }
}
