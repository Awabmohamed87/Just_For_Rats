import 'package:flutter/material.dart';
import 'package:just_for_rats/controllers/db_helper.dart';
import 'package:just_for_rats/providers/auth.dart';
import 'package:just_for_rats/providers/user.dart';
import 'package:just_for_rats/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'screens/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Auth()),
    ChangeNotifierProvider(create: (_) => User()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
              bodySmall: TextStyle(color: Colors.white, fontSize: 14),
              bodyMedium:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              labelMedium: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14))),
      home: Provider.of<Auth>(context).isFirstTime
          ? const WelcomeScreen()
          : const HomePage(),
    );
  }
}
