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

<details>
<summary>Tugas 8</summary>

* Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat! <br>
    - Navigator.push() = menambahkan halaman baru ke stack navigation sehingga user dapat kembali ke halaman sebelumnya dengan menggunakan back.
    - Navigator.pushReplacement() = mengganti halaman pada stack teratas dengan halaman baru tersebut sehingga halaman sebelumnya terhapus dari stack dan tidak dapat kembali ke halaman sebelumnya.
<br>

* Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing! <br>
    1. Container = mengatur properti seperti margin, warna background, padding, dll.
    2. Row & Column = menata widget secara horizontal untuk row dan vertikal untuk column.
    3. ListView = menampilkan list item secara terurut.
    4. Stack = digunakan untuk penumpukan widget.
    5. Expanded & Flexible = memberikan widget ukuran yang flexible dalam tata letak seperti row atau column.
    6. GridView = menampilkan daftar item dalam susunan kolom dan baris.
    7. Sizedbox = mengatur ukuran elemen dalam tata letak yang ada.
    8. Card = membuat tampilan seperti kartu biasa untuk daftar item.
<br>

* Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut! <br>
Saya menggunakan TextFormFirld untuk input nama, harga, dan deskripsi karena paling pas untuk menerima input bentuk teks.
<br>

* Bagaimana penerapan clean architecture pada aplikasi Flutter? <br>
Clean Architecture = pendekatan pengembangan software yang menekankan pemisahan konsep dan tanggung jawab dalam arsitektur aplikasi. Penerapannya menggunakan berbagai lapisan untuk meningkaykan fleksibilitas, pemeliharaan, dan uji coba dari aplikasi. 
Komponen-komponennya adalah:
    1. Entitas = representasi data bisnis yang implementasinya tidak bergantung pada platform.
    2. Use Cases (Interactors) = representasi aturan bisnis spesifik dan operasi yang dapat dilakukan pada entitas.
    3. Interface Pengguna (UI) = menangani interaksi dengan user, biasa berisi widget Flutter dan logika presentasi.
    4. Model Presentasi = mengelola state UI untuk memisahkan tugas presentasi.
    5. Aplikasi = bagian terluar yang mengandung detail implementasi, konfigurasi database, implement repository, dan framework UI.
<br>

* Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial) <br>
    1. Pertama-tama, membuat folder screens dan widgets dalam folder snack_supply/lib. kemudian memindahkan menu.dart ke dalam folder tersebut serta membuat file baru dengan nama snacklist_form.dart. Selain itu membuat folder widgets, kemudian membuat file baru bernama snack_card.dart dan left_drawer.dart.
    2. Mengganti kode pada menu.dart menjadi sebagai berikut:
    ```
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
    ```
    ditambahkan ```drawer: const LeftDrawer(),``` dan memindahkan Class Item, List Color, dan SnackCard ke file snack_card.dart.<br>
    3. Maka snack_card berisi sebagai berikut:
    ```
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
    ```
    menambahkan if, sehingga saat tombol tambah item ditekan akan melakukan navigasi ke MaterialPageRoute yang mencakup SnackFormPage menggunakan Navigator.push. <br>
    4. Kemudian isi snacklist_form.dart dengan kode berikut:
    ```
        import 'package:flutter/material.dart';
        import 'package:snack_supply/widgets/left_drawer.dart';

        class SnackFormPage extends StatefulWidget {
            const SnackFormPage({super.key});

            @override
            State<SnackFormPage> createState() => _SnackFormPageState();
        }

        class _SnackFormPageState extends State<SnackFormPage> {
            final _formKey = GlobalKey<FormState>();
            String _name = "";
            int _price = 0;
            String _description = "";
            @override
            Widget build(BuildContext context) {
                return Scaffold(
                appBar: AppBar(
                    title: const Center(
                    child: Text(
                        'Form Tambah Item',
                    ),
                    ),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                ),
                // Tambahkan drawer yang sudah dibuat di sini
                drawer: const LeftDrawer(),
                body: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Nama Snack",
                                labelText: "Nama Snack",
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                ),
                            ),
                            onChanged: (String? value) {
                                setState(() {
                                _name = value!;
                                });
                            },
                            validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                return "Nama tidak boleh kosong!";
                                }
                                return null;
                            },
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Harga",
                                labelText: "Harga",
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                ),
                            ),
                            onChanged: (String? value) {
                                setState(() {
                                _price = int.parse(value!);
                                });
                            },
                            validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                return "Harga tidak boleh kosong!";
                                }
                                if (int.tryParse(value) == null) {
                                return "Harga harus berupa angka!";
                                }
                                return null;
                            },
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Deskripsi",
                                labelText: "Deskripsi",
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                ),
                            ),
                            onChanged: (String? value) {
                                setState(() {
                                _description = value!; 
                                });
                            },
                            validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                return "Deskripsi tidak boleh kosong!";
                                }
                                return null;
                            },
                            ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.indigo),
                                ),
                                onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                    showDialog(
                                    context: context,
                                    builder: (context) {
                                        return AlertDialog(
                                        title: const Text('Snack berhasil tersimpan'),
                                        content: SingleChildScrollView(
                                            child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                Text('Nama: $_name'),
                                                Text('Price: $_price'),
                                                Text('Description: $_description')
                                            ],
                                            ),
                                        ),
                                        actions: [
                                            TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                                Navigator.pop(context);
                                            },
                                            ),
                                        ],
                                        );
                                    },
                                    );
                                    _formKey.currentState!.reset();
                                }
                                },
                                child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                                ),
                            ),
                            ),
                        ),
                        ]
                    )
                    ),
                ),
                );
            }
        }
    ```  
    ini merupakan tampilan dari page Form saat menekan tombol tambah Item. Terdapat left drawer juga. Menggunakan TextFormField untuk menerima input. Menggunakan padding untuk mengatur tampilan setiap input. Jika form nya sesuai ketentuan (terisi, bukan angka untuk price), maka akan memunculkan dialog box menggunakan showDialog() yang berisi nama, price, dan description. Selain itu textField langsung di-clear kan. Jika belum tepat input-nya maka akan muncul validator. <br>
    5. Terakhir, mengisi left_drawer.dart dengan kode berikut:
    ```
        import 'package:flutter/material.dart';
        import 'package:snack_supply/screens/menu.dart';
        import 'package:snack_supply/screens/snacklist_form.dart';

        class LeftDrawer extends StatelessWidget {
        const LeftDrawer({super.key});

        @override
        Widget build(BuildContext context) {
            return Drawer(
            child: ListView(
                children: [
                const DrawerHeader(
                    decoration: BoxDecoration(
                    color: Colors.indigo,
                    ),
                    child: Column(
                    children: [
                        Text(
                        'Snack Supply',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                        ),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text("Catat seluruh Snack di sini!",
                            // gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            ),
                            ),
                    ],
                    ),
                ),
                // Bagian routing
                ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: const Text('Halaman Utama'),
                    // Bagian redirection ke MyHomePage
                    onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                        ));
                    },
                ),
                ListTile(
                    leading: const Icon(Icons.add_circle),
                    title: const Text('Tambah Item'),
                    // Bagian redirection ke SnackFormPage
                    onTap: () {
                    /*
                    routing ke SnackFormPage di sini,
                    setelah halaman SnackFormPage sudah dibuat.
                    */
                    Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(
                        builder: (context) => SnackFormPage(),
                        ));
                    },
                ),
                ],
            ),
            );
        }
        }
    ```  
    Terdapat Bagian routing menggunakan ListTile() yang adalah button, jika ditekan maka akan pushReplacement ke page yang diinginkan.  


</details>