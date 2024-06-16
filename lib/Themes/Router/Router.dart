

import 'package:flutter/material.dart';
import 'package:project/views/Splash_view/Splash_view.dart';

import '../../views/Login_view/Login_view.dart';
import '../../views/Register_view/Register_view.dart';
import '../../views/home_view/Home_view.dart';
import '../../views/wellcome_view/wellcome_view.dart';
import 'Routes.dart';

Map<String,Widget Function(BuildContext)> get appRoutes{
  return{
    Routes.Wellcome: (context) => Wellcome(),
    Routes.Home: (context) => HomePage(),
    Routes.Splash: (context) => const SplashPage(),
    Routes.Login: (context) => const Login(),
    Routes.Register: (context) => const Register(),
  };

}