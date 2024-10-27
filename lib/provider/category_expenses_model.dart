import 'package:flutter/foundation.dart';

// Klasa reprezentująca model wydatków w kategoriach
class CategoryExpensesModel with ChangeNotifier {
  // Map do przechowywania wydatków, gdzie kluczem jest nazwa kategorii, a wartością kwota wydatków
  Map<String, double> _categoryExpenses = {};

  // Getter umożliwiający dostęp do wydatków w kategoriach
  Map<String, double> get categoryExpenses => _categoryExpenses;

  // Metoda do dodawania wydatków do określonej kategorii
  void addExpense(double value, String category) {
    // Sprawdzamy, czy kategoria już istnieje w mapie _categoryExpenses
    if (_categoryExpenses.containsKey(category)) {
      // Jeśli kategoria istnieje, dodajemy nową wartość do istniejącej
      _categoryExpenses[category] = _categoryExpenses[category]! + value;
    } else {
      // Jeśli kategoria nie istnieje, dodajemy ją do mapy z podaną wartością
      _categoryExpenses[category] = value;
    }

    // Informujemy wszystkie nasłuchujące widżety o zmianie danych
    notifyListeners();
  }
}
