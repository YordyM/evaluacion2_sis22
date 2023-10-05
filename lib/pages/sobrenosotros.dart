import 'package:flutter/material.dart';

class SobreNosotrosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina Sobre nosotros'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Agrega una imagen
            Image.asset(
              'images/developers.png', // Reemplaza 'tu_imagen.png' con la ruta de tu imagen
              width: 200, // Ajusta el ancho de la imagen según tus necesidades
            ),
            SizedBox(height: 20), // Espacio vertical entre la imagen y el texto
            Text(
              'Autores:',
              style: TextStyle(
                fontSize:
                    24, // Ajusta el tamaño del texto según tus necesidades
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
                height: 10), // Espacio vertical entre el texto y los autores
            Text(
              'Yordi Isaac Romero Martínez 1',
              style: TextStyle(
                fontSize:
                    18, // Ajusta el tamaño del texto según tus necesidades
              ),
            ),
            Text(
              'Autor 2',
              style: TextStyle(
                fontSize:
                    18, // Ajusta el tamaño del texto según tus necesidades
              ),
            ),
            Text(
              'Autor 3',
              style: TextStyle(
                fontSize:
                    18, // Ajusta el tamaño del texto según tus necesidades
              ),
            ),
          ],
        ),
      ),
    );
  }
}
