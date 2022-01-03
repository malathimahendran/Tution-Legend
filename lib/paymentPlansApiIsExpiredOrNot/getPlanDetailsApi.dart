import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/ALL%20API%20FOLDER/all_api.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetPlanDetails extends ChangeNotifier {
  var token,
      decodeDetailsData,
      result,
      subscribedDate,
      status1,
      statusForPaymentGetApi,
      endingDate,
      numberOfDaysLeft,
      amount,
      subscribed_id;
  final l = Logger();
  getPlanDetails() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      print("$token" + "51 line");
      var url = Uri.parse(getPlanDetailsCall);
      var response = await http.get(url, headers: {'Authorization': token});
      decodeDetailsData = json.decode(response.body);
      l.e(decodeDetailsData);
      var decode = response.body;
      l.e(decode);
      result = decodeDetailsData['result'];
      l.wtf("$result,jjresult");
      status1 = decodeDetailsData['status'];
      l.v("$status1,status from profile page");
      // if (result != null) {
      //   status = true;
      //   l.i("SDFSFSFSDF");
      // } else {
      //   status = false;
      //   l.i("EEEE");
      // }
      if (result != []) {
        statusForPaymentGetApi = "true";

        l.i("SDFSFSFSDF");
      } else {
        statusForPaymentGetApi = "false";

        l.i("EEEE");
      }
      subscribedDate = result[0]['subscribed_date'].toString().substring(0, 10);
      l.wtf(subscribedDate);

      endingDate =
          DateTime.parse(result[0]['ending_date'].toString().substring(0, 10));

      l.v(endingDate);
      // var bus = DateTime(int.parse(endingDate));

      var cu = DateTime.parse(DateTime.now().toString().substring(0, 10));

      var k = endingDate.difference(cu).inDays;
      notifyListeners();
      l.e("$k,days left in profile page");
      // var k = 0;
      if (k == 0) {
        print("updateapi");
        updatePlanApiIsExpiredOrNot();
      } else {
        numberOfDaysLeft = k;
        l.wtf("$numberOfDaysLeft,141 line plan details");
        amount = result[0]['amount'];

        subscribed_id = result[0]['subscribed_id'];
        l.wtf(amount);
      }
    });
  }

  updatePlanApiIsExpiredOrNot() async {
    var url = Uri.parse(planUpdateApiIsExpiredOrNot);
    var response = await http
        .put(url, body: {"expired": false}, headers: {'Authorization': token});
    var decodeDetails = json.decode(response.body);
    notifyListeners();
    print(decodeDetails);
    print(response.body);
  }
}
