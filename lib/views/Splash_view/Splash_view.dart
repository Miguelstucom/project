import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Themes/Router/Routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
          () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, Routes.Login);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  "https://ideausher.com/wp-content/uploads/2022/08/Flutter-App-Development-Cover.webp",
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: LinearProgressIndicator(
              value: null,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}