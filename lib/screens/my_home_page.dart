import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/balance_model.dart';
import '../provider/category_expenses_model.dart';
import '../utils/text_styles.dart';
import 'account.dart';
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
    final categoryExpensesModel = Provider.of<CategoryExpensesModel>(context);

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAccount(),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAccount(),
                            ),
                          );
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
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Text(
              '${balanceModel.balance} PLN', // Wyświetl balans
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
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
            height: 300, // Określenie rozmiaru kontenera
            child: CategoryExpensesPieChart(), // Wyświetlenie wykresu kołowego
          ),
        ],
      ),
    );
  }
}
