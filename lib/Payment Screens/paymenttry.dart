import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

import 'package:tutionmaster/HomePage/homeTestScreen.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/ProfilePage/profilepage.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// import 'package:razorpay_flutter/razorpay_flutter.dart';
class PaymentDesign extends StatefulWidget {
  PaymentDesign({Key? key}) : super(key: key);

  @override
  _PaymentDesignState createState() => _PaymentDesignState();
}

class _PaymentDesignState extends State<PaymentDesign> {
  final l = Logger();
  bool isChecked = false;
  bool cardChecked = false;
  int? selected;
  var num1, num3;
  int? num2;
  var formattedDate, paymentId;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var subscriptionId, indexAmount;
  var userEmail, userMobileNo, userName, profileImage, statusForPaymentGetApi;
  var token,
      subscribedId,
      decodeDetailsData1,
      decodeDetailsData,
      decodeDetails,
      result,
      subscribedDate,
      endingDate,
      numberOfDaysLeft,
      amount,
      enrollmentNumber;
  List keys = [];
  var selectedAmount, results;
  Razorpay? razorpay;
  var scroll = CarouselController();
  void initState() {
    super.initState();
    getPaymentPlanApi();
    paymentGetApi();
    formattedDate = formatter.format(now);
    print("$formattedDate,date");
    razorpay = new Razorpay();
    print(razorpay);
    print(21);
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        userName = userDetails[0];
        userEmail = userDetails[1];
        userMobileNo = userDetails[2];
        profileImage = userDetails[4];
        enrollmentNumber = userDetails[7];
        print("$userEmail,$userEmail");
      });
    });
  }

  openCheckout({amount}) async {
    print("zzzzzzzzzzzzzzzzzzzzzzz$amount");
    var options = {
      "key": "rzp_test_HavqZQoR2ijLH5",
      "amount": "${amount}00",
      "name": "Tution Legend",
      "description": "Payment for Tution Legend App",
      "prefill": {"contact": userMobileNo, "email": userEmail},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay!.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  getPaymentPlanApi() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      print("$token" + "27linechapter");
      print(userDetails);

      print("28chapter");
      print(33);

      var url = Uri.parse(
          'http://www.cviacserver.tk/tuitionlegend/home/get_subscription');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      decodeDetailsData = json.decode(response.body);
      print(decodeDetailsData);
      setState(() {
        result = decodeDetailsData['result'];
        print(result);
      });
      print("47payment");
    });
  }

  paymentPostApi({subId}) {
    print("$paymentId,Payment Id");
    print("$subId,subscription Id");
    print("$formattedDate,Date");
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      print("$token" + "27linechapter");
      print(userDetails);
      var url =
          Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/payment');
      var response = await http.post(url, body: {
        'subscription_id': subId.toString(),
        'subscribed_date': formattedDate.toString(),
        'payment_id': paymentId.toString()
      }, headers: {
        'Authorization': token,
      });
      decodeDetailsData = json.decode(response.body);

      print("$decodeDetailsData,120 payment success post api");
      var message = decodeDetailsData['message'];
      l.e(message);
      results = decodeDetailsData['result'];
      l.e("$results,dfdsfsfd");

      print("47payment");
    });
  }

  void handlerPaymentSuccess(PaymentSuccessResponse res) {
    print("Payment success");
    print(res.paymentId);
    paymentId = res.paymentId;
    print(res.orderId);
    print(res.signature);
    print(58);
    print("sfdfffffffffffffffffffffffffff");
    print("$subscriptionId,ssssssssssssss");
    paymentPostApi(subId: subscriptionId);
    Toast.show("Payment success", context, duration: 3);
    Navigator.popAndPushNamed(context, '/homescreen');
  }

  void handlerErrorFailure() {
    print("Payment error");
    Toast.show("Payment error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  paymentGetApi() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      // setState(() {
      token = userDetails[5];
      print("$token" + "51 line");

      var url =
          Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/get_payment');

      var response = await http.get(url, headers: {'Authorization': token});
      decodeDetailsData1 = json.decode(response.body);
      l.e(decodeDetailsData1);
      var decode = response.body;
      l.e(decode);
      var result = decodeDetailsData1['result'];
      l.wtf("$result,rabitttt");
      subscribedId = result[0]['subscribed_id'];

      if (result != []) {
        setState(() {
          statusForPaymentGetApi = "true";
        });
        l.i("SDFSFSFSDF");
      } else {
        setState(() {
          statusForPaymentGetApi = "false";
        });
        l.i("EEEE");
      }
      setState(() {
        subscribedDate =
            result[0]['subscribed_date'].toString().substring(0, 10);
        l.wtf(subscribedDate);
        endingDate = DateTime.parse(
            result[0]['ending_date'].toString().substring(0, 10));

        l.w(endingDate);
        // var bus = DateTime(int.parse(endingDate));

        var cu = DateTime.parse(DateTime.now().toString().substring(0, 10));
        setState(() {
          numberOfDaysLeft = endingDate.difference(cu).inDays;
        });
        l.wtf(numberOfDaysLeft);
        amount = result[0]['amount'];

        l.wtf(amount);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("$statusForPaymentGetApi,Asupathi");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Payment",
            style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.025,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(
                      'assets/ProfilePage/mainbackground.png'))),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: (height - status) * 0.35,
                    width: width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage(
                                'assets/LoginPage/logintop.png'),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                    top: (height - status) * 0.17,
                    left: width * 0.11,
                    child: Container(
                        height: height * 0.1,
                        width: height * 0.1,
                        child: profileImage == null || profileImage == ""
                            ? Container(
                                height: (height - status) * 0.08,
                                width: width * 0.15,
                                color: Colors.redAccent[400],
                                alignment: Alignment.center,
                                child: Text(
                                  userName
                                      .toString()
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ))
                            : Image.network(profileImage)),
                  ),
                  Positioned(
                    top: (height - status) * 0.17,
                    left: width * 0.35,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$userName",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: height * 0.005),
                          Text("Student"),
                          SizedBox(height: height * 0.005),
                          enrollmentNumber == "null"
                              ? Text("")
                              : Text("Enrollment no:$enrollmentNumber")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              statusForPaymentGetApi == "true"
                  ? Container(
                      height: (height - status) * 0.3,
                      width: width,
                      child: Column(
                        children: [
                          Text("Already Subscribed",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          SizedBox(height: height * 0.01),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("      Your Plan Details:",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.pink)),
                          ),
                          SizedBox(height: height * 0.05),
                          Container(
                            height: height * 0.12,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.teal[200],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: height * 0.01),
                                Text(
                                  "Rs.$amount/Yearly",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue[900]),
                                ),
                                Text(
                                    "Your plan is expired within $numberOfDaysLeft days",
                                    style: TextStyle(color: Colors.blue[900])),
                                Text("Subscribed Date: $subscribedDate",
                                    style: TextStyle(color: Colors.blue[900]))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : result == null
                      ? CircularProgressIndicator()
                      : Container(
                          height: (height - status) * 0.3,
                          width: width,
                          // padding: EdgeInsets.symmetric(horizontal: width * 0.10),
                          child: CarouselSlider.builder(
                              itemCount: result.length,
                              carouselController: scroll,
                              itemBuilder: (context, index, pageViewIndex) {
                                // // print("$context,hafjsdgfjsdfjdg");
                                // print("$pageViewIndex,jjjjjjjjjjjjjjjjjjjjjjj");
                                return Container(
                                  width: width,
                                  child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: HexColor('#FFFFFF'),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Payment",
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/ProfilePage/rupee.png'),
                                                Text(
                                                  (result[index]['amount'] ??
                                                          "")
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                                Text(
                                                  "/Yearly",
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Date",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text("    Time",
                                                    style:
                                                        TextStyle(fontSize: 12))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("12 mar 2020",
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                Text("Mon,15.00",
                                                    style:
                                                        TextStyle(fontSize: 12))
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              },
                              options: CarouselOptions(
                                  height: 250,
                                  onPageChanged: (index, method) {
                                    num2 = index;
                                  },
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: true,
                                  initialPage: 0,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height)),
                        ),
              SizedBox(height: height * 0.1),
              statusForPaymentGetApi == "true"
                  ? Container()
                  : CheckboxListTile(
                      activeColor: Colors.red,
                      checkColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 25),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              'Check here to indicate that you have read agree to our,',
                              style: GoogleFonts.poppins(
                                textStyle:
                                    TextStyle(color: Colors.black, fontSize: 9),
                              )),
                          Text(
                            "Terms and Conditions",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      value: isChecked,
                      onChanged: (value) => setState(() {
                        isChecked = value!;
                      }),
                    ),
              SizedBox(height: height * 0.01),
              statusForPaymentGetApi == "true"
                  ? Container()
                  : Container(
                      width: width * 0.8,
                      height: height * 0.05,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: HexColor("#243665"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: isChecked
                              ? () async {
                                  var amount =
                                      await hello(gettingTheIndex: num2);
                                  l.wtf(amount);
                                  openCheckout(amount: amount);
                                }
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          content: Text(
                                              'Please tick the checkbox')));
                                },
                          child: Text("Subscribe Now",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(color: Colors.white),
                              ))),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  hello({int? gettingTheIndex}) {
    if (gettingTheIndex == null) {
      l.w(result[0]['amount']);
      subscriptionId = result[0]['subscription_id'];
      return result[0]['amount'];
    } else {
      l.w(result[gettingTheIndex]['amount']);
      subscriptionId = result[gettingTheIndex]['subscription_id'];
      return result[gettingTheIndex]['amount'];
    }
  }
}
// import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:toast/toast.dart';

// import 'package:tutionmaster/HomePage/homeTestScreen.dart';
// import 'package:tutionmaster/HomePage/homescreen.dart';
// import 'package:tutionmaster/ProfilePage/profilepage.dart';
// import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:tutionmaster/paymentPlansApiIsExpiredOrNot/getPlanDetailsApi.dart';

// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// class PaymentDesign extends StatefulWidget {
//   PaymentDesign({Key? key}) : super(key: key);

//   @override
//   _PaymentDesignState createState() => _PaymentDesignState();
// }

// class _PaymentDesignState extends State<PaymentDesign> {
//   final l = Logger();
//   bool isChecked = false;
//   bool cardChecked = false;
//   int? selected;
//   var num1, num3;
//   int? num2;
//   var formattedDate, paymentId;
//   var now = new DateTime.now();
//   var formatter = new DateFormat('yyyy-MM-dd');
//   var subscriptionId, indexAmount;
//   var userEmail,
//       userMobileNo,
//       userName,
//       profileImage,
//       // statusForPaymentGetApi,
//       enrollmentNumber;
//   var token,
//       // subscribedId,
//       decodeDetailsData1,
//       // decodeDetailsData,
//       decodeDetails,
//       resultForSubscriptionPlan;
//   // result,
//   // subscribedDate,
//   // endingDate,
//   // numberOfDaysLeft,
//   // amount;
//   List keys = [];
//   var selectedAmount, results;
//   Razorpay? razorpay;
//   var scroll = CarouselController();
//   void initState() {
//     super.initState();
//     getPaymentPlanApi();
//     Provider.of<GetPlanDetails>(context, listen: false).getPlanDetails();
//     formattedDate = formatter.format(now);
//     print("$formattedDate,date");
//     razorpay = new Razorpay();
//     print(razorpay);
//     print(21);
//     razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
//     razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
//     razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
//     Shared().shared().then((value) async {
//       var userDetails = await value.getStringList('storeData');
//       setState(() {
//         userName = userDetails[0];
//         userEmail = userDetails[1];
//         userMobileNo = userDetails[2];
//         profileImage = userDetails[4];
//         enrollmentNumber = userDetails[7];
//         print("$userEmail,$userEmail");
//       });
//     });
//   }

//   openCheckout({amount}) async {
//     print("zzzzzzzzzzzzzzzzzzzzzzz$amount");
//     var options = {
//       "key": "rzp_test_HavqZQoR2ijLH5",
//       "amount": "${amount}00",
//       "name": "Tution Legend",
//       "description": "Payment for Tution Legend App",
//       "prefill": {"contact": userMobileNo, "email": userEmail},
//       "external": {
//         "wallets": ["paytm"]
//       }
//     };

//     try {
//       razorpay!.open(options);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   getPaymentPlanApi() {
//     Shared().shared().then((value) async {
//       var userDetails = await value.getStringList('storeData');
//       token = userDetails[5];
//       print("$token" + "27linechapter");
//       print(userDetails);

//       print("28chapter");
//       print(33);

//       var url = Uri.parse(
//           'http://www.cviacserver.tk/tuitionlegend/home/get_subscription');
//       var response = await http.get(url, headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': token,
//       });
//       var decodeDetailsData = json.decode(response.body);
//       print(decodeDetailsData);
//       setState(() {
//         resultForSubscriptionPlan = decodeDetailsData['result'];
//         print("$resultForSubscriptionPlan,rssssssssssssssssssssssssss");
//       });
//       print("47payment");
//     });
//   }

//   paymentPostApi({subId}) {
//     print("$paymentId,Payment Id");
//     print("$subId,subscription Id");
//     print("$formattedDate,Date");
//     Shared().shared().then((value) async {
//       var userDetails = await value.getStringList('storeData');
//       token = userDetails[5];
//       print("$token" + "27linechapter");
//       print(userDetails);
//       var url =
//           Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/payment');
//       var response = await http.post(url, body: {
//         'subscription_id': subId.toString(),
//         'subscribed_date': formattedDate.toString(),
//         'payment_id': paymentId.toString()
//       }, headers: {
//         'Authorization': token,
//       });
//       var decodeDetailsData = json.decode(response.body);

//       print("$decodeDetailsData,120 payment success post api");
//       var message = decodeDetailsData['message'];
//       l.e(message);
//       results = decodeDetailsData['result'];
//       l.e("$results,dfdsfsfd");

//       print("47payment");
//     });
//   }

//   void handlerPaymentSuccess(PaymentSuccessResponse res) {
//     print("Payment success");
//     print(res.paymentId);
//     paymentId = res.paymentId;
//     print(res.orderId);
//     print(res.signature);
//     print(58);
//     print("sfdfffffffffffffffffffffffffff");
//     print("$subscriptionId,ssssssssssssss");
//     paymentPostApi(subId: subscriptionId);
//     Toast.show("Payment success", context, duration: 3);
//     Navigator.popAndPushNamed(context, '/homescreen');
//   }

//   void handlerErrorFailure() {
//     print("Payment error");
//     Toast.show("Payment error", context);
//   }

//   void handlerExternalWallet() {
//     print("External Wallet");
//     Toast.show("External Wallet", context);
//   }

//   // paymentGetApi() {
//   //   Shared().shared().then((value) async {
//   //     var userDetails = await value.getStringList('storeData');
//   //     // setState(() {
//   //     token = userDetails[5];
//   //     print("$token" + "51 line");

//   //     var url =
//   //         Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/get_payment');

//   //     var response = await http.get(url, headers: {'Authorization': token});
//   //     decodeDetailsData1 = json.decode(response.body);
//   //     l.e(decodeDetailsData1);
//   //     var decode = response.body;
//   //     l.e(decode);
//   //     var result = decodeDetailsData1['result'];
//   //     l.wtf("$result,rabitttt");
//   //     subscribedId = result[0]['subscribed_id'];

//   //     if (result != []) {
//   //       setState(() {
//   //         statusForPaymentGetApi = "true";
//   //       });
//   //       l.i("SDFSFSFSDF");
//   //     } else {
//   //       setState(() {
//   //         statusForPaymentGetApi = "false";
//   //       });
//   //       l.i("EEEE");
//   //     }
//   //     setState(() {
//   //       subscribedDate =
//   //           result[0]['subscribed_date'].toString().substring(0, 10);
//   //       l.wtf(subscribedDate);
//   //       endingDate = DateTime.parse(
//   //           result[0]['ending_date'].toString().substring(0, 10));

//   //       l.w(endingDate);
//   //       // var bus = DateTime(int.parse(endingDate));

//   //       var cu = DateTime.parse(DateTime.now().toString().substring(0, 10));
//   //       setState(() {
//   //         numberOfDaysLeft = endingDate.difference(cu).inDays;
//   //       });
//   //       l.wtf(numberOfDaysLeft);
//   //       amount = result[0]['amount'];

//   //       l.wtf(amount);
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     print(
//         "${Provider.of<GetPlanDetails>(context, listen: false).statusForPaymentGetApi},Asupathi");
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var status = MediaQuery.of(context).padding.top;
//     final orientation = MediaQuery.of(context).orientation;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//           ),
//           title: Text(
//             "Payment",
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: height * 0.025,
//                 fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           centerTitle: true,
//         ),
//         extendBodyBehindAppBar: true,
//         body: Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: ExactAssetImage(
//                       'assets/ProfilePage/mainbackground.png'))),
//           width: double.infinity,
//           height: double.infinity,
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: (height - status) * 0.35,
//                     width: width,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: ExactAssetImage(
//                                 'assets/LoginPage/logintop.png'),
//                             fit: BoxFit.fill)),
//                   ),
//                   Positioned(
//                     top: (height - status) * 0.17,
//                     left: width * 0.11,
//                     child: Container(
//                         height: height * 0.1,
//                         width: height * 0.1,
//                         child: profileImage == null || profileImage == ""
//                             ? Container(
//                                 height: (height - status) * 0.08,
//                                 width: width * 0.15,
//                                 color: Colors.redAccent[400],
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   userName
//                                       .toString()
//                                       .substring(0, 1)
//                                       .toUpperCase(),
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 30),
//                                 ))
//                             : Image.network(profileImage)),
//                   ),
//                   Positioned(
//                     top: (height - status) * 0.17,
//                     left: width * 0.35,
//                     child: Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "$userName",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           SizedBox(height: height * 0.005),
//                           Text("Student"),
//                           SizedBox(height: height * 0.005),
//                           enrollmentNumber == "null"
//                               ? Text("")
//                               : Text("Enrollment no:$enrollmentNumber")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Provider.of<GetPlanDetails>(context, listen: false).amount != null
//                   // statusForPaymentGetApi == "true"
//                   ? Container(
//                       height: (height - status) * 0.3,
//                       width: width,
//                       child: Column(
//                         children: [
//                           Text("Already Subscribed",
//                               style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue)),
//                           SizedBox(height: height * 0.01),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text("      Your Plan Details:",
//                                 style: TextStyle(
//                                     fontSize: 15, color: Colors.pink)),
//                           ),
//                           SizedBox(height: height * 0.05),
//                           Container(
//                             height: height * 0.12,
//                             width: width * 0.9,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Colors.teal[200],
//                             ),
//                             child: Column(
//                               children: [
//                                 SizedBox(height: height * 0.01),
//                                 Text(
//                                   "Rs.${Provider.of<GetPlanDetails>(context, listen: true).amount}/Yearly",
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.blue[900]),
//                                 ),
//                                 Text(
//                                     "Your plan is expired within ${Provider.of<GetPlanDetails>(context, listen: true).numberOfDaysLeft} days",
//                                     style: TextStyle(color: Colors.blue[900])),
//                                 Text(
//                                     "Subscribed Date: ${Provider.of<GetPlanDetails>(context, listen: true).subscribedDate}",
//                                     style: TextStyle(color: Colors.blue[900]))
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : resultForSubscriptionPlan == null
//                       ? CircularProgressIndicator()
//                       : Container(
//                           height: (height - status) * 0.3,
//                           width: width,
//                           // padding: EdgeInsets.symmetric(horizontal: width * 0.10),
//                           child: CarouselSlider.builder(
//                               itemCount: resultForSubscriptionPlan.length,
//                               carouselController: scroll,
//                               itemBuilder: (context, index, pageViewIndex) {
//                                 // // print("$context,hafjsdgfjsdfjdg");
//                                 // print("$pageViewIndex,jjjjjjjjjjjjjjjjjjjjjjj");
//                                 return Container(
//                                   width: width,
//                                   child: Card(
//                                       elevation: 5,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       color: HexColor('#FFFFFF'),
//                                       child: Padding(
//                                         padding: EdgeInsets.all(10),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               "Payment",
//                                               style: TextStyle(
//                                                 fontSize: 17,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: height * 0.01,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Image.asset(
//                                                     'assets/ProfilePage/rupee.png'),
//                                                 Text(
//                                                   (resultForSubscriptionPlan[
//                                                                   index]
//                                                               ['amount'] ??
//                                                           "")
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 30),
//                                                 ),
//                                                 Text(
//                                                   "/Yearly",
//                                                 )
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: height * 0.01,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Text(
//                                                   "Date",
//                                                   style:
//                                                       TextStyle(fontSize: 12),
//                                                 ),
//                                                 Text("    Time",
//                                                     style:
//                                                         TextStyle(fontSize: 12))
//                                               ],
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Text("12 mar 2020",
//                                                     style: TextStyle(
//                                                         fontSize: 12)),
//                                                 Text("Mon,15.00",
//                                                     style:
//                                                         TextStyle(fontSize: 12))
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       )),
//                                 );
//                               },
//                               options: CarouselOptions(
//                                   height: 250,
//                                   onPageChanged: (index, method) {
//                                     num2 = index;
//                                   },
//                                   enableInfiniteScroll: false,
//                                   enlargeCenterPage: true,
//                                   initialPage: 0,
//                                   enlargeStrategy:
//                                       CenterPageEnlargeStrategy.height)),
//                         ),
//               SizedBox(height: height * 0.1),
//               Provider.of<GetPlanDetails>(context, listen: false)
//                           .statusForPaymentGetApi ==
//                       "true"
//                   ? Container()
//                   : CheckboxListTile(
//                       activeColor: Colors.red,
//                       checkColor: Colors.white,
//                       contentPadding: EdgeInsets.only(left: 25),
//                       controlAffinity: ListTileControlAffinity.leading,
//                       title: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                               'Check here to indicate that you have read agree to our,',
//                               style: GoogleFonts.poppins(
//                                 textStyle:
//                                     TextStyle(color: Colors.black, fontSize: 9),
//                               )),
//                           Text(
//                             "Terms and Conditions",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               decoration: TextDecoration.underline,
//                               fontSize: 10,
//                             ),
//                           )
//                         ],
//                       ),
//                       value: isChecked,
//                       onChanged: (value) => setState(() {
//                         isChecked = value!;
//                       }),
//                     ),
//               SizedBox(height: height * 0.01),
//               Provider.of<GetPlanDetails>(context, listen: true)
//                           .statusForPaymentGetApi ==
//                       "true"
//                   ? Container()
//                   : Container(
//                       width: width * 0.8,
//                       height: height * 0.05,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               primary: HexColor("#243665"),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20))),
//                           onPressed: isChecked
//                               ? () async {
//                                   var amount =
//                                       await hello(gettingTheIndex: num2);
//                                   l.wtf(amount);
//                                   openCheckout(amount: amount);
//                                 }
//                               : () {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                           duration: Duration(seconds: 1),
//                                           behavior: SnackBarBehavior.floating,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                           ),
//                                           content: Text(
//                                               'Please tick the checkbox')));
//                                 },
//                           child: Text("Subscribe Now",
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(color: Colors.white),
//                               ))),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   hello({int? gettingTheIndex}) {
//     if (gettingTheIndex == null) {
//       l.w(Provider.of<GetPlanDetails>(context, listen: false).result[0]
//           ['amount']);
//       subscriptionId = Provider.of<GetPlanDetails>(context, listen: false)
//           .result[0]['subscription_id'];
//       return Provider.of<GetPlanDetails>(context, listen: false).result[0]
//           ['amount'];
//     } else {
//       l.w(Provider.of<GetPlanDetails>(context, listen: false)
//           .result[gettingTheIndex]['amount']);
//       subscriptionId = Provider.of<GetPlanDetails>(context, listen: false)
//           .result[gettingTheIndex]['subscription_id'];
//       return Provider.of<GetPlanDetails>(context, listen: false)
//           .result[gettingTheIndex]['amount'];
//     }
//   }
// }
