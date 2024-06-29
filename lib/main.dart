import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'Settings/app_settings.dart';
import 'Themes/Router/Router.dart';
import 'Themes/Router/Routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  Intl.defaultLocale = defaultDeviceLanguage;
  //initializeDateFormatting('es-ES', null);
  runApp(DevicePreview(builder: (context) => const Project()));
}

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State {
  late Locale _locale;

  Locale get locale => _locale;

  final _supportedLocales = const [
    Locale('es', 'ES'),
    Locale('en', 'US'),
    Locale('ja', 'JP'),
  ];

  @override
  void initState() {
    super.initState();
    _locale = Locale(defaultLocale, defaultLanguage);
  }

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: _supportedLocales,
      locale: _locale,
      builder: DevicePreview.appBuilder,
      useInheritedMediaQuery: true,
      theme: ThemeData(
        useMaterial3: true,
       fontFamily: 'Satoshi',
        primaryColor: Colors.white
      ),
      routes: appRoutes,
      initialRoute: Routes.Splash,
    );
  }
}
