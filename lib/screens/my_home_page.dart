import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/balance_model.dart';
import '../provider/category_expenses_model.dart';
import '../provider/subtract_model.dart';
import '../utils/expenses.dart';
import '../utils/text_styles.dart';
import '../utils/category_expenses_model.dart'; // Import twojego ekranu "Konto"

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final balanceModel =
        Provider.of<BalanceModel>(context); // Pobierz balans z Provider
    final subtractModel = Provider.of<SubtractModel>(context, listen: false);
    //final categoryExpensesModel = Provider.of<CategoryExpensesModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            print("Menu icon clicked");
            // Add menu opening functionality here
          },
        ),
        title: Text(
          'Strona główna',
          style: TextStyles.header,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              print("Notifications icon clicked");
              // Add notification functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Przyciski nawigujące
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
                          backgroundColor: Colors.grey[900],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          _selectTab(0);
                          Navigator.pushNamed(context, '/account');
                        },
                        child: Text(
                          'Konto',
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
                          backgroundColor: Colors.grey[900],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          _selectTab(1);
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                          'Budżet i cele',
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
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Wyświetlanie balansu
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Saldo: ${balanceModel.balance.toStringAsFixed(2)} zł', // Wyświetl balans
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            height: 300,
            child: Row(
              children: [
                Expanded(
                  flex: 3, // Lewa kolumna zajmuje 3 z 5
                  child: CategoryExpensesPieChart(), // Wykres kołowy
                ),
                SizedBox(width: 16), // Odstęp między kolumnami
                Expanded(
                  flex: 2, // Prawa kolumna zajmuje 1/3 szerokości
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Expenses(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
