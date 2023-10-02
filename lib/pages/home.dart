import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firestore Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Firestore Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> dataFromFirestore = [];
  TextEditingController nombreController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carga los datos de Firestore al iniciar la aplicación
    getChat();
  }

  void getChat() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tb_productos");
    QuerySnapshot mensajes = await collectionReference.get();
    if (mensajes.docs.isNotEmpty) {
      setState(() {
        dataFromFirestore.clear();
      });

      for (var doc in mensajes.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (kDebugMode) {
          print(data);
        }
        setState(() {
          dataFromFirestore.add(data);
        });
      }
    }
  }

  void agregarProducto() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("tb_productos");

      String nombre = nombreController.text;
      String estado = estadoController.text;

      await collectionReference.add({
        'nombre': nombre,
        'estado': estado,
      });

      nombreController.clear();
      estadoController.clear();

      getChat(); // Actualiza la lista de datos desde Firestore
    } catch (e) {
      print("Error al agregar producto: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                getChat();
              },
              child: Text("Obtener Datos de Firestore"),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nombreController,
                    decoration: InputDecoration(labelText: "Nombre"),
                  ),
                  TextFormField(
                    controller: estadoController,
                    decoration: InputDecoration(labelText: "Estado"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      agregarProducto();
                    },
                    child: Text("Agregar Producto"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dataFromFirestore.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title:
                        Text("Nombre: ${dataFromFirestore[index]['nombre']}"),
                    subtitle:
                        Text("Estado: ${dataFromFirestore[index]['estado']}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
