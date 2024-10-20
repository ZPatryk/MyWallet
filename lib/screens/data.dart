import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/balance_model.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  String _inputValue = ''; // Wartość wpisywana
  int _selectedTabIndex = 0; // Indeks wybranej zakładki (Przychód/Wydatek)

  // Funkcja do dodawania cyfry
  void _addDigit(String digit) {
    setState(() {
      _inputValue += digit;
    });
  }

  // Funkcja do czyszczenia wpisu
  void _clearInput() {
    setState(() {
      _inputValue = '';
    });
  }

  // Zatwierdzenie transakcji i aktualizacja balansu
  void _confirmTransaction(BuildContext context) {
    final balanceModel = Provider.of<BalanceModel>(context, listen: false); // Pobierz model balansu
    double? value = double.tryParse(_inputValue);

    if (value != null) {
      if (_selectedTabIndex == 0) {
        balanceModel.addBalance(value); // Dodaj do balansu
      } else {
        balanceModel.subtractBalance(value); // Odejmij od balansu
      }
    }

    setState(() {
      _inputValue = ''; // Wyczyść po zatwierdzeniu
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budżety i Cele'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTabIndex = 0; // Przychód
                    });
                  },
                  child: Text('PRZYCHÓD'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTabIndex = 1; // Wydatek
                    });
                  },
                  child: Text('WYDATEK'),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('$_inputValue', style: TextStyle(fontSize: 32)),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 12, // 0-9, ., Clear
            itemBuilder: (context, index) {
              if (index == 9) {
                return ElevatedButton(
                  onPressed: () => _addDigit('.'),
                  child: Text('.'),
                );
              } else if (index == 11) {
                return ElevatedButton(
                  onPressed: _clearInput,
                  child: Text('Clear'),
                );
              } else {
                String number = index == 10 ? '0' : (index + 1).toString();
                return ElevatedButton(
                  onPressed: () => _addDigit(number),
                  child: Text(number),
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () => _confirmTransaction(context), // Zatwierdzenie transakcji
            child: Text('Zatwierdź'),
          ),
        ],
      ),
    );
  }
}
