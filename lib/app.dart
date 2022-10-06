import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app_ui/util/const.dart';
import 'package:social_app_ui/util/globalontextservice.dart';
import 'package:social_app_ui/util/theme_config.dart';
import 'package:social_app_ui/views/screens/auth/fuidymainscreen.dart';
import 'package:social_app_ui/views/screens/auth/loginpage.dart';
import 'package:social_app_ui/views/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalContextService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: themeData(ThemeConfig.lightTheme),
      // darkTheme: themeData(ThemeConfig.darkTheme),
      home:  FuidyMainPage() //FuidyMainPage(),
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.sourceSansProTextTheme(
        theme.textTheme,
      ),
    );
  }
}
