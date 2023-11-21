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

<details>
<summary>Tugas 9</summary>

* Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON? <br>
Bisa, jika struktur data JSON yang digunakan sederhana dan tidak butuh diproses. Namun jika data JSON kompleks dan perlu dianalisis lebih lanjut maka model lebih baik. Karena model membatu mengorganisasi struktur data, dan memampukan parsing data, transformasi data dan lain-lain.

* Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter. <br>
Fungsi CookieRequest dari pbp_django_auth.dart adalah untuk mendapat cookie yang dibuat saat user login ke dalam aplikasi. CookieRequest perlu dibagikan ke semua komponen di aplikasi Flutter kan cookie dibutuhkan untuk mempertahankan status login dan juga sinkronisasi data.

* Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.<br>
1. Mengambil data dari JSON dengan melakukan HTTP Request ke server yang menyediakan data JSON. pada Flutter menggunakan metode seperti ```http``` dan untuk membaca file JSON menggunakan ```dart:convert```. Caranya menggunakan ```await http.get(url,headers:{"Content-Type": "application/json"},);```, lalu mendapatkan JSON menggunakan function ```jsonDecode(utf8.decode(response.bodyBytes));```.
2. Setelah dapat datanya, perlu dideserialisasi ke objek Dart agar mudah diakses dan dimanipulasi. Contohnya dengan ```Item.fromJson(d)```.
3. Kemudian penampilan data dapat dilakukan menggunakan widget seperti ```ListView```, ```GridView```, atau ```Text```.

* Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter. <br>
Pertama, install CookieReqquest untuk menggunakan API dari djangonya. Lalu menerima input username dan password. Lalu login ke API sjango, jadi diperiksa apakah username dan password benar dan telah teregistrasi.

* Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing. <br>
Widget baru yang digunakan:
1. ElevatedButton : button dengan tampilan elevated atau mengapung.
2. TextField : menerima input yang dapat merupakan paragraf yang panjang.

* Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial). <br>

1. Buat `django-app` bernama `authentication` pada project Django yang telah kamu buat sebelumnya.

2. Tambahkan `authentication` ke `INSTALLED_APPS` pada *main project* `settings.py` aplikasi Django.

3. Jalankan perintah `pip install django-cors-headers` untuk menginstal _library_ yang dibutuhkan.

4. Tambahkan `corsheaders` ke `INSTALLED_APPS` pada *main project* `settings.py` aplikasi Django.

5. Tambahkan `corsheaders.middleware.CorsMiddleware` pada *main project* `settings.py` aplikasi Django.

6. Tambahkan beberapa variabel berikut ini pada *main project* `settings.py` aplikasi Django.

    ```python
    CORS_ALLOW_ALL_ORIGINS = True
    CORS_ALLOW_CREDENTIALS = True
    CSRF_COOKIE_SECURE = True
    SESSION_COOKIE_SECURE = True
    CSRF_COOKIE_SAMESITE = 'None'
    SESSION_COOKIE_SAMESITE = 'None'
    ```
    
7. Buat sebuah metode _view_ untuk login pada `authentication/views.py`.

	```python
	from django.shortcuts import render
	from django.contrib.auth import authenticate, login as auth_login
	from django.http import JsonResponse
	from django.views.decorators.csrf import csrf_exempt
	
	@csrf_exempt
	def login(request):
	    username = request.POST['username']
	    password = request.POST['password']
	    user = authenticate(username=username, password=password)
	    if user is not None:
	        if user.is_active:
	            auth_login(request, user)
	            # Status login sukses.
	            return JsonResponse({
	                "username": user.username,
	                "status": True,
	                "message": "Login sukses!"
	                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
	            }, status=200)
	        else:
	            return JsonResponse({
	                "status": False,
	                "message": "Login gagal, akun dinonaktifkan."
	            }, status=401)
	
	    else:
	        return JsonResponse({
	            "status": False,
	            "message": "Login gagal, periksa kembali email atau kata sandi."
	        }, status=401)
	```

8. Buat _file_ `urls.py` pada folder `authentication` dan tambahkan URL _routing_ terhadap fungsi yang sudah dibuat dengan _endpoint_ `login/`.

    ```python
	from django.urls import path
	from authentication.views import login
	
	app_name = 'authentication'
	
	urlpatterns = [
	    path('login/', login, name='login'),
	]
    ```

9. Terakhir, tambahkan `path('auth/', include('authentication.urls')),` pada file `snack_supply/urls.py`.

10. Instal *package* yang telah disediakan oleh tim asisten dosen dengan menjalankan perintah berikut di Terminal.

	```bash
	flutter pub add provider
	flutter pub add pbp_django_auth
	```

