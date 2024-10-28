import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/screens/data.dart';
import 'package:wallet/utils/text_styles.dart';

import '../provider/category_expenses_model.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    final categoryExpensesModel = Provider.of<CategoryExpensesModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ikona strzałki wstecz
          color: Colors.white, // Kolor ikony
          onPressed: () {
            Navigator.pushNamed(context, '/'); // Powrót do poprzedniego ekranu
          },
        ),
        title: Text(
          'Szczegóły konta',
          style: TextStyles.header,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            color: Colors.white24,
            child: Center(
              child: Text(
                "Moje wydatki",
                style: TextStyles.header,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categoryExpensesModel.categoryExpenses.length,
              itemBuilder: (context, index) {
                String category = categoryExpensesModel.categoryExpenses.keys
                    .elementAt(index);
                double expense =
                    categoryExpensesModel.categoryExpenses[category]!;

                return ListTile(
                  title: Text(
                    '$category',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    '${expense.toStringAsFixed(2)} PLN',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Plus clicked");
          Navigator.pushNamed(context, '/data');
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
