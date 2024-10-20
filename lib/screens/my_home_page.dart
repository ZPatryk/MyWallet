import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/balance_model.dart';
import 'account.dart';  // Import twojego ekranu "Konto"
import 'data.dart';     // Import twojego ekranu "Budżety i Cele"

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final balanceModel = Provider.of<BalanceModel>(context); // Pobierz balans z Provider

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Strona główna'),
      ),
      body: Column(
        children: [
          // Przyciski nawigujące
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAccount(), // Przejście do ekranu Konto
                      ),
                    );
                  },
                  child: Text('Konto', style: TextStyle(fontSize: 18)),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Data(), // Przejście do ekranu Budżety i Cele
                      ),
                    );
                  },
                  child: Text('Budżety i Cele', style: TextStyle(fontSize: 18)),
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
