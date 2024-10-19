import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/screens/my_home_page.dart';
import 'package:wallet/utils/text_stykes.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  double _balance = 0.0; // Początkowy balans
  String _inputValue = ''; // Wartość wpisywana za pomocą klawiatury numerycznej
  int _selectedTabIndex = 0; // Indeks wybranej zakładki

  // Funkcja do dodania cyfry do wartości wpisywanej
  void _addDigit(String digit) {
    setState(() {
      _inputValue += digit; // Aktualizacja wartości wpisywanej
    });
  }

  // Funkcja do czyszczenia wpisanej wartości
  void _clearInput() {
    setState(() {
      _inputValue = ''; // Czyszczenie wartości
    });
  }

  // Funkcja do aktualizacji balansu
  void _confirmTransaction() {
    setState(() {
      double? value = double.tryParse(_inputValue); // Próba konwersji wartości
      if (value != null) {
        if (_selectedTabIndex == 0) {
          // Jeśli wybrany przycisk to 'Przychód', dodajemy wartość do balansu
          _balance += value;
        } else {
          // Jeśli wybrany przycisk to 'Wydatek', odejmujemy wartość od balansu
          _balance -= value;
        }
      }
      _inputValue = ''; // Czyszczenie wpisanej wartości po zatwierdzeniu transakcji
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
            icon: Icon(Icons.close), // Ikona zamknięcia (trzy poziome kreski)
            color: Colors.white, // Kolor ikony
            onPressed: () {
              print("Menu icon clicked");
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.check), // Ikona ptaszka jako zatwierdzenie
              color: Colors.white,
              onPressed: () {
                _confirmTransaction(); // Najpierw wywołaj funkcję zatwierdzającą

                // Następnie nawiguj do SummaryPage, przekazując aktualny balans
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(title: '', balance: _balance), // Przekazanie balansu
                  ),
                );
              }, // Zamykamy funkcję onPressed
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Stack(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              backgroundColor: Colors.blue,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedTabIndex = 0; // Wybór zakładki Przychód
                              });
                            },
                            child: Text(
                              'PRZYCHÓD', // Zmienione z INCOME na PRZYCHÓD
                              style: TextStyles.body,
                            ),
                          ),
                          if (_selectedTabIndex == 0)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 2,
                                color: Colors.white, // Linia podkreślająca aktywny przycisk
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
                              backgroundColor: Colors.blue,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedTabIndex = 1; // Wybór zakładki Wydatek
                              });
                            },
                            child: Text(
                              'WYDATEK', // Zmienione z EXPENSE na WYDATEK
                              style: TextStyles.body,
                            ),
                          ),
                          if (_selectedTabIndex == 1)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 2,
                                color: Colors.white, // Linia podkreślająca aktywny przycisk
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.blue,
                width: double.infinity,
                height: 350,
                child: Text(
                  "$_inputValue", // Wyświetlamy bieżąco wprowadzoną wartość
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 kolumny dla przycisków
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: 12, // 12 elementów (cyfry 0-9, kropka, Clear)
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 9) {
                      return ElevatedButton(
                        onPressed: () => _addDigit('.'), // Dodanie kropki do wartości
                        child: const Text('.'),
                      );
                    } else if (index == 11) {
                      return ElevatedButton(
                        onPressed: _clearInput, // Funkcja czyszcząca
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text('Clear'), // Tekst Clear na przycisku
                      );
                    } else {
                      String number =
                      index == 10 ? '0' : (index + 1).toString(); // Cyfry 0-9
                      return ElevatedButton(
                        onPressed: () => _addDigit(number), // Dodawanie cyfry do wartości
                        child: Text(number),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
