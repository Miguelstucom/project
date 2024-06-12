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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo_full_512.png',height: 250,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tienes algo que compartir?",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black,),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Construye tu futuro con un profesional",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(Icons.lock)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25.0),
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
                                  title:
                                  const Text('Error de inicio de sesión'),
                                  content: const Text(
                                      'Usuario o contraseña incorrectos'),
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
                    const SizedBox(height: 15.0),
                    Text(
                      "He olvidado la contraseña",
                      style: GoogleFonts.nunitoSans(color: Colors.blue, fontSize: 16,),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Aún no tienes cuenta?",style: GoogleFonts.nunitoSans(),),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            " Crear cuenta",
                            style: GoogleFonts.nunitoSans(color: Colors.blue,fontSize: 16,),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}