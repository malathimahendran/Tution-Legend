import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

// import 'package:razorpay_flutter/razorpay_flutter.dart';
class PaymentDesign extends StatefulWidget {
  PaymentDesign({Key? key}) : super(key: key);

  @override
  _PaymentDesignState createState() => _PaymentDesignState();
}

class _PaymentDesignState extends State<PaymentDesign> {
  bool isChecked = false;
  var userEmail, userMobileNo, userName, profileImage;
  Razorpay? razorpay;
  void initState() {
    super.initState();

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
        print("$userEmail,$userEmail");
      });
    });
  }

  openCheckout() async {
    var options = {
      "key": "rzp_test_HavqZQoR2ijLH5",
      "amount": "100000",
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

  void handlerPaymentSuccess(PaymentSuccessResponse res) {
    print("Payment success");
    print(res.paymentId);
    print(res.orderId);
    print(res.signature);
    print(58);
    print("sfdfffffffffffffffffffffffffff");
    Toast.show("Payment success", context, duration: 3);
  }

  void handlerErrorFailure() {
    print("Payment error");
    Toast.show("Payment error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: profileImage == null
          ? CircularProgressIndicator()
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage(
                          'assets/ProfilePage/mainbackground.png'))),
              height: height,
              width: width,
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
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            Text(
                              'Payment               ',
                              style: TextStyle(
                                  color: HexColor('#F9F9F9'), fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: (height - status) * 0.18,
                        left: width * 0.13,
                        child: Container(
                          height: height * 0.07,
                          width: height * 0.07,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(profileImage))),
                        ),
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
                              Text("Enrollment no:25325")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: (height - status) * 0.25,
                    width: width * 0.9,
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
                                  fontSize: 19,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "\u20B9",
                                    style: TextStyle(
                                        fontSize: 45,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "1000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35),
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
                                children: [Text("Date"), Text("    Time")],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("12 mar 2020"),
                                  Text("Mon,15.00")
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(height: height * 0.15),
                  CheckboxListTile(
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
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
                      isChecked = true;
                    }),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width * 0.8,
                    height: height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: HexColor("#FF465C"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          openCheckout();
                          // loginApi();
                        },
                        child: Text("Subscribe Now",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white),
                            ))),
                  ),
                ],
              ),
            ),
    );
  }
}
