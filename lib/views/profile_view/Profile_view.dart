import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../Themes/Widgets/Appbar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override


  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
            children: [
              ProfileAppBar(
                titulo: "Cuenta",
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.account_circle_rounded,
                size: 140,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Miguel Ángel Vázquez González",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5,),
                      Text("mavg1997@hotmail.com",
                          style: TextStyle(fontSize: 18)),
                    ],
                  )
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Text("Version 0.0.1"),
                  Spacer(),
                  Text(
                    "Cerrar Sesión",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )),
    ));
  }
}
