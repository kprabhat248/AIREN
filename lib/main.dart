import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'chat_screen.dart';
import 'splash_screen.dart'; // import the splash screen widget here

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: 'AIREN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
        backgroundColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[800],
        cardColor: Colors.grey[700],
        dividerColor: Colors.grey[600],
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.greenAccent,
        ),
      ),
      themeMode: ThemeMode.system,
      // Use Splash screen widget as the initial route
      initialRoute: SplashScreen.id,
      routes: {
        ChatScreen.id: (context) => const ChatScreen(),
        SplashScreen.id: (context) => SplashScreen(),
      },
    );
  }
}
