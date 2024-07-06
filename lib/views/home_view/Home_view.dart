import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../Themes/Widgets/Appbar.dart';
import '../../data/model/user.dart';
import '../History_view/History_view.dart';
import 'Main_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool _showContainers = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  int _currentIndex = 0;
  User? _user;

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
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      setState(() {
        _user = User.fromJson(json.decode(userData));
      });
    }
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

  Widget _buildAnimatedContainer(String imagePath, String title, String description, String route) {
    return SlideTransition(
      position: _offsetAnimation,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            route,
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
                          fontWeight: FontWeight.normal,
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

  Widget _buildPage(int index, User? user) {
    switch (index) {
      case 0:
        return user != null ? MainView() : CircularProgressIndicator();
      case 1:
        return user != null ? HistoryView(user: user) : CircularProgressIndicator();
      case 2:
        return user != null ? HistoryView(user: user) : CircularProgressIndicator();
      case 3:
        return Scaffold(
          body: Center(
            child: Text("Contenido de la página de configuración"),
          ),
        );
      default:
        return Container();
    }
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
                        icon: Icon(Icons.home,),
                        onPressed: () {
                          _selectPage(0);
                        },
                      ),
                      SizedBox(width: 48),
                      IconButton(
                        icon: Icon(Icons.list),
                        onPressed: () {
                          _selectPage(2);
                        },
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
                  HomeAppbar(user: _user),
                  Expanded(
                    child: _buildPage(_currentIndex, _user),
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
                          _buildAnimatedContainer('assets/images/test1.png', "Tareas", "Organiza todo aquello que tengas que hacer durante el dia", '/Tasks'),
                          SizedBox(height: 15),
                          _buildAnimatedContainer('assets/images/test1.png', "Pensamiento", "Organiza todo aquello que tengas que hacer durante el dia", '/Feelings'),
                          SizedBox(height: 15),
                          _buildAnimatedContainer('assets/images/test1.png', "Registro ABC", "Organiza todo aquello que tengas que hacer durante el dia", '/Abc'),
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

  void _selectPage(int newIndex) {
    setState(() {
      if (_currentIndex != newIndex) {
        _currentIndex = newIndex;
      }
    });
  }
}
