// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart ' as ui;
// import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/cubit/cubit/cubit/auth_cubit.dart';
// import 'package:flutter_application_1/screens/Home.dart';
// import 'package:flutter_application_1/screens/cond.dart';

// class SignIn extends StatefulWidget {
//   const SignIn({super.key});

//   @override
//   State<SignIn> createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   @override
//   Widget build(BuildContext context) {
//     // Cond cond = Cond();
//     return Scaffold(
//       appBar: AppBar(),
//       body: SignInScreen(
//         actions: [
//           AuthStateChangeAction<UserCreated>((context, state) async {
//             await cond.sendeEmail();
//             Future.delayed(Duration(seconds: 0), () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => SignIn()),
//               );
//             });

//             // await cond.LogOut();
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text("Account created. Verify your email then login"),
//               ),
//             );
//           }),

//           AuthStateChangeAction<SignedIn>((context, state) async {
//             final st = await cond.verfi();
//             if (st == true) {
//               Navigator.of(
//                 context,
//               ).push(MaterialPageRoute(builder: (context) => HomePage()));
//             } else {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text("please verfied email")));
//             }
//           }),
//         ],
//         providers: [
//           EmailAuthProvider(),
//           GoogleProvider(
//             clientId:
//                 "723596201243-0t6fu4n2nul0mas84foki6d81k5vmimr.apps.googleusercontent.com",
//           ),
//         ],
//       ),
//     );
//   }
// }
