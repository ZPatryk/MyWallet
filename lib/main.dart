import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/provider/balance_model.dart';
import 'package:wallet/provider/category_expenses_model.dart'; // Import nowego modelu
import 'package:wallet/screens/my_home_page.dart';

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
      home: MyHomePage(),
    );
  }
}