11. modifikasi _root widget_ untuk menyediakan `CookieRequest` _library_ ke semua _child widgets_ dengan menggunakan `Provider`.

    Ubah lib/main.dart menjadi:

    ```dart
        class MyApp extends StatelessWidget {
        const MyApp({Key? key}) : super(key: key);

        @override
        Widget build(BuildContext context) {
                return Provider(
                create: (_) {
                    CookieRequest request = CookieRequest();
                    return request;
                },
                child: MaterialApp(
                    title: 'Snack Supply',
                    theme: ThemeData(
                        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                        useMaterial3: true,
                    ),
                    home: LoginPage()),
                );
            }
        }
    ```
    Hal ini akan membuat objek `Provider` baru yang akan membagikan _instance_ `CookieRequest` dengan semua komponen yang ada di aplikasi.

12. Buat _file_ `login.dart` dan isi kode berikut:

    ```dart
        import 'package:snack_supply/screens/menu.dart';
        import 'package:flutter/material.dart';
        import 'package:pbp_django_auth/pbp_django_auth.dart';
        import 'package:provider/provider.dart';

        void main() {
        runApp(const LoginApp());
        }

        class LoginApp extends StatelessWidget {
        const LoginApp({super.key});

        @override
        Widget build(BuildContext context) {
            return MaterialApp(
            title: 'Login',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: const LoginPage(),
            );
        }
        }

        class LoginPage extends StatefulWidget {
        const LoginPage({super.key});

        @override
        _LoginPageState createState() => _LoginPageState();
        }

        class _LoginPageState extends State<LoginPage> {
        final TextEditingController _usernameController = TextEditingController();
        final TextEditingController _passwordController = TextEditingController();

        @override
        Widget build(BuildContext context) {
            final request = context.watch<CookieRequest>();
            return Scaffold(
            appBar: AppBar(
                title: const Text('Login'),
            ),
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        labelText: 'Username',
                    ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                    ),
                    obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                    onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        // Cek kredensial
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        // Untuk menyambungkan Android emulator dengan Django pada localhost,
                        // gunakan URL http://10.0.2.2/
                        final response =
                            await request.login("http://localhost:8000/auth/login/", {
                        'username': username,
                        'password': password,
                        });

                        if (request.loggedIn) {
                        String message = response['message'];
                        String uname = response['username'];
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                        ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text("$message Selamat datang, $uname.")));
                        } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                            title: const Text('Login Gagal'),
                            content: Text(response['message']),
                            actions: [
                                TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                    Navigator.pop(context);
                                },
                                ),
                            ],
                            ),
                        );
                        }
                    },
                    child: const Text('Login'),
                    ),
                ],
                ),
            ),
            );
        }
        }
    ```

