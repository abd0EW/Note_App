import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Note.dart';
import 'package:flutter_application_1/screens/EditNOte.dart';
import 'package:flutter_application_1/screens/Home.dart';
import 'package:flutter_application_1/screens/NoteHome.dart';
import 'package:flutter_application_1/screens/add.dart';
import 'package:flutter_application_1/screens/addNote.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:flutter_application_1/search2.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Notees extends StatefulWidget {
  String docid;
  int valColor;

  Notees({super.key, required this.docid, required this.valColor});

  @override
  State<Notees> createState() => _NoteesState();
}

class _NoteesState extends State<Notees> {
  late CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("noteApp")
      .doc(widget.docid)
      .collection("newNote");

  delData(List<QueryDocumentSnapshot> doc) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var id in doc) {
      batch.delete(id.reference);
    }
    await batch.commit();
  }

  SpeedDialChild buildColorChild(BuildContext, Color color) {
    return SpeedDialChild(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                addnote1(docid: widget.docid, color: color.value),
          ),
        );
      },
      child: Container(
        height: 28, // صغرنا الحجم شوية عشان الرقة
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
    return StreamBuilder<QuerySnapshot>(
      stream: collectionReference.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error ${snapshot.error}",
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1e293b),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Notehome()),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              SizedBox(width: 10),
              Text(
                "My Notes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(width: 50),
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: Search2(docid: widget.docid),
                  );
                },
                icon: Icon(Icons.search, color: Colors.white, size: 30),
              ),
              SizedBox(width: 20),
              PopupMenuButton(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(200)),

                iconColor: Colors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: MaterialButton(
                        onPressed: () {
                          delData(snapshot.data!.docs);
                        },
                        child: Text(
                          'Delete All Notes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ];
                },
              ),

              Container(width: 20),
            ],
          ),
          ////////////////   ///////   //////////////   //////////////////
          floatingActionButton: SpeedDial(
            overlayOpacity: 0.0,
            animatedIcon: AnimatedIcons.menu_close,
            activeForegroundColor: Colors.white,
            activeBackgroundColor: Colors.white,
            backgroundColor: Colors.black,

            children: [
              buildColorChild(context, const Color(0xFF5C7AEA)), // أزرق شيك
              buildColorChild(context, const Color(0xFF7FB77E)), // أخضر هادي
              buildColorChild(context, const Color(0xFFE94560)), // أحمر مودرن
              buildColorChild(context, const Color(0xFFF0A500)), // برتقالي دافئ
            ],
          ),
          ///////////////////////  body ////////////////////////////////
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.from(
                        alpha: 1,
                        red: 0.616,
                        green: 0.682,
                        blue: 0.816,
                      ),
                      Color.fromRGBO(46, 66, 112, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              /// 🔹 Blur Effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),

              /// 🔹 Content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 Top Bar
                      SizedBox(height: 20),

                      /// 🔹 Notes Grid
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.all(12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1,
                              ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var x = snapshot.data!.docs[index];
                            Map<String, dynamic> color =
                                snapshot.data?.docs[index].data()
                                    as Map<String, dynamic>;
                            var checkColor = color["color1"] ?? null;
                            Color colored = checkColor != null
                                ? Color(checkColor)
                                : Colors.black;
                            return Stack(
                              children: [
                                InkWell(
                                  onLongPress: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      isDense: true,
                                      desc: 'Delete Now ?',

                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await collectionReference
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                    ).show();
                                  },
                                  child: Card(
                                    color: colored,
                                    child: ListView(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            "${snapshot.data!.docs[index]["newNote"]}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: IconButton(
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Edit2(
                                            docid: widget.docid,
                                            oldNote: snapshot
                                                .data!
                                                .docs[index]["newNote"],
                                            docidnew:
                                                snapshot.data!.docs[index].id,
                                            colo: snapshot
                                                .data!
                                                .docs[index]["color1"],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
