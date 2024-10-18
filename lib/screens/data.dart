import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/screens/account.dart';
import 'package:wallet/screens/my_home_page.dart';
import 'package:wallet/utils/text_stykes.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          toolbarHeight: 60,
          leading: IconButton(
            icon: Icon(Icons.close), // Ikona trzech poziomych kresek
            color: Colors.white, // Kolor ikony
            onPressed: () {
              // Akcja po kliknięciu ikony menu
              print("Menu icon clicked");
              // Tu można dodać funkcję otwierania menu
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.check), // Ikona dzwoneczka
              color: Colors.white,
              onPressed: () {
                print("Notifications icon clicked");
                // Można tu dodać akcję otwierającą powiadomienia
              },
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
                              // Kolor przycisku
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyAccount(),
                                ),
                              );
                            },
                            child: Text(
                              'PRZYCHÓD',
                              style: TextStyles.body,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2, // Wysokość linii
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
                              backgroundColor: Colors.blue,
                              // Kolor przycisku
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(title: ''),
                                ),
                              );
                            },
                            child: Text(
                              'WYDATEK',
                              style: TextStyles.body,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2, // Wysokość linii
                              color: Colors.white,
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
                height:350, // Wysokość widget
                child:
                  Text(
                    'dolar_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
              ),
              Container(),
            ],
          ),
        )
    );
  }
}
