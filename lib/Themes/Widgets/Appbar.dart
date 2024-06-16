import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {

  const Appbar({super.key, this.titulo});
  final String? titulo;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(titulo ?? ""),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back,size: 25,),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}


class  HomeAppbar extends StatelessWidget {

  const HomeAppbar({super.key, this.titulo});
  final String? titulo;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(titulo ?? ""),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back,size: 25,),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
