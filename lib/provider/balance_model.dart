import 'package:flutter/foundation.dart';

class BalanceModel with ChangeNotifier {
  double _balance;

  BalanceModel(this._balance);

  double get balance => _balance;

  void addBalance(double value) {
    _balance += value;
    notifyListeners(); // Aktualizacja stanu, informujemy widżety o zmianie
  }

  void subtractBalance(double value) {
    _balance -= value;
    notifyListeners(); // Informujemy widżety o zmianie
  }
}
