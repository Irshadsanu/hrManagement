import 'package:attendanceapp/provider/login_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';





enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  late BuildContext context;
  String Code = "";
  late String verificationId;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpPage = false;

  Future<void> signInWithPhoneAuthCredential(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    if (kDebugMode) {
      print('done 1  $phoneAuthCredential');
    }
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print(' 1  $phoneAuthCredential');
      }
      setState(() {
        showLoading = false;
      });
      try {
        var LoginUser = authCredential.user;
        if (LoginUser != null) {
          LoginProvider loginProvider = LoginProvider();
          loginProvider.userAuthorized(LoginUser.phoneNumber, context);

          if (kDebugMode) {
            print("Login SUccess");

          }
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          e.message ?? "",
        ),
      ));
    }
  }

  final FocusNode _pinPutFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


  Widget getMobileFormWidget(context) {
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Image.asset('assets/loginlottie.png',height: 257,width: 257,),
              ),
              const SizedBox(height: 190),
              const Text("Login"),
              const SizedBox(height: 20),
              Material(
                elevation: 2,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: phoneController,
                  onChanged: (value) {
                    if (value.length == 10) {
                      showTick = true;
                      SystemChannels.textInput
                          .invokeMethod('TextInput.hide');
                    } else {
                      showTick = false;
                    }

                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey[200]!, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey[200]!, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    //   focusedBorder: customFocusBorder,
                    hintText: 'Mobile Number',
                    hintStyle: const TextStyle(fontSize: 16),
                    // enabledBorder: customFocusBorder,
                    //   border: customFocusBorder,
                    // filled: true,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              showLoading
                  ? const Center(
                    child: CircularProgressIndicator(
                     color: Color(0xff04a201),
                    ),
                  )
                  : Container(
                    width: width,
                    height: hieght/14,
                    decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xff04a201),
                          Color(0xffbdeeb1)
                        ]),
                    borderRadius: BorderRadius.circular(25),
                   ),
                   child: ElevatedButton(
                    onPressed: () async {
                      PackageInfo packageInfo = await PackageInfo.fromPlatform();
                      String packageName  = packageInfo.packageName;
                      if(packageName== "com.spine.staffTrackAdmin") {
                        db.collection("USER").where("PHONE", isEqualTo: "+91${phoneController.text}").where("DESIGNATION",isEqualTo: "ADMIN").get().then((value)async {
                          if(value.docs.isNotEmpty){
                          setState(() {
                            if (phoneController.text.length == 10) {
                              print(phoneController.text.toString()+"yrftury");
                              showLoading = true;
                            }
                          });
                          await auth.verifyPhoneNumber(
                              phoneNumber: "+91${phoneController.text}",
                              verificationCompleted:
                                  (phoneAuthCredential) async {
                                setState(() {
                                  showLoading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Verification Completed"),
                                  duration: Duration(milliseconds: 3000),
                                ));
                                if (kDebugMode) {  }
                              },
                              verificationFailed:
                                  (verificationFailed) async {
                                setState(() {
                                  showLoading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                  Text("Sorry, Verification Failed"),
                                  duration: Duration(milliseconds: 3000),
                                ));
                                if (kDebugMode) {
                                  print(verificationFailed.message.toString());
                                }
                              },
                              codeSent:
                                  (verificationId, resendingToken) async {
                                setState(() {
                                  showLoading = false;
                                  currentSate = MobileVarificationState
                                      .SHOW_OTP_FORM_STATE;
                                  this.verificationId = verificationId;

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "OTP sent to phone successfully"),
                                    duration:
                                    Duration(milliseconds: 3000),
                                  ));

                                  if (kDebugMode) {
                                    print("");
                                  }
                                });
                              },
                              codeAutoRetrievalTimeout:
                                  (verificationId) async {});
                            }
                          else {
                            const snackBar = SnackBar(
                                backgroundColor: Colors.white,
                                duration: Duration(milliseconds: 3000),
                                content: Text("Sorry , You don't have any access",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ));

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          });
                         }
                        },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child:  Text("Login")

                  )

              ),


            ],),
        ),
      ),
    );
  }

  Widget getOtpFormWidget(context) {
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 67,top: 144,right: 66),
                child: Image.asset('assets/loginlottie.png',
                  height: 257,
                  width: 257,
                ),
              ),
              const SizedBox(
                  height: 220
              ),
              const Text("Enter Your OTP"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
                child: PinFieldAutoFill(
                  controller: otpController,
                  codeLength: 6,
                  focusNode: _pinPutFocusNode,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  decoration: BoxLooseDecoration(
                    textStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                    radius: Radius.circular(15),
                    strokeColorBuilder: FixedColorBuilder(Colors.black38),
                  ),
                  onCodeChanged: (pin) {
                    if (pin!.length == 6) {
                      PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: pin);
                      signInWithPhoneAuthCredential(
                          context, phoneAuthCredential);
                      otpController.text = pin;
                      print(otpController.text+"ersgver");
                      setState(() {
                        Code = pin;
                      });
                    }
                  },
                ),
              ),

              Container(
                  width: width,height: hieght/14,
                  decoration: BoxDecoration(
                    gradient:
                    const LinearGradient(
                        colors: [ Color(0xff04a201), Color(0xffbdeeb1)]),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton(
                      onPressed: ()  {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                      ), child:
                  const Text("Submit OTP"))

              ),
              showLoading
                  ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(
                     color: Colors.grey,
                ),
              )
                  : Container(),


            ],),
        ),
      ),
    );
  }

  Widget getUserMobileFormWidget(context) {
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Image.asset('assets/loginlottie.png',height: 257,width: 257,),
              ),
              const SizedBox(height: 190),
              const Text("Login"),
              const SizedBox(height: 20),
              Material(
                elevation: 2,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: phoneController,
                  onChanged: (value) {
                    if (value.length == 10) {
                      showTick = true;
                      SystemChannels.textInput
                          .invokeMethod('TextInput.hide');
                    } else {
                      showTick = false;
                    }

                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey[200]!, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey[200]!, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    //   focusedBorder: customFocusBorder,
                    hintText: 'Mobile Number',
                    hintStyle: const TextStyle(fontSize: 16),
                    // enabledBorder: customFocusBorder,
                    //   border: customFocusBorder,
                    // filled: true,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              showLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff04a201),
                ),
              )
                  : Container(
                  width: width,
                  height: hieght/14,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xff04a201),
                          Color(0xffbdeeb1)
                        ]),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton(
                      onPressed: () async {
                        PackageInfo packageInfo = await PackageInfo.fromPlatform();
                        String packageName  = packageInfo.packageName;
                        if(packageName== "com.spine.staffTrack") {
                          print(phoneController.text.toString()+"kokokok");

                          db.collection("USER").where("PHONE", isEqualTo:"+91${phoneController.text}").where("DESIGNATION", isNotEqualTo: "ADMIN").get().then((val) async {
                            if (val.docs.isNotEmpty) {
                              setState(() {
                                if (phoneController.text.length == 10) {
                                  print(phoneController.text.toString()+"yrftury");
                                  showLoading = true;
                                }
                              });
                              await auth.verifyPhoneNumber(
                                  phoneNumber: "+91${phoneController.text}",
                                  verificationCompleted:
                                      (phoneAuthCredential) async {
                                    setState(() {
                                      showLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Verification Completed"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                    if (kDebugMode) {}
                                  },
                                  verificationFailed:
                                      (verificationFailed) async {
                                    setState(() {
                                      print("ftryeri90ew"+phoneController.text.toString());

                                      print(verificationFailed?.phoneNumber);
                                      print("kikikikikiki"+ verificationFailed.message.toString()+""+verificationFailed.phoneNumber.toString());
                                      showLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                      Text("Sorry, Verification Failed"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                    if (kDebugMode) {
                                      print(verificationFailed.message.toString());
                                    }
                                  },
                                  codeSent:
                                      (verificationId, resendingToken) async {
                                    setState(() {
                                      showLoading = false;
                                      currentSate = MobileVarificationState
                                          .SHOW_OTP_FORM_STATE;
                                      this.verificationId = verificationId;

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "OTP sent to phone successfully"),
                                        duration:
                                        Duration(milliseconds: 3000),
                                      ));

                                      if (kDebugMode) {
                                        print("");
                                      }
                                    });
                                  },
                                  codeAutoRetrievalTimeout:
                                      (verificationId) async {});
                            }
                            else {
                              const snackBar = SnackBar(
                                  backgroundColor: Colors.white,
                                  duration: Duration(milliseconds: 3000),
                                  content: Text("Sorry , You don't have any access",
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ));

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          });
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Login")

                  )

              ),


            ],),
        ),
      ),
    );
  }

  Widget getUserOtpFormWidget(context) {
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 67,top: 144,right: 66),
                child: Image.asset('assets/loginlottie.png',
                  height: 257,
                  width: 257,
                ),
              ),
              const SizedBox(
                  height: 220
              ),
              const Text("Enter Your OTP"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
                child: PinFieldAutoFill(
                  controller: otpController,
                  codeLength: 6,
                  focusNode: _pinPutFocusNode,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  decoration: BoxLooseDecoration(
                    textStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                    radius: Radius.circular(15),
                    strokeColorBuilder: FixedColorBuilder(Colors.black38),
                  ),
                  onCodeChanged: (pin) {
                    if (pin!.length == 6) {
                      PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: pin);
                      signInWithPhoneAuthCredential(
                          context, phoneAuthCredential);
                      otpController.text = pin;
                      print(otpController.text+"ersgver");
                      setState(() {
                        Code = pin;
                      });
                    }
                  },
                ),
              ),

              Container(
                  width: width,height: hieght/14,
                  decoration: BoxDecoration(
                    gradient:
                    const LinearGradient(
                        colors: [ Color(0xff04a201), Color(0xffbdeeb1)]),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton(
                      onPressed: ()  {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                      ), child:
                  const Text("Submit OTP"))

              ),
              showLoading
                  ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              )
                  : Container(),


            ],),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.getPackageName();

    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
          key: scaffoldKey,
          body:loginProvider.packageName=='com.spine.staffTrack'?Container(
            child: currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
            // getMobileFormWidget
                ? getUserMobileFormWidget(context)
                : getUserOtpFormWidget(context),
          ):Container(
            child: currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
            // getMobileFormWidget
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
          )),
    );
  }

}

