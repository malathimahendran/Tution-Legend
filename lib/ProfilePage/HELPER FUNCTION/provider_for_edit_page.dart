import 'package:flutter/material.dart';

class ProviderFunction extends ChangeNotifier {
  bool obsecure = false;
  DateTime? date;
  DateTime today = DateTime.now();
  changingTrueOrFalse() {
    obsecure = !obsecure;
    notifyListeners();
  }

  selectingDate({context}) async {
    date = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(2022),
    );
    print(date);

    notifyListeners();
    return date;
  }
}
