import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../provider/category_expenses_model.dart';
import '../provider/subtract_model.dart'; // Import modelu CategoryExpensesModel z folderu "provider"

// Widget wyświetlający wykres kołowy dla wydatków w kategoriach
class CategoryExpensesPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Pobranie instancji CategoryExpensesModel z Providera
    final categoryExpensesModel = Provider.of<CategoryExpensesModel>(context);

    // Pobranie mapy z wydatkami dla każdej kategorii
    final expenses = categoryExpensesModel.categoryExpenses;

    // Przetwarzamy wydatki, aby połączyć nieznane kategorie pod "Inne"
    final processedExpenses = _processExpenses(expenses);

    final subtractModel = Provider.of<SubtractModel>(context, listen: false);

    return Center(
      child: processedExpenses.isEmpty
          ? Text("Brak wydatków do wyświetlenia")
          : Stack(
              alignment: Alignment.center,
              children: [
                // Wykres kołowy
                PieChart(
                  PieChartData(
                    sections: processedExpenses.entries.map((entry) {
                      final category = entry.key;
                      final expense = entry.value;

                      return PieChartSectionData(
                        color: _getCategoryColor(category),
                        value: expense,
                        title: '${expense.toStringAsFixed(1)} \nPLN',
                        radius: 45,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                    sectionsSpace: 1,
                    centerSpaceRadius:
                        45, // Dodajemy przestrzeń na tekst w środku
                  ),
                ),
                // Tekst w środku wykresu
                Container(
                  child: Text(
                    '${subtractModel.substract}\nPLN', // Wyświetl balans
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

  // Funkcja pomocnicza, która zwraca predefiniowany kolor dla każdej kategorii
  Color _getCategoryColor(String category) {
    // Zdefiniowana mapa kolorów dla określonych kategorii
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

    // Zwracamy kolor przypisany kategorii lub szary, jeśli nieznana
    return colorMap[category] ?? Colors.grey;
  }

  // Funkcja przetwarzająca wydatki, aby połączyć nieznane kategorie pod "Inne"
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
    double otherCategorySum =
        expenses['Inne'] ?? 0; // Uwzględnia wydatki oznaczone „Inne”

    // Iterujemy po wszystkich wydatkach
    expenses.forEach((category, expense) {
      if (colorMap.containsKey(category) && category != 'Inne') {
        // Jeśli kategoria jest znana (ale nie „Inne”), dodajemy ją do mapy
        processedExpenses[category] = expense;
      } else if (category != 'Inne') {
        // Jeśli kategoria jest nieznana, dodajemy jej wartość do sumy „Inne”
        otherCategorySum += expense;
      }
    });

    // Dodajemy kategorię „Inne” tylko jeśli jest tam jakaś suma
    if (otherCategorySum > 0) {
      processedExpenses['Inne'] = otherCategorySum;
    }

    return processedExpenses;
  }
}
