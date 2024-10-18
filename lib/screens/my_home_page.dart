import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/screens/account.dart';
import 'package:wallet/utils/text_stykes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title}); // Zmienna title jest nieużywana

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.menu), // Ikona trzech poziomych kresek
          color: Colors.white, // Kolor ikony
          onPressed: () {
            // Akcja po kliknięciu ikony menu
            print("Menu icon clicked");
            // Tu można dodać funkcję otwierania menu
          },
        ),
        title: Text(
          'Strona główna',
          style: TextStyles.header,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Ikona dzwoneczka
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
                            backgroundColor: Colors.grey[900], // Kolor przycisku
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
                            'Konto',
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
                            backgroundColor: Colors.grey[900], // Kolor przycisku
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
                            'Budżety i Cele',
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
            const SizedBox(
              height: 12,
            ),

            Container(
              width: 205, // Szerokość przycisku
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Kolor przycisku
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                  'Kwota na koncie',
                  style: TextStyles.body,
                ),
              ),
            ),
            const SizedBox(
              height: 20, // Dodajemy odstęp dla nowego widgetu
            ),
            // Nowy widget na wykres
            Container(
              width: double.infinity,
              height: 500, // Wysokość widgetu
              color: Colors.grey[900], // Kolor tła jako placeholder
              padding: EdgeInsets.only(top: 16), // Opcjonalnie, odstęp od góry
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Ustawienie elementów na całą szerokość
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Rozłożenie tekstu i ikony
                    children: [
                      Text(
                        'Struktura wydatków',
                        style: TextStyles.header,
                        textAlign: TextAlign.left, // Wyrównanie tekstu do lewej
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert), // Ikona trzech kropek
                        color: Colors.white,
                        onPressed: () {
                          print("More options clicked");
                          // Możesz dodać akcję do otwierania menu
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'OSTATNIE 30 DNI',
                    style: TextStyles.body,
                    textAlign: TextAlign.left, // Wyrównanie tekstu do lewej
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
