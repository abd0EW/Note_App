import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? id;
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("App");

  PlatformFile? filePdf;

  void initFirebase() async {
    await FirebaseMessaging.instance.requestPermission();
    await getMess();
  }

  getMess() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BDfLP9BAlXgHcVnOZ4VNDY22a0fuATh56v8WyCkqgYGmhNO3Ur7OB_oN6Jr6YF9_hSu_Mi9pLWZvnwgMdsLF87A",
      );
      if (token != null) {
        print("================================================");
        print("Token is: $token");
        print("================================================");
      } else {
        print("Token is null - Check your Firebase configuration");
      }
    } catch (e) {
      print("Error getting token: $e");
    }
  }

  getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf"],
      withData: true,
    );

    setState(() {
      if (result != null) {
        filePdf = result.files.first;
      }
    });
  }

  File? file;
  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    file = File(image!.path);
    setState(() {
      if (file != null) {
        Image.network(file!.path);
      } else {
        print("error image");
      }
    });
  }

  funBatch() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    DocumentReference doc1 = collectionReference.doc("1");
    DocumentReference doc2 = collectionReference.doc("2");
    DocumentReference doc3 = collectionReference.doc("3");
    batch.set(doc1, {"name": "Abdulrahman", "age": 20});
    batch.set(doc2, {"name": "Ahmed", "age": 21});
    batch.set(doc3, {"name": "Yousef", "age": 22});
    batch.update(doc1, {"age": 100});
    await batch.commit();
  }

  funBase(DocumentReference doc) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot document = await transaction.get(doc);
      if (document.exists) {
        int newAge = document["age"] + 50;
        transaction.update(doc, {"age": newAge});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await funBatch();
        },
        child: Icon(Icons.abc),
      ),
      appBar: AppBar(
        title: MaterialButton(
          onPressed: () async {
            await getMess();
          },
          child: Text("Message"),
        ),
      ),
      body: StreamBuilder(
        stream: collectionReference
            // .orderBy("age", descending: true)
            // .limit(4)
            // .startAt([30])
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Eroor");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircleAvatar();
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    snapshot.data!.docs[index].data().toString().contains(
                          "name",
                        )
                        ? snapshot.data!.docs[index]["name"]
                        : "اسم غير معروف",
                  ),
                  leading: filePdf != null
                      ? Text("${filePdf!.name}")
                      : Text("choose Imaeg"),
                  trailing: InkWell(
                    child: Text(
                      "${snapshot.data!.docs[index]["age"]}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => funBase(
                      FirebaseFirestore.instance
                          .collection("App")
                          .doc(snapshot.data!.docs[index].id),
                    ),
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
    );
  }
}
