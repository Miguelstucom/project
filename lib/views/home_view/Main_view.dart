import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/provider/user_provider.dart';
import '../../Themes/Widgets/TaskContainer.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final _user = userProvider.user;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Lista de tareas",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                for (int i = 0; i < (_user?.tasks?.length ?? 0); i++) ...[
                  TaskContainer(
                    task: _user?.tasks![i],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
