import 'package:flutter/material.dart'; // Importuje pakiet Fluttera, który zawiera komponenty Material Design
import 'package:provider/provider.dart'; // Importuje pakiet provider, który jest używany do zarządzania stanem
import '../provider/category_expenses_model.dart'; // Importuje model CategoryExpensesModel z folderu "provider"

class Expenses extends StatelessWidget {
  // Definiuje bezstanowy widżet Expenses
  @override
  Widget build(BuildContext context) {
    // Pobranie instancji CategoryExpensesModel z providera za pomocą kontekstu aplikacji
    final categoryExpensesModel = Provider.of<CategoryExpensesModel>(context);

    // Pobranie mapy z wydatkami dla każdej kategorii z modelu CategoryExpensesModel
    final expenses = categoryExpensesModel.categoryExpenses;

    // Przetwarzamy wydatki, aby połączyć nieznane kategorie pod "Inne"
    final processedExpenses = _processExpenses(expenses);

    // Zwracamy ListView, który wyświetla listę przetworzonych wydatków
    return ListView(
      children: processedExpenses.entries.map((entry) {
        // Iteruje po każdej parze klucz-wartość w mapie
        final category = entry.key; // Pobiera nazwę kategorii
        final expense = entry.value; // Pobiera wartość wydatków dla kategorii

        // Zwraca widget Row, który wyświetla kategorię oraz wartość wydatków
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0), // Dodaje odstępy w pionie
          child: Row(
            children: [
              Container(
                width: 20, // Ustawia szerokość kontenera na 20 pikseli
                height: 20, // Ustawia wysokość kontenera na 20 pikseli
                color: _getCategoryColor(category), // Używa koloru kategorii
              ),
              SizedBox(width: 8), // Dodaje odstęp między kontenerem a tekstem
              Expanded(
                child: Text(
                  '$category: ${expense.toStringAsFixed(2)} PLN', // Wyświetla kategorię i kwotę z dokładnością do dwóch miejsc
                  style: TextStyle(
                    color: Colors.white, // Ustawia kolor tekstu na biały
                    fontSize: 16, // Ustawia rozmiar tekstu na 16 pikseli
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
      'Inne': Colors.grey, // Kolor szary dla kategorii "Inne"
    };

    // Zwraca kolor przypisany do danej kategorii; jeśli kategoria nie jest w mapie, zwraca szary
    return colorMap[category] ?? Colors.grey;
  }

  // Funkcja przetwarzająca wydatki, aby połączyć nieznane kategorie pod "Inne"
  Map<String, double> _processExpenses(Map<String, double> expenses) {
    final processedExpenses = <String,
        double>{}; // Tworzy nową mapę do przechowywania przetworzonych wydatków
    double otherCategorySum =
        0; // Inicjalizuje zmienną do przechowywania sumy dla nieznanych kategorii

    // Iterujemy po wszystkich wydatkach
    expenses.forEach((category, expense) {
      // Jeśli kategoria jest znana (ma zdefiniowany kolor inny niż szary), dodaje ją do mapy
      if (_getCategoryColor(category) != Colors.grey) {
        processedExpenses[category] = (processedExpenses[category] ?? 0) +
            expense; // Dodaje wydatek do istniejącej wartości lub inicjalizuje go
      } else {
        // Jeśli kategoria jest nieznana, dodaje jej wartość do sumy "Inne"
        otherCategorySum += expense;
      }
    });

    // Dodaje kategorię "Inne" tylko jeśli zebrano jakieś wydatki pod nieznanymi kategoriami
    if (otherCategorySum > 0) {
      processedExpenses['Inne'] = (processedExpenses['Inne'] ?? 0) +
          otherCategorySum; // Sumuje wydatki dla kategorii "Inne"
    }

    // Zwraca przetworzoną mapę wydatków
    return processedExpenses;
  }
}
