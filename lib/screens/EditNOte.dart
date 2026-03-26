import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Notepage2.dart';
import 'package:flutter_application_1/screens/NoteHome.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Edit2 extends StatefulWidget {
  String docid;
  String oldNote;
  int colo;

  String docidnew;
  Edit2({
    super.key,
    required this.docid,
    required this.oldNote,
    required this.docidnew,
    required this.colo,
  });

  @override
  State<Edit2> createState() => _addnote1State();
}

class _addnote1State extends State<Edit2> {
  int? colorval;
  TextEditingController controller = TextEditingController();
  late CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("noteApp")
      .doc(widget.docid)
      .collection("newNote");

  EditNote() async {
    final int colorr = colorval ?? widget.colo;
    await collectionReference
      ..doc(
        widget.docidnew,
      ).update({"newNote": controller.text, "color1": colorr});
    print("Editsuccess");
  }

  @override
  void initState() {
    super.initState();
    controller.text = widget.oldNote;
  }

  SpeedDialChild buildColorChild(BuildContext context, Color color) {
    return SpeedDialChild(
      onTap: () {
        colorval = color.value;
      },
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ), // إطار أبيض خفيف بيدي شياكة
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // خلفية الزرار الخارجي بيضاء
      elevation: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        overlayOpacity: 0.0,
        animatedIcon: AnimatedIcons.list_view,
        activeForegroundColor: Colors.white,
        activeBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        children: [
          buildColorChild(context, const Color(0xFF5C7AEA)),
          buildColorChild(context, const Color(0xFF7FB77E)),
          buildColorChild(context, const Color(0xFFE94560)),
          buildColorChild(context, const Color(0xFFF0A500)),
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
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () async {
                          await EditNote();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Notees(
                                docid: widget.docid,

                                valColor: colorval ?? widget.colo,
                              ),
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
                      style: TextStyle(color: Colors.white),
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
                          "Edit Note.....",
                          style: TextStyle(color: Colors.white),
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
