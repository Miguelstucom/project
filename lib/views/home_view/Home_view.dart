import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Themes/Widgets/Appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool _showContainers = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));
  }

  void _toggleContainers() {
    setState(() {
      _showContainers = !_showContainers;
      if (_showContainers) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _hideContainers() {
    setState(() {
      _showContainers = false;
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedContainer(String imagePath, String title, String description) {
    return SlideTransition(
      position: _offsetAnimation,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/Login',
            arguments: "home",
          );
          _hideContainers();
        },
        child: Container(
          height: 120,
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: _hideContainers,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
              height: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: BottomAppBar(
                height: 70,
                shape: const CircularNotchedRectangle(),
                surfaceTintColor: Colors.white,
                notchMargin: 15.0,
                child: Container(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.history_rounded),
                        onPressed: () {},
                      ),
                      SizedBox(width: 48),
                      IconButton(
                        icon: Icon(Icons.list),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: Colors.white,
                onPressed: _toggleContainers,
                child: Icon(Icons.add),
              ),
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
                              "Quieres escribir algo?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_showContainers)
              GestureDetector(
                onTap: _hideContainers,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAnimatedContainer('assets/images/test1.png', "Tareas", "Organiza todo aquello que tengas que hacer durante el dia"),
                          SizedBox(height: 15),
                          _buildAnimatedContainer('assets/images/test1.png', "Pensamiento", "Organiza todo aquello que tengas que hacer durante el dia"),
                          SizedBox(height: 15),
                          _buildAnimatedContainer('assets/images/test1.png', "Registro ABC", "Organiza todo aquello que tengas que hacer durante el dia"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
