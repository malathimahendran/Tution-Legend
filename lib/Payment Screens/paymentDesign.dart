// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:logger/logger.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:toast/toast.dart';
// import 'package:tutionmaster/HomePage/homeTestScreen.dart';
// import 'package:tutionmaster/HomePage/homescreen.dart';
// import 'package:tutionmaster/ProfilePage/profilepage.dart';
// import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

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
//   var formattedDate, paymentId;
//   var now = new DateTime.now();
//   var formatter = new DateFormat('yyyy-MM-dd');
//   var subscriptionId, indexAmount;
//   var userEmail, userMobileNo, userName, profileImage;
//   var token, decodeDetailsData, decodeDetails, result, enrollmentNumber;
//   List keys = [];
//   var selectedAmount, results;
//   Razorpay? razorpay;
//   void initState() {
//     super.initState();
//     // getPaymentPlanApi();
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
//       decodeDetailsData = json.decode(response.body);
//       print(decodeDetailsData);
//       setState(() {
//         result = decodeDetailsData['result'];
//         print(result);
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
//       decodeDetailsData = json.decode(response.body);
//       print("$decodeDetailsData,120 payment success post api");
//       setState(() {
//         results = decodeDetailsData['result'];
//         print(results);
//       });
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

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var status = MediaQuery.of(context).padding.top;
//     final orientation = MediaQuery.of(context).orientation;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           "Payment",
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: height * 0.025,
//               fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         centerTitle: true,
//       ),
//       extendBodyBehindAppBar: true,
//       body: result == null
//           ? Center(child: CircularProgressIndicator())
//           : Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: ExactAssetImage(
//                           'assets/ProfilePage/mainbackground.png'))),
//               width: double.infinity,
//               height: double.infinity,
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         height: (height - status) * 0.35,
//                         width: width,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: ExactAssetImage(
//                                     'assets/LoginPage/logintop.png'),
//                                 fit: BoxFit.fill)),
//                       ),
//                       Positioned(
//                         top: (height - status) * 0.18,
//                         left: width * 0.13,
//                         child: Container(
//                             height: height * 0.07,
//                             width: height * 0.07,
//                             child: profileImage == null || profileImage == ""
//                                 ? Container(
//                                     height: (height - status) * 0.08,
//                                     width: width * 0.15,
//                                     color: Colors.redAccent[400],
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       userName
//                                           .toString()
//                                           .substring(0, 1)
//                                           .toUpperCase(),
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 30),
//                                     ))
//                                 : Image.network(profileImage)),
//                       ),
//                       Positioned(
//                         top: (height - status) * 0.17,
//                         left: width * 0.35,
//                         child: Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "$userName",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                               SizedBox(height: height * 0.005),
//                               Text("Student"),
//                               SizedBox(height: height * 0.005),
//                               Text("Enrollment no:$enrollmentNumber")
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Flexible(
//                     child: Container(
//                       height: (height - status) * 0.3,
//                       width: width,
//                       padding: EdgeInsets.symmetric(horizontal: width * 0.10),
//                       child: ListView.builder(
//                         itemExtent: width * 0.8,
//                         scrollDirection: Axis.horizontal,
//                         itemCount: result.length,
//                         physics: PageScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           print("$index,268 line payment");
//                           indexAmount = result[index]['amount'];
//                           print("$result,269 lineee");
//                           return Container(
//                             width: width,
//                             child: Card(
//                                 elevation: 5,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 color: HexColor('#FFFFFF'),
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Column(
//                                     children: [
//                                       // CheckboxListTile(
//                                       //     activeColor: Colors.red,
//                                       //     checkColor: Colors.white,
//                                       //     contentPadding: EdgeInsets.zero,
//                                       //     controlAffinity:
//                                       //         ListTileControlAffinity.leading,
//                                       //     value:
//                                       //         selected == index ? true : false,
//                                       //     onChanged: (value) {
//                                       //       l.i(value);
//                                       //       setState(() {
//                                       //         selected = index;
//                                       //         selectedAmount = result[index]
//                                       //                 ['amount']
//                                       //             .toString();

//                                       //         subscriptionId = result[index]
//                                       //             ['subscription_id'];
//                                       //       });
//                                       //     }),
//                                       Text(
//                                         "Payment",
//                                         style: TextStyle(
//                                           fontSize: 17,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: height * 0.01,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "\u20B9",
//                                             style: TextStyle(
//                                                 fontSize: 35,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Text(
//                                             (result[index]['amount'] ?? "")
//                                                 .toString(),
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 30),
//                                           ),
//                                           Text(
//                                             "/Yearly",
//                                           )
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: height * 0.01,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Text(
//                                             "Date",
//                                             style: TextStyle(fontSize: 12),
//                                           ),
//                                           Text("    Time",
//                                               style: TextStyle(fontSize: 12))
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Text("12 mar 2020",
//                                               style: TextStyle(fontSize: 12)),
//                                           Text("Mon,15.00",
//                                               style: TextStyle(fontSize: 12))
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 )),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: height * 0.1),
//                   CheckboxListTile(
//                     activeColor: Colors.red,
//                     checkColor: Colors.white,
//                     contentPadding: EdgeInsets.zero,
//                     controlAffinity: ListTileControlAffinity.leading,
//                     title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                             'Check here to indicate that you have read agree to our,',
//                             style: GoogleFonts.poppins(
//                               textStyle:
//                                   TextStyle(color: Colors.black, fontSize: 9),
//                             )),
//                         Text(
//                           "Terms and Conditions",
//                           style: TextStyle(
//                             color: Colors.blue,
//                             decoration: TextDecoration.underline,
//                             fontSize: 10,
//                           ),
//                         )
//                       ],
//                     ),
//                     value: isChecked,
//                     onChanged: (value) => setState(() {
//                       isChecked = value!;
//                     }),
//                   ),
//                   SizedBox(height: height * 0.01),
//                   Container(
//                     width: width * 0.8,
//                     height: height * 0.05,
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             primary: HexColor("#243665"),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20))),
//                         onPressed: () {
//                           print("$indexAmount,406 line payment");
//                           // openCheckout(amount: indexAmount);

//                           // paymentPostApi(subscriptionId: subscriptionId);
//                           // loginApi();
//                         },
//                         child: Text("Subscribe Now",
//                             style: GoogleFonts.poppins(
//                               textStyle: TextStyle(color: Colors.white),
//                             ))),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
