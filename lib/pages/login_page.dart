import 'package:eval_sis22/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickalert/quickalert.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _alertError(){
    QuickAlert.show(context: context, type: QuickAlertType.error);}

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSigning = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  icon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _isSigning ? null : _signIn,
                
                child: _isSigning
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text('Iniciar Sesión'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _alertError();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
//ghghghghgh
//jfdff
//dsffsf
  void _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isSigning = true;
      _errorMessage = ''; // Limpiar  mensaje de error
    });

    try {
      // Iniciar sesión con Firebase Auth
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Autenticación exitosa dirige a la pantalla inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHome()),
      );
    } catch (e) {
      // Manejar errores de autenticación
      print('Error al iniciar sesión: $e');
      setState(() {
        _errorMessage = 'Error al iniciar sesión. Verifica tu correo y contraseña.';
      });
    } finally {
      setState(() {
        _isSigning = false;
      });
    }
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isRegistering = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuario'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  icon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _isRegistering ? null : _register,
                child: _isRegistering
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  } //sdhsfdgsfdghsd

  void _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isRegistering = true;
      _errorMessage = ''; // Limpiar el mensaje de error
    });

    try {
      // Registrar usuario en Firebase Auth
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Registro funcionando

      // Después del registro vamos al login de nuevo
      Navigator.pop(context);
    } catch (e) {
      // Manejar errores de registro
      print('Error al registrar usuario: $e');
      setState(() {
        _errorMessage = 'Error al registrarse. Verifica tu correo y contraseña.';
      });
    } finally {
      setState(() {
        _isRegistering = false;
      });
    }
  }
}