13. menggunakan website [Quicktype](http://app.quicktype.io/) buat model dari data JSON dari project django waktu itu.

14. Lakukan `flutter pub add http` pada terminal proyek Flutter untuk menambahkan _package_ `http`.

15. Pada file `android/app/src/main/AndroidManifest.xml`, tambahkan kode berikut untuk memperbolehkan akses Internet pada aplikasi Flutter yang sedang dibuat.

    ```xml
    ...
        <application>
        ...
        </application>
        <!-- Required to fetch data from the Internet. -->
        <uses-permission android:name="android.permission.INTERNET" />
    ...
    ```

16. Buat file baru pada folder `lib/screens/list_snack.dart` dan isi kode berikut:
    ```dart
        import 'package:flutter/material.dart';
        import 'package:http/http.dart' as http;
        import 'dart:convert';
        import 'package:snack_supply/models/item.dart';
        import 'package:snack_supply/widgets/left_drawer.dart';

        class ItemPage extends StatefulWidget {
            const ItemPage({Key? key}) : super(key: key);

            @override
            _ItemPageState createState() => _ItemPageState();
        }

        class _ItemPageState extends State<ItemPage> {
        Future<List<Item>> fetchItem() async {
            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
            var url = Uri.parse(
                'http://localhost:8000/json/');
            var response = await http.get(
                url,
                headers: {"Content-Type": "application/json"},
            );

            // melakukan decode response menjadi bentuk json
            var data = jsonDecode(utf8.decode(response.bodyBytes));

            // melakukan konversi data json menjadi object Item
            List<Item> list_Item = [];
            for (var d in data) {
                if (d != null) {
                    list_Item.add(Item.fromJson(d));
                }
            }
            return list_Item;
        }

        @override
        Widget build(BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                title: const Text('Item'),
                ),
                drawer: const LeftDrawer(),
                body: FutureBuilder(
                    future: fetchItem(),
                    builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                            return const Center(child: CircularProgressIndicator());
                        } else {
                            if (!snapshot.hasData) {
                            return const Column(
                                children: [
                                Text(
                                    "Tidak ada data produk.",
                                    style:
                                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                                ),
                                SizedBox(height: 8),
                                ],
                            );
                        } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                            "${snapshot.data![index].fields.name}",
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                            ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text("${snapshot.data![index].fields.amount}"),
                                            const SizedBox(height: 10),
                                            Text(
                                                "${snapshot.data![index].fields.description}")
                                        ],
                                        ),
                                    ));
                            }
                        }
                    }));
            }
        }
    ```

17. Tambahkan halaman `list_snack.dart` ke `widgets/left_drawer.dart` dengan menambahkan kode berikut.

    ```dart
    // Kode ListTile Menu
    ...
    ListTile(
        leading: const Icon(Icons.shopping_basket),
        title: const Text('Daftar Item'),
        onTap: () {
            // Route menu ke halaman produk
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemPage()),
            );
        },
    ),
    ...
    ```
    
18. Ubah fungsi tombol `Lihat Item` pada halaman utama agar mengarahkan ke halaman `ItemPage`. Kamu dapat melakukan _redirection_ dengan menambahkan `else if` setelah kode `if(...){...}` di bagian akhir `onTap: () { }` yang ada pada file `widgets/snack_card.dart`


19. Buatlah sebuah fungsi _view_ baru pada `main/views.py` aplikasi Django kamu dengan potongan kode berikut.

    ```python
        @csrf_exempt
        def create_item_flutter(request):
            if request.method == 'POST':
                
                data = json.loads(request.body)

                new_product = Item.objects.create(
                    user = request.user,
                    name = data["name"],
                    amount = int(data["amount"]),
                    description = data["description"]
                )

                new_product.save()

                return JsonResponse({"status": "success"}, status=200)
            else:
                return JsonResponse({"status": "error"}, status=401)
    ```

20. Tambahkan _path_ baru pada `main/urls.py` dengan kode berikut.

    ```python
    path('create-flutter/', create_item_flutter, name='create_item_flutter'),
    ```

21. Hubungkan halaman `snacklist_form.dart` dengan `CookieRequest` dengan mengganti kode menjadi sebagai berikut:

    ```dart
        import 'dart:convert';

        import 'package:flutter/material.dart';
        import 'package:pbp_django_auth/pbp_django_auth.dart';
        import 'package:provider/provider.dart';
        import 'package:snack_supply/screens/menu.dart';
        import 'package:snack_supply/widgets/left_drawer.dart';

        class SnackFormPage extends StatefulWidget {
            const SnackFormPage({super.key});

            @override
            State<SnackFormPage> createState() => _SnackFormPageState();
        }

        class _SnackFormPageState extends State<SnackFormPage> {
            final _formKey = GlobalKey<FormState>();
            String _name = "";
            int _amount = 0;
            String _description = "";
            @override
            Widget build(BuildContext context) {
            final request = context.watch<CookieRequest>();
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
                // TODO: Tambahkan drawer yang sudah dibuat di sini
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
                                hintText: "Jumlah",
                                labelText: "Jumlah",
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                ),
                            ),
                            onChanged: (String? value) {
                                setState(() {
                                _amount = int.parse(value!);
                                });
                            },
                            validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                return "Jumlah tidak boleh kosong!";
                                }
                                if (int.tryParse(value) == null) {
                                return "Jumlah harus berupa angka!";
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
                                onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                        // Kirim ke Django dan tunggu respons
                                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                        final response = await request.postJson(
                                        "http://localhost:8000/create-flutter/",
                                        jsonEncode(<String, String>{
                                            'name': _name,
                                            'amount': _amount.toString(),
                                            'description': _description,
                                            // TODO: Sesuaikan field data sesuai dengan aplikasimu
                                        }));
                                        if (response['status'] == 'success') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                            content: Text("Item baru berhasil disimpan!"),
                                            ));
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => MyHomePage()),
                                            );
                                        } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Terdapat kesalahan, silakan coba lagi."),
                                            ));
                                        }
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

22. Buatlah sebuah metode _view_ untuk logout pada `authentication/views.py`.

    ```python
    from django.contrib.auth import logout as auth_logout
    ...
    @csrf_exempt
    def logout(request):
        username = request.user.username

        try:
            auth_logout(request)
            return JsonResponse({
                "username": username,
                "status": True,
                "message": "Logout berhasil!"
            }, status=200)
        except:
            return JsonResponse({
            "status": False,
            "message": "Logout gagal."
            }, status=401)
    ```

23. Tambahkan _path_ baru pada `authentication/urls.py` dengan kode berikut.

    ```python
    path('logout/', logout, name='logout'),
    ```

Langkah-langkah berikut akan dilakukan pada kode proyek Flutter.

24. Buka _file_ `lib/widgets/snack_card.dart` dan tambahkan potongan kode berikut. Selesaikan masalah impor *library* setelah menambahkan potongan kode ke dalam _file_ tersebut.

    ```dart
    ...
    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Material(
    ...
    ```

25. Ubah perintah `onTap: () {...}` pada widget `Inkwell` menjadi `onTap: () async {...}` agar widget `Inkwell` dapat melakukan proses logout secara asinkronus.

26. Tambahkan kode berikut ke dalam `async {...}` di bagian akhir:

    ```dart
    ...
	// statement if sebelumnya
    // tambahkan else if baru seperti di bawah ini
    else if (item.name == "Logout") {
            final response = await request.logout(
                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                "http://localhost:8000/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message"),
              ));
            }
          }
    ...
    ```
Terima kasih :D Tiffany Out

</details>