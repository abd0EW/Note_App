import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/cubit/cubit/cubit/product_cubit.dart';
import 'package:flutter_application_1/cubit/cubit/cubit/note_cubit.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/Home.dart';
import 'package:flutter_application_1/screens/NoteHome.dart';
import 'package:flutter_application_1/screens/home.dart'
    hide AboutApp, HomePage;
import 'package:flutter_application_1/screens/newsing.dart';
import 'package:flutter_application_1/screens/sign_in.dart';
import 'package:flutter_application_1/t.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => NoteCubit())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream sta = FirebaseAuth.instance.authStateChanges();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.cyan,
          elevation: 8,
        ),
      ),
      home: user != null ? Notehome() : Loginn(),
    );
  }
}
