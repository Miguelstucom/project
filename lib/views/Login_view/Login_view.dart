import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Themes/Widgets/Appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../data/model/user.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/service/api_client.dart';

class Login extends StatefulWidget {
  final String title = "Login Page";

  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode nodeEmail = FocusNode();
  final FocusNode nodePass = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserRepository userRepository = UserRepository(apiClient: ApiClient(httpClient: http.Client()));

  @override
  void initState() {
    super.initState();
    nodeEmail.addListener(_updateState);
    nodePass.addListener(_updateState);
    checkLoginStatus();
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

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/Home');
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      try {
        final user = await userRepository.login(context,username, password);
        Navigator.pushReplacementNamed(context, '/Home', arguments: user);
        print("Login exitoso");
      } catch (e) {
        final user = await userRepository.login(context,username, password);
        print('Error: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(user.toString()),
              content: const Text('Usuario o contraseña incorrectos'),
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.fill, height: double.infinity),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Image.asset('assets/images/logo.png', height: 150),
                      SizedBox(height: 20),
                      const SizedBox(height: 30),
                      _buildEmailField(),
                      const SizedBox(height: 20.0),
                      _buildPasswordField(),
                      const SizedBox(height: 35.0),
                      _buildLoginButton(),
                      const SizedBox(height: 20.0),
                      _buildForgotPasswordText(),
                      const SizedBox(height: 20),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.mail),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an email';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.lock),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        'Login',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return Text(
      "He olvidado la contraseña",
      style: TextStyle(
        color: Colors.blue,
        fontSize: 18,
      ),
    );
  }
}
