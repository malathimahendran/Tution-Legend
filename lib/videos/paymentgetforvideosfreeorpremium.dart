import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutionmaster/ALL%20API%20FOLDER/all_api.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetPaymentDetails extends ChangeNotifier {
  bool? statusCheckingPremiumOrFree;
  getPlanDetails() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      // setState(() {
      var token = userDetails[5];
      print("$token" + "51 line");

      var url = Uri.parse(getPlanDetailsCall);

      var response = await http.get(url, headers: {'Authorization': token});
      var decodeDetailsData = json.decode(response.body);

      // l.e(decodeDetailsData);
      var decode = response.body;
      // l.e(decode);
      var result = decodeDetailsData['result'];
      // l.wtf("$result,homescreenvideodisplayfreepremiumplan");

      statusCheckingPremiumOrFree = decodeDetailsData['status'];
      notifyListeners();
      // l.v(statuscheckingpremiumorfree);
    });
  }
}
