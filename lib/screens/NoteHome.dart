import 'dart:io';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/File.dart';
import 'package:flutter_application_1/Notepage2.dart';
import 'package:flutter_application_1/screens/Day.dart';
import 'package:flutter_application_1/screens/add.dart';
import 'package:flutter_application_1/screens/addNote.dart';
import 'package:flutter_application_1/screens/cond.dart';
import 'package:flutter_application_1/screens/edit.dart';
import 'package:flutter_application_1/screens/newsing.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Notehome extends StatefulWidget {
  Notehome({super.key});

  @override
  State<Notehome> createState() => _NotehomeState();
}

class _NotehomeState extends State<Notehome> {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("noteApp");
  Future<void> getBatch(List<QueryDocumentSnapshot> doc) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var id in doc) {
      batch.delete(id.reference);
    }
    await batch.commit();
  }

  SpeedDialChild buildcolor(BuildContext, Color color) {
    return SpeedDialChild(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => addNote(
              valueColor: color.value, // بنبعت قيمة اللون هنا
            ),
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
  void initState() {
    super.initState();
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    return ChangeNotifierProvider(
      create: (context) => Fileclass(),

      child: StreamBuilder<QuerySnapshot>(
        stream: collectionReference
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy("cred", descending: true)
            .snapshots(),
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
          if (!snapshot.hasData) {
            return Center(
              child: Text("No notes yet", style: TextStyle(color: Colors.grey)),
            );
          }

          return Scaffold(
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Consumer(
                            builder: (context, value, child) {
                              File? filed = context.watch<Fileclass>().file;

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: IconButton(
                                  onPressed: () async {
                                    await context.read<Fileclass>().getImage();
                                  },
                                  icon: filed != null
                                      ? Image.file(
                                          filed,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(Icons.person, size: 80),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Abdulrahman Ramzy",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "ramzy@gmail.com",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 22),

                  // 🔹 الخيارات
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text("Settings"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Account"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text("Notifications"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.privacy_tip),
                          title: Text("Privacy Policy"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.delete_sweep),
                          title: Text("Delete Notes"),
                          onTap: () {
                            getBatch(snapshot.data!.docs);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // خلفية داكنة
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: Search());
                  },
                  icon: Icon(Icons.search),
                  color: Colors.white,
                ),
                MaterialButton(
                  onPressed: () async {
                    AwesomeDialog(
                      context: context,

                      desc: "Log_Out ? ",
                      dialogType: DialogType.question,

                      //dialogBackgroundColor: Colors.blueAccent,
                      btnOkOnPress: () async {
                        await auth.logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Loginn(),
                            fullscreenDialog: true,
                          ),
                          (route) => false,
                        );
                      },
                      btnCancelOnPress: () {},
                    ).show();
                  },
                  child: Icon(Icons.logout, color: Colors.white),
                ),
              ],
              title: Text(
                "${Days.getDaataTime()} ",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xff1e293b), // لون AppBar
            ),

            floatingActionButton: SpeedDial(
              overlayOpacity: 0.0,
              animatedIcon: AnimatedIcons.menu_close,
              activeForegroundColor: Colors.white,
              activeBackgroundColor: Colors.white,
              backgroundColor: Colors.white,

              children: [
                buildcolor(context, const Color(0xFF5C7AEA)),
                buildcolor(context, const Color(0xFF7FB77E)),
                buildcolor(context, const Color(0xFFE94560)),
                buildcolor(context, const Color(0xFFF0A500)),
              ],
            ),

            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: Stack(
              children: [
                /// 🔹 Gradient Background
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

                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      var note = snapshot.data!.docs[index];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Notees(
                                docid: snapshot.data!.docs[index].id,
                                valColor: snapshot.data!.docs[index]["color"],
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        onLongPress: () async {
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
                        child: SizedBox(
                          height: 500,

                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            color: Color(snapshot.data!.docs[index]["color"]),
                            child: Stack(
                              children: [
                                Center(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      note['notename'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
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
                                          builder: (context) => Edit1(
                                            docid:
                                                snapshot.data!.docs[index].id,
                                            oldNote: snapshot
                                                .data!
                                                .docs[index]["notename"],

                                            colo: snapshot
                                                .data!
                                                .docs[index]["color"],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
