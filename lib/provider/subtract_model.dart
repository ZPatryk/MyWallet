import 'package:flutter/foundation.dart';

class SubtractModel with ChangeNotifier {
  double _substract;

  SubtractModel(this._substract);

  double get substract => _substract;

  void subtractBalance(double value) {
    _substract -= value;
    notifyListeners(); // Informujemy widżety o zmianie
  }
}
