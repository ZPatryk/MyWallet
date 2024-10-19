import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/screens/data.dart';
import 'package:wallet/utils/text_stykes.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context); // Powrót do poprzedniego ekranu
          },
        ),
        title: Text(
          'Szczegóły konta',
          style: TextStyles.header,
        ),
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Plus clicked");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Data(),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
