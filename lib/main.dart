import 'package:eval_sis22/pages/home.dart';
import 'package:eval_sis22/pages/login_page.dart';
import 'package:eval_sis22/pages/sobrenosotros.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evaluacion2 sis22',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/loginScreen",
          routes: {
      "/home": (context) => const MyHome(),
      "/loginScreen":(context) => const LoginScreen(),
      
      
      },

      
      //home: const MyHomePage(title: 'MY APP YORDY, IDALIA, RENÉ 1111'),
    );
  }
}
