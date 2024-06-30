import 'package:flutter/material.dart';

import '../../data/model/user.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key, this.titulo});

  final String? titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          if (titulo != null)
            Text(
              titulo!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/Profile',
              );
            },
            icon: Icon(
              Icons.account_circle,
              size: 35,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key, this.titulo,this.user});
  final User? user;
  final String? titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Image.asset(
            'assets/images/logo_nuevo.png',
            height: 40,
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/Profile',
                arguments: user
              );
            },
            icon: Icon(
              Icons.account_circle,
              size: 35,
            ),
          ),
          SizedBox(
            width: 20,
          ),

        ],
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key, this.titulo});

  final String? titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          if (titulo != null)
            Text(
              titulo!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          Spacer(),
        ],
      ),
    );
  }
}
