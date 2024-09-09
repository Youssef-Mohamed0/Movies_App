import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_final/screens/home_screen.dart';
import 'package:movies_final/screens/splash_screen.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName:(context)=>SplashScreen(),
        HomeScreen.routeName:(context)=>HomeScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
