

import 'package:flutter/material.dart';
import 'package:project/views/ABC_view/ABC_view.dart';
import 'package:project/views/Feelings_view/Feelings_view.dart';
import 'package:project/views/Splash_view/Splash_view.dart';
import 'package:project/views/Tasks_view/Tasks_view.dart';

import '../../views/Login_view/Login_view.dart';
import '../../views/Register_view/Register_view.dart';
import '../../views/home_view/Home_view.dart';
import '../../views/profile_view/Profile_view.dart';
import '../../views/wellcome_view/wellcome_view.dart';
import 'Routes.dart';

Map<String,Widget Function(BuildContext)> get appRoutes{
  return{
    Routes.Wellcome: (context) => const Wellcome(),
    Routes.Home: (context) => const HomePage(),
    Routes.Splash: (context) => const SplashPage(),
    Routes.Login: (context) => const Login(),
    Routes.Register: (context) => const Register(),
    Routes.Profile: (context) => const ProfileView(),
    Routes.Tasks: (context) => const TasksWriter(),
    Routes.Feelings: (context) => const  FeelingsWriter(),
    Routes.Abc: (context) => const AbcWriter(),
  };

}