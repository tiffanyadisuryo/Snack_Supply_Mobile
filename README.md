# snack_supply

Ini adalah repositori untuk mobile app Snack Supply.

<details>
<summary>Tugas 7</summary>

* Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

    - StatelessWidget :
        1. widget yang tidak memiliki data yang berubah atau bersifat immutable
        2. lebih efisien karena Flutter tidak mempertahankan statusnya
        3. tidak ada state internal yang berubah

    - StatefulWidget :
        1. widget yang memiliki data yang berubah atau bersifat mutable
        2. dapat merespon terhadap perubahan data atau event
        3. ada state internal yang dapat diubah yang memicu pembaruan ulang widget


* Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.
    1. MyApp (StatelessWidget) = sebagai root aplikasi untuk mengkonfigurasi keseluruhan aplikasi termasuk judul, tema, halaman utama.
    2. MaterialApp (Widget) = mengatur jdul aplikasi, menghilangkan debug banner, mengatur tema app dan menentukan page utama.
    3. MyHomePage (StatelessWidget) = menampilkan page utama termasuk AppBar dan GridView
    4. AppBar (Widget) = menampilkan strip atau bar bagian atas yang menunjukan judul.
    5. GridView (Widget) = mengatur tampilan item dalam bentuk grid.
    6. Card (StatelessWidget) = mewakili tiap item dalam grid tersebut. Menampilkan ikon, teks, dan background color dari data yang diberikan.
    7. Material (Widget) = mengatur warna background untuk setiap item di dalam gridnya.
    8. InkWell (Widget) = mengatur area responsif terhadap click pada Material. Menangani action sesuai dengan event. Contoh disini adalah menampilkan Snackbar
    9. Text (Widget) = menampilkan teks dengan style dan warna.
    10. Icon (Widget) = menampilkan ikon
    11. Scaffold (Widget) = mengatur tampilan dasar app termasuk AppBar dan body.
    12. SingleChildScrollView (Widget) = mengatur tampilan scroll.
    13. Padding (Widget) = menambahkan jarak antar elemen
    14. Column (Widget) = menampilkan child secara vertikal
    15. Container (Widget) = membuat alemen persegi panjang.
    16. SnackBar (Widget) = untuk menampilkan pesan semacam notifikasi pada bagian bawah app.

* Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)
    1. Install flutter menggunakan [link berikut](https://docs.flutter.dev/get-started/install/windows)
    2. membuat project dengan nama snack_supply dengan menjalankan sebagai berikut di command prompt:
    ```
        flutter create snack_supply
        cd snack_supply
    ```
    3. pada snack_supply/lib membuat file baru dengan nama menu.dart yang berisi kode berikut:
    ```
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
    ```
    4. mengganti kode yang bernama main.dart di dalam folder yang sama dengan kode berikut:
    ```
        import 'package:flutter/material.dart';
        import 'package:snack_supply/menu.dart';

        void main() {
        runApp(const MyApp());
        }

        class MyApp extends StatelessWidget {
        const MyApp({super.key});

        // This widget is the root of your application.
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
            title: 'Snack Supply',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                useMaterial3: true,
            ),
            home: MyHomePage(),
            );
        }
        }
    ```
    5. Hubungkan smartphone dengan PC menggunakan kabel data, kemudian run sebagai berikut pada command prompt :
    ```
        flutter run
    ```
</details>