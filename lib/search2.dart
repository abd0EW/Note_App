import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/EditNOte.dart';

class Search2 extends SearchDelegate {
  Search2({required this.docid});
  String? docid;

  late CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("noteApp")
      .doc(docid)
      .collection("newNote");

  @override
  List<Widget>? buildActions(BuildContext context) {}

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
    if (query.isEmpty) {
      return StreamBuilder(
        stream: collectionReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<QueryDocumentSnapshot> items = snapshot.data!.docs.where((
            element,
          ) {
            Map<String, dynamic> data = element.data() as Map<String, dynamic>;
            return data["newNote"] != null && data["newNote"].contains(query);
          }).toList();
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Edit2(
                        docid: docid!,
                        oldNote: items[index]["newNote"],

                        colo: items[index]["color1"],
                        docidnew: items[index].id,
                      ),
                    ),
                  );
                },
                child: Card(
                  color: Color(snapshot.data!.docs[index]["color1"]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${snapshot.data!.docs[index]["newNote"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }
    /////////////////////////////////////////////////////////////////////
    if (query.isNotEmpty) {
      return StreamBuilder(
        stream: collectionReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> items = snapshot.data!.docs.where((
            element,
          ) {
            Map<String, dynamic> data = element.data() as Map<String, dynamic>;
            return data["newNote"] != null && data["newNote"].contains(query);
          }).toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Edit2(
                        docid: docid!,
                        oldNote: items[index]["newNote"],

                        colo: items[index]["color1"],
                        docidnew: items[index].id,
                      ),
                    ),
                  );
                },
                child: Card(
                  color: Color(items[index]["color1"]),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Text(
                      "${items[index]["newNote"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }
    return Text("data");
  }
}
