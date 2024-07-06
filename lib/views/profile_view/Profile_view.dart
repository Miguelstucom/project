import 'package:flutter/material.dart';

import '../../Themes/Widgets/Appbar.dart';
import '../../data/model/user.dart';
import '../../data/provider/user_provider.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/service/api_client.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;
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
                        "${user?.firstname} ${user?.lastname}" ?? "texto diferente",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(user?.username ?? "No hay información",
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
                    onTap: () async {
                      final userProvider = Provider.of<UserProvider>(context, listen: false);
                      await userProvider.logout();
                      print("Se ha borrado el usuario");
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
