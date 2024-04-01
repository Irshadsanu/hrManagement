import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class SubmitOtp extends StatelessWidget {
  const SubmitOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: true);

    return Scaffold(
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 67,top: 144,right: 66),
                child: Image.asset('assets/loginlottie.png',height: 257,width: 257,),
              ),
              const SizedBox(height: 220),
              const Text("Enter Your OTP"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
                child: Pinput(
                  controller: mainProvider.otp_verify,
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  defaultPinTheme: PinTheme(
                      textStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.9)))),
                ),
              ),

              Container(
                  width: width,height: hieght/14,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [ Color(0xff04a201), Color(0xffbdeeb1)]),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton(
                      onPressed: ()  {
                        // mainProvider.verify(context);
                        // callNext(MainScreen(), context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                      ),
                      child:const Text("Submit OTP"))
              ),
            ],),
        ),
      ),
    );
  }
}