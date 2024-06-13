

import 'package:flutter/material.dart';
import 'package:project/views/Splash_view/Splash_view.dart';

import '../../views/Login_view/Login_view.dart';
import '../../views/home_view/homeview.dart';
import 'Routes.dart';

Map<String,Widget Function(BuildContext)> get appRoutes{
  return{
    Routes.Home: (context) => HomePage(),
    Routes.Splash: (context) => const SplashPage(),
    Routes.Login: (context) => const Login(),
  };

}