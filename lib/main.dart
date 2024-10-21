import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/provider/balance_model.dart';
import 'package:wallet/screens/my_home_page.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BalanceModel(0.0), // Inicjalizujemy początkowy balans
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
