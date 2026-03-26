import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/new.dart';

class HOmeless extends StatefulWidget {
  const HOmeless({super.key});

  @override
  State<HOmeless> createState() => _HOmelessState();
}

class _HOmelessState extends State<HOmeless> {
  final GlobalKey<FormState> glo = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  // تعريف المرجع هنا أفضل للأداء
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("App");

  // دالة الإضافة بره الـ Build
  Future<void> addUser() async {
    try {
      await collectionReference.add({
        "ageList": [10, 20, 30, 40],
        "name": nameController.text,
        "age": int.tryParse(ageController.text) ?? 0, // تحويل النص لرقم
        "createdAt": FieldValue.serverTimestamp(),
      });
      print("Data Added Successfully");

      // مسح الخانات بعد الإضافة
      nameController.clear();
      ageController.clear();
    } catch (e) {
      print("Error adding data: $e");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Firebase")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: glo,
            child: ListView(
              children: [
                const Text("Add New User", style: TextStyle(fontSize: 20)),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter name" : null,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number, // كيبورد الأرقام فقط
                  decoration: const InputDecoration(labelText: "Age"),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter age" : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    if (glo.currentState!.validate()) {
                      addUser();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyWidget()),
                      );
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Save to Firestore"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
