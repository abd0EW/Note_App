import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Fileclass extends ChangeNotifier {
  File? file;
  getImage() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    file = File(image!.path);
    notifyListeners();
  }
}
