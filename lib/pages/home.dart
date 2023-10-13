import 'dart:ffi';

import 'package:eval_sis22/pages/login_page.dart';
import 'package:eval_sis22/pages/sobrenosotros.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

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

  void _alertClose(){
    QuickAlert.show(context: context,
     type: QuickAlertType.confirm,
     text: 'Deseas salir?',
     confirmBtnText: 'aceptar',
     cancelBtnText: 'cancelar',
     barrierDismissible: false,
     cancelBtnTextStyle: TextStyle()

     );
  }

  void _alertSuccess(){
    QuickAlert.show(context: context, type: QuickAlertType.success);
  }
  List<Map<String, dynamic>> dataFromFirestore = [];
  TextEditingController nombreController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController precioController =
      TextEditingController(); // Agregado para el precio

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
      String precio = precioController.text; // Obtener el precio

      await collectionReference.add({
        'nombre': nombre,
        'estado': estado,
        'precio': precio, // Agregar el precio al documento Firestore
      });

      nombreController.clear();
      estadoController.clear();
      precioController.clear(); // Limpiar el campo de precio

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
                  TextFormField(
                    controller: precioController,
                    decoration:
                        InputDecoration(labelText: "Precio"), // Campo de precio
                  ),
                  ElevatedButton(
                    onPressed: () {
                      agregarProducto();
                    },
                    child: Text("Agregar Producto"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      getChat();
                    },
                    child: Text("Obtener Datos de Firestore"),
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
                    trailing: Text(
                        "Precio: ${dataFromFirestore[index]['precio']}"), // Mostrar el precio
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SobreNosotrosScreen()),
                );
              },
              child: Text('Ir a Sobre nosotros'),
            ),

 ElevatedButton(
              onPressed: () {
                _alertSuccess();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      
                      builder: (context) => LoginScreen()),
                );
              },
 
              child: Text('Ir a login'),
            ),

            ElevatedButton(
              onPressed: () {
                _alertSuccess();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      
                      builder: (context) => LoginScreen()),
                );
              },
 
              child: Text('Cerrar seción'),
            )

          ],
        ),
      ),
    );
  }
}
