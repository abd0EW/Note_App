import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/newsing.dart';
import 'package:flutter_application_1/screens/register1.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0f172a), // لون دارك شيك
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(height: 60),

            // 🔥 Animation في النص
            Center(
              child: Lottie.asset(
                "A/Notebook and Pen animation.json", // عدل المسار عندك
                width: 220,
                height: 220,
              ),
            ),

            SizedBox(height: 20),

            // 🔥 اسم التطبيق
            Center(
              child: Text(
                "MyNotes",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            SizedBox(height: 15),

            // 💬 جملة تحفيزية
            Center(
              child: Text(
                "  All Your Ideas In One Places✨",

                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[300]),
              ),
            ),

            SizedBox(height: 40),

            // 🔥 كارد بسيط
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xff1e293b),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    "Start Writing Now",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your ideas deserve to be saved. Don't lose them.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[400]),
                  ),

                  InkWell(
                    child: Text(
                      "login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (context) => Loginn()));
                    },
                  ),
                  Text("or", style: TextStyle(color: Colors.white)),
                  InkWell(
                    child: Text(
                      "Regisiter",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
