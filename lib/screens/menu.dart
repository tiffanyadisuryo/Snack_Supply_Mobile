import 'package:flutter/material.dart';
import 'package:snack_supply/screens/snacklist_form.dart';
import 'package:snack_supply/widgets/left_drawer.dart';
import 'package:snack_supply/widgets/snack_card.dart';

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);

    final List<Item> items = [
        Item("Lihat Item", Icons.checklist),
        Item("Tambah Item", Icons.add_circle),
        Item("Logout", Icons.logout),
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
                foregroundColor: Colors.white,
              ),
                // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
              drawer: const LeftDrawer(),
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
                          'PBP Snack Supply', // Text
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
                          return SnackCard(item, idx);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
    }
}