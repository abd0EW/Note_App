import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Notepage2.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class addnote1 extends StatefulWidget {
  String docid;
  int color;
  addnote1({super.key, required this.docid, required this.color});

  @override
  State<addnote1> createState() => _addnote1State();
}

class _addnote1State extends State<addnote1> {
  late int valc = widget.color;
  TextEditingController controller = TextEditingController();
  late CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("noteApp")
      .doc(widget.docid)
      .collection("newNote");

  addNewnote() async {
    await collectionReference.add({'newNote': controller.text, "color1": valc});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        overlayOpacity: 0.0,
        animatedIcon: AnimatedIcons.menu_close,
        activeForegroundColor: Colors.white,
        activeBackgroundColor: Colors.white,
        backgroundColor: Colors.white,

        children: [
          SpeedDialChild(
            onTap: () {
              valc = Colors.blueAccent.value;
            },

            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SpeedDialChild(
            onTap: () {
              valc = Colors.green.value;
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SpeedDialChild(
            onTap: () {
              valc = Colors.red.value;
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SpeedDialChild(
            onTap: () {
              valc = Colors.orange.value;
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
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
                          await addNewnote();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) =>
                                  Notees(docid: widget.docid, valColor: valc),
                            ),
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
                      style: TextStyle(
                        color: Colors.white, // لون الخط أبيض
                        fontSize: 22, // حجم الخط (كبره زي ما تحب)
                        fontWeight: FontWeight.w500, // سمك الخط عشان يبقى واضح
                      ),

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
                          "Note.....",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),

                  /// 🔥 Glass Container
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
