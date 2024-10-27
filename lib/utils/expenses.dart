import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/category_expenses_model.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryExpensesModel = Provider.of<CategoryExpensesModel>(context);
    return ListView.builder(
      itemCount: categoryExpensesModel.categoryExpenses.length,
      itemBuilder: (context, index) {
        String category =
            categoryExpensesModel.categoryExpenses.keys.elementAt(index);
        double expense = categoryExpensesModel.categoryExpenses[category]!;

        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Ustawienie do lewej
            children: [
              Text(
                '$category',
                style: TextStyle(color: Colors.brown, fontSize: 10),
              ),
              Text(
                '${expense.toStringAsFixed(2)} PLN',
                style: TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
