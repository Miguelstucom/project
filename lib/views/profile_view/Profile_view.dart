import 'package:flutter/material.dart';

import '../../Themes/Widgets/Appbar.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/service/api_client.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository(apiClient: ApiClient(httpClient: http.Client()));
    return SafeArea(
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
                      SizedBox(
                        height: 5,
                      ),
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
                  GestureDetector(
                    onTap: () {
                      userRepository.logout();
                      Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
                    },
                    child: Text(
                      "Cerrar Sesión",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
