import 'package:flutter/material.dart';

class Days {
 static String? getDaataTime() {
    DateTime now = DateTime.now();
    switch (now.weekday) {
      case 1:
        return "Mondey";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return null;
    }
  }
}
