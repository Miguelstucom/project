import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Themes/Colors/Appcolors.dart';
import '../../Themes/Widgets/Appbar.dart';

class Wellcome extends StatelessWidget {
  const Wellcome({key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.fill,
            height: double.infinity,
          ),

          Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Image.asset('assets/images/logo_nuevo.png',height: 150,),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/Login',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.elevatedButton,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/Register',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.elevatedButton,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Registro',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
