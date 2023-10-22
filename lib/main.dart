import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media/auth/auth_page.dart';
import 'package:mini_social_media/auth/login_or_register.dart';
import 'package:mini_social_media/firebase_options.dart';
import 'package:mini_social_media/pages/home_screen.dart';
import 'package:mini_social_media/pages/profile_screen.dart';
import 'package:mini_social_media/pages/users_screen.dart';

import 'theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      // darkTheme: darkMode,
      home: const AuthPage(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login_register_screen': (context) => const LoginOrRegister(),
        '/profile': (context) => const ProfileScreen(),
        '/users': (context) => const UsersScreen(),
      },
    );
  }
}
