import 'package:flutter/foundation.dart';

class CategoryExpensesModel with ChangeNotifier {
  Map<String, double> _categoryExpenses =
      {}; // Przechowywanie wydatków na kategorie

  Map<String, double> get categoryExpenses =>
      _categoryExpenses; // Getter dla wydatków w kategoriach

  // Odejmowanie balansu z przypisaną kategorią
  void addExpense(double value, String category) {
    if (_categoryExpenses.containsKey(category)) {
      _categoryExpenses[category] = _categoryExpenses[category]! + value;
    } else {
      _categoryExpenses[category] = value;
    }

    notifyListeners(); // Informujemy widżety o zmianie
  }
}
