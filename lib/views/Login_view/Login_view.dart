import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  final String title = "Login Page";

  const Login({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode nodeEmail = FocusNode();
  FocusNode nodePass = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nodeEmail.addListener(_updateState);
    nodePass.addListener(_updateState);
  }

  @override
  void dispose() {
    nodeEmail.removeListener(_updateState);
    nodePass.removeListener(_updateState);
    nodeEmail.dispose();
    nodePass.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!nodeEmail.hasFocus && !nodePass.hasFocus)
                    Image.asset(
                      'assets/images/logo.webp',
                      height: 250,
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tienes algo que compartir?",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Construye tu futuro junto a un profesional",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      focusNode: nodeEmail,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          hintText: 'ejemplo@ejemplo.es',
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      focusNode: nodePass,
                      decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          filled: true,
                          hintText: 'Contraseña',
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String username = _usernameController.text;
                        String password = _passwordController.text;
                        if (username == "User") {
                          RegExp passwordRegExp =
                              RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{7,}$');
                          if (passwordRegExp.hasMatch(password)) {
                            Navigator.pushNamed(
                              context,
                              '/Select',
                              arguments: username,
                            );
                            print("Login exitoso------------------");
                          } else {
                            print(
                                "La contraseña debe tener al menos 7 caracteres y contener letras y numeros.");
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error de inicio de sesión'),
                                content: const Text(
                                  'Usuario o contraseña incorrectos',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Aceptar'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "He olvidado la contraseña",
                    style: GoogleFonts.nunitoSans(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Aún no tienes cuenta?",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          " Crear cuenta",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
