import 'package:flutter/material.dart';

import '../../Themes/Widgets/Appbar.dart';
import '../../Themes/Widgets/TaskContainer.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const HomeAppbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Consejos diarios",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "En progreso",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TaskContainer(name: "Limpar los platos", date: "Jun 22", done: true,),
                    const SizedBox(
                      height: 15,
                    ),
                    TaskContainer(name: "Ir al gimnasio", date: "Jul 22", done: false,),
                    const SizedBox(
                      height: 15,
                    ),
                    TaskContainer(name: "Estudiar para el examen", date: "Jul 20", done: false,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
