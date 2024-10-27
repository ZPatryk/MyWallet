import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/screens/account.dart';
import 'package:wallet/screens/category.dart';
import '../provider/balance_model.dart';
import '../provider/category_expenses_model.dart';
import '../utils/text_styles.dart';

class Data extends StatefulWidget {
  late final String categoryName;

  Data({required this.categoryName});

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
    final balanceModel = Provider.of<BalanceModel>(context,
        listen: false); // Pobierz model balansu
    final categoryExpensesModel =
        Provider.of<CategoryExpensesModel>(context, listen: false);
    double? value = double.tryParse(_inputValue);

    if (value != null) {
      if (_selectedTabIndex == 0) {
        balanceModel.addBalance(value); // Dodaj do balansu

      } else {
        balanceModel.subtractBalance(value); // Odejmij od balansu
        categoryExpensesModel.addExpense(value, widget.categoryName);
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
        backgroundColor: Colors.blue,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.white,
          onPressed: () {
            print("Menu icon clicked");
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              color: Colors.white,
              onPressed: () {
                _confirmTransaction(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyAccount()),
                );
              }),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  child: Stack(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.indigoAccent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedTabIndex = 0;
                          });
                        },
                        child: Text(
                          'PRZYCHÓD',
                          style: TextStyles.body,
                        ),
                      ),
                      if (_selectedTabIndex == 0)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 3,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: Stack(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.indigoAccent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedTabIndex = 1;
                          });
                        },
                        child: Text(
                          'WYDATEK',
                          style: TextStyles.body,
                        ),
                      ),
                      if (_selectedTabIndex == 1)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 3,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
              height: 220,
              color: Colors.blue,
              child: Center(
                  child: Text('$_inputValue', style: TextStyles.darkheader))),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue[600],
            ),
            child: Center(
              child: Text(
                '${widget.categoryName}', // Dostęp do parametru categoryName
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            color: Colors.blueAccent,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                backgroundColor: Colors.indigoAccent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Category(),
                  ),
                );
              },
              child: Text(
                'Zmień kategorię',
                style: TextStyles.body,
              ),
            ),
          ),
          Container(
            width: double.infinity, // Szerokość kontenera
            height: 450, // Wysokość kontenera
            padding: EdgeInsets.all(1), // Odstępy wewnętrzne
            color: Colors.black87,
            child: GridView.builder(
              shrinkWrap:
                  true, // Grid zajmuje tylko tyle miejsca, ile potrzebuje
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Liczba kolumn w siatce
                mainAxisSpacing: 10, // Odstępy między wierszami
                crossAxisSpacing: 10, // Odstępy między kolumnami
                childAspectRatio: 1.2,
              ),
              itemCount: 12, // 0-9, '.', 'Clear'
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87, // Kolor tła (pomarańczowy)
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(0), // Zaokrąglenie rogów
                    ),
                    minimumSize: Size(100, 100), // Minimalny rozmiar przycisku
                  ),
                  onPressed: () {
                    if (index == 9) {
                      _addDigit('.'); // Dodaj kropkę
                    } else if (index == 10) {
                      _addDigit('0'); // Dodaj cyfrę 0
                    } else if (index == 11) {
                      _clearInput(); // Wyczyść wejście
                    } else {
                      String number = (index + 1).toString(); // Cyfry 1-9
                      _addDigit(number); // Dodaj cyfrę
                    }
                  },
                  child: Text(
                    index == 9
                        ? '.'
                        : (index == 10
                            ? '0'
                            : (index == 11 ? 'Clear' : (index + 1).toString())),
                    style: TextStyles.normalheader, // Kolor tekstu
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
