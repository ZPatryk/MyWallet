import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/provider/balance_model.dart';
import 'package:wallet/provider/category_expenses_model.dart'; // Import nowego modelu
import 'package:wallet/provider/subtract_model.dart';
import 'package:wallet/screens/account.dart';
import 'package:wallet/screens/category.dart';
import 'package:wallet/screens/data.dart';
import 'package:wallet/screens/my_home_page.dart';
import 'package:wallet/utils/category_expenses_model.dart';
import 'package:wallet/utils/expenses.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                BalanceModel(0.0)), // Pierwszy model dla balansu
        ChangeNotifierProvider(
            create: (context) =>
                CategoryExpensesModel()), // Drugi model dla wydatków w kategoriach
        ChangeNotifierProvider(create: (context) => SubtractModel(0.0)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet App',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/account': (context) => MyAccount(),
        '/category': (context) => Category(),
        '/data': (context) => Data(categoryName: ''),
        '/categoryexpenses': (context) => CategoryExpensesPieChart(),
        '/expenses': (context) => Expenses(),
      },
    );
  }
}
