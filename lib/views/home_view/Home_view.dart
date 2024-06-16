import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Themes/Colors/Appcolors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.fill,
          height: double.infinity,
        ),
        Scaffold(
          bottomNavigationBar: BottomAppBar(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.history_rounded),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                    child: IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {},
                )),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      "Consejos diarios",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, i) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                                surfaceTintColor: Colors.white,
                                color: Colors.white,
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/test1.png',
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                      ),
                                    )),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Quieres escribir algo?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: AppColors.elevatedButton,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Tareas",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: AppColors.elevatedButton,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Registro ABC",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: AppColors.elevatedButton,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Registro por horas",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
