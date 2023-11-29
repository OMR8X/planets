import 'package:flutter/material.dart';
import 'package:planets/classes/sounds_manager.dart';
import 'package:planets/helpers/colors_h.dart';
import 'package:planets/views/home_view.dart';
import 'package:planets/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SoundsManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: "Quantico",
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: ColorsHelper.greyDrk,
          maximumSize: Size(MediaQuery.sizeOf(context).width - 50, 50),
        )),
      ),
      home: const SplashView(),
    );
  }
}
