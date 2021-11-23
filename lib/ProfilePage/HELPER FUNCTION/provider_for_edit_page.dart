import 'package:flutter/material.dart';

class ProviderFunction extends ChangeNotifier {
  bool obsecure = false;
  var date;
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
    // ignore: await_only_futures
    // date = await YearPicker(
    //   firstDate: DateTime(2010),
    //   lastDate: DateTime(2022),
    //   selectedDate: DateTime(2021),
    //   onChanged: (value) {},
    // );
    print(date);

    notifyListeners();
    return date;
  }
}
