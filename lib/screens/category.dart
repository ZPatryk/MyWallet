import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/text_styles.dart';
import 'data.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Widget buildStyledContainer(
      IconData icon, String label, Color iconColor, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed, // Cały kontener działa jak przycisk
      child: Container(
        width: double.infinity,
        height: 65,
        alignment: Alignment.centerLeft,
        // Ikona wyrównana do lewej
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        // Margines wewnętrzny
        margin: EdgeInsets.symmetric(vertical: 5),
        // Margines zewnętrzny między kontenerami
        decoration: BoxDecoration(
          color: Colors.grey[900], // Kolor tła
          borderRadius: BorderRadius.circular(0), // Zaokrąglone rogi
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor, // Użycie przekazanego koloru ikony
            ),
            SizedBox(width: 10), // Odstęp między ikoną a tekstem
            Text(
              label,
              style:
                  TextStyle(fontSize: 22, color: Colors.white), // Styl tekstu
            ),
          ],
        ),
      ),
    );
  }

  // Metoda nawigacji do nowego ekranu
  void goToDataClass(String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Data(categoryName: categoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Kategoria',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 30,
            color: Colors.black38,
            //child: Text("Moje wydatki", style: TextStyles.,),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 20,
            //color: Colors.grey[900],
            child: const Text(
              'NAJCZĘŚCIEJ UŻYWANE',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 55,
            color: Colors.grey[900],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 20,
            //color: Colors.grey[900],
            child: const Text(
              'WSZYSTKIE KATEGORIE',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          buildStyledContainer(
            Icons.food_bank_rounded,
            'Jedzenie',
            Colors.green,
            () => goToDataClass('Jedzenie'),
          ),
          buildStyledContainer(
            Icons.shopping_bag_sharp,
            'Zakupy',
            Colors.blue,
            () => goToDataClass('Zakupy'),
          ),
          buildStyledContainer(
            Icons.house,
            'Dom',
            Colors.pink,
            () => goToDataClass('Dom'),
          ),
          buildStyledContainer(
            Icons.directions_car,
            'Samochód',
            Colors.red,
            () => goToDataClass('Samochód'),
          ),
          buildStyledContainer(
            Icons.directions_bus,
            'Transport',
            Colors.orange,
            () => goToDataClass('Transport'),
          ),
          buildStyledContainer(
            Icons.sports_soccer,
            'Sport',
            Colors.teal,
            () => goToDataClass('Sport'),
          ),
          buildStyledContainer(
            Icons.health_and_safety,
            'Zdrowie',
            Colors.purple,
            () => goToDataClass('Zdrowie'),
          ),
          buildStyledContainer(
            Icons.more_horiz,
            'Inne',
            Colors.grey,
            () => goToDataClass('Inne'),
          ),
        ],
      ),
    );
  }
}
