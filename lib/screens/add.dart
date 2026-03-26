import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/NoteHome.dart';

class addNote extends StatefulWidget {
  int valueColor;
  addNote({super.key, required this.valueColor});

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  GlobalKey<FormState> glo = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("noteApp");
    Future add() async {
      return collectionReference.add({
        "notename": controller.text,
        "id": FirebaseAuth.instance.currentUser!.uid,
        "color": widget.valueColor,
        "cred": FieldValue.serverTimestamp(),
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1e293b), Color(0xff0f172a)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 🔥 Blur Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 202, sigmaY: 20),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
          //
          /// 🔥 Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 🔹 Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () async {
                          await add();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Notehome()),
                            (route) => false,
                          );
                        },
                        icon: Icon(Icons.check, color: Colors.white),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Container(
                    width: 550,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),

                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      // expands: true,
                      controller: controller,

                      cursorColor: Colors.white,

                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,

                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hint: Text(
                          "Titile Note...",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
