import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/category_expenses_model.dart'; // Import modelu CategoryExpensesModel z folderu "provider"

class Expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryExpensesModel = Provider.of<CategoryExpensesModel>(context);
    final expenses = categoryExpensesModel.categoryExpenses;

    // Przetwarzamy wydatki, aby połączyć nieznane kategorie pod "Inne"
    final processedExpenses = _processExpenses(expenses);

    return ListView(
      children: processedExpenses.entries.map((entry) {
        final category = entry.key;
        final expense = entry.value;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                color: _getCategoryColor(category), // Używamy koloru kategorii
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$category: ${expense.toStringAsFixed(2)} PLN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
    final processedExpenses = <String, double>{};
    double otherCategorySum = 0;

    // Iterujemy po wszystkich wydatkach
    expenses.forEach((category, expense) {
      // Jeśli kategoria jest znana, dodajemy ją do mapy
      if (_getCategoryColor(category) != Colors.grey) {
        // Sprawdzamy, czy kategoria jest znana
        processedExpenses[category] =
            (processedExpenses[category] ?? 0) + expense;
      } else {
        // Jeśli kategoria jest nieznana, dodajemy jej wartość do sumy "Inne"
        otherCategorySum += expense;
      }
    });

    // Dodajemy kategorię "Inne" tylko jeśli jest tam jakaś suma
    if (otherCategorySum > 0) {
      processedExpenses['Inne'] =
          (processedExpenses['Inne'] ?? 0) + otherCategorySum;
    }

    return processedExpenses;
  }
}
