import 'package:flutter/material.dart';
import 'package:snack_supply/widgets/left_drawer.dart';
import 'package:snack_supply/screens/menu.dart';
import 'package:snack_supply/screens/snacklist_form.dart';

class Item {
  final String name;
  final IconData icon;

  Item(this.name, this.icon);
}

final List<Color> buttonColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
    ];

class SnackCard extends StatelessWidget {
  final Item item;
  final int colorIdx;

  const SnackCard(this.item, this.colorIdx, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColors[colorIdx],
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Tambah Item") {
            // Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup SnackFormPage.
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SnackFormPage()));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}