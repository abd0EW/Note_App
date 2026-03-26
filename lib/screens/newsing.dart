import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Home.dart';
import 'package:flutter_application_1/screens/NoteHome.dart';
import 'package:flutter_application_1/screens/cond.dart';
import 'package:flutter_application_1/screens/register1.dart';

class Loginn extends StatefulWidget {
  const Loginn({super.key});

  @override
  State<Loginn> createState() => _LoginnState();
}

class _LoginnState extends State<Loginn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> glo = GlobalKey<FormState>();

  AuthService auth = AuthService();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0f172a),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: glo,
            child: Column(
              children: [
                SizedBox(height: 40),

                // 🔥 Title
                Text(
                  "Welcome Back 👋",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.grey[400]),
                ),

                SizedBox(height: 40),

                // 📧 Email
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Email";
                    }
                    if (!value.contains("@")) {
                      return "Enter right Email";
                    }
                  },
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xff1e293b),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // 🔒 Password
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    if (value.length < 5) {
                      return "Enter Strong Password";
                    }
                  },
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xff1e293b),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // 🔥 Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (glo.currentState!.validate()) {
                        try {
                          await auth.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          final ver = await auth.verfifedEmail();
                          if (ver == true)
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Notehome(),
                              ),
                            );
                          else {
                            await auth.sendEmail();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("please verified  Email")),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${e.toString()}")),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3b82f6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // 🔗 Forgot + Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await auth.forPassword(emailController.text);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // 🔥 Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                SizedBox(height: 20),

                // 🔥 Google Button
                GoogleSignInButton(
                  onSignedIn: (credential) {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Notehome()));
                  },
                  clientId:
                      "723596201243-0t6fu4n2nul0mas84foki6d81k5vmimr.apps.googleusercontent.com",
                  loadingIndicator: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
