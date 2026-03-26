import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Notepage2.dart';
import 'package:flutter_application_1/screens/edit.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends SearchDelegate {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("noteApp");
  @override
  List<Widget>? buildActions(BuildContext context) {
    //return [IconButton(onPressed: () {}, icon: Icon(Icons.arrow_de))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back, color: Colors.black),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // 1. لو ا
    if (query.trim().isEmpty) {
      return StreamBuilder(
        stream: collectionReference
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error:${e.toString()}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 1.5,
              ),

              itemBuilder: (context, index) {
                Map<String, dynamic> color =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                var checkColor = color.containsKey("color")
                    ? color["color"]
                    : null;
                Color colored = checkColor != null
                    ? Color(checkColor)
                    : Colors.black;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Notees(
                          docid: snapshot.data!.docs[index].id,
                          valColor: colored.value,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    color: colored,

                    child: Center(
                      child: Text(
                        "${snapshot.data?.docs[index]["notename"]}",

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data?.docs.length ?? 0,
            );
          }
          return Text("ni");
        },
      );
    }
    if (!query.isEmpty) {
      return StreamBuilder(
        stream: collectionReference
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error:${e.toString()}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> items = snapshot.data!.docs.where((
              element,
            ) {
              Map<String, dynamic> data =
                  element.data() as Map<String, dynamic>;
              return data["notename"] != null &&
                  data["notename"].contains(query);
            }).toList();
            return GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 1.5,
              ),

              itemBuilder: (context, index) {
                Map<String, dynamic> color =
                    items[index].data() as Map<String, dynamic>;

                var checkColor = color.containsKey("color")
                    ? color["color"]
                    : null;
                Color colored = checkColor != null
                    ? Color(checkColor)
                    : Colors.black;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Notees(
                          docid: snapshot.data!.docs[index].id,
                          valColor: colored.value,
                          // oldNote: snapshot.data!.docs[index]["notename"],
                          // colo: colored.value,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),

                    elevation: 5,
                    color: colored,

                    child: Center(
                      child: Text(
                        "${items[index]["notename"]}",

                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: items.length,
            );
          }
          return Text("ni");
        },
      );
    }
    return Text("f");
  }
}
