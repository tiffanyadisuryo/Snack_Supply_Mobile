import 'package:flutter/material.dart';

class Item {
  final String name;
  final IconData icon;

  Item(this.name, this.icon);
}

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);

    final List<Item> items = [
        Item("Lihat Item", Icons.checklist),
        Item("Tambah Item", Icons.add_circle),
        Item("Logout", Icons.logout),
    ];

    final List<Color> buttonColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
    ];


    @override
    Widget build(BuildContext context) {
        return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Snack Supply',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.indigo,
              ),
              body: SingleChildScrollView(
                // Widget wrapper yang dapat discroll
                child: Padding(
                  padding: const EdgeInsets.all(10.0), // Set padding dari halaman
                  child: Column(
                    // Widget untuk menampilkan children secara vertikal
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                        child: Text(
                          'PBP Snack Supply', // Text yang menandakan Snack Supply
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Grid layout
                      GridView.count(
                        // Container pada card kita.
                        primary: true,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: items.asMap().entries.map((entry) {
                          // Iterasi untuk setiap item
                          final int idx = entry.key;
                          final Item item = entry.value;
                          return Card(item, idx);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
    }
}

final List<Color> buttonColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
    ];

class Card extends StatelessWidget {
  final Item item;
  final int colorIdx;

  const Card(this.item, this.colorIdx, {super.key}); // Constructor

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