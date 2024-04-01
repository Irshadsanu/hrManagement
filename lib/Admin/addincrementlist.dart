import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/my_widgets.dart';
import '../provider/admin_provider.dart';

class IncrementList extends StatelessWidget {
  String companyid;
  String employeeid;
  String name;
  String designation;
  String previoussalary;
  String photo;
  String subcompany;
  IncrementList(
      {super.key,
      required this.companyid,
      required this.employeeid,
      required this.name,
      required this.designation,
      required this.previoussalary,
      required this.photo,required this.subcompany});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: hieght,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/background.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(" Add Increment Report",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Poppins-Regular")),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        print("fvfnkjnv" + photo.toString());
                        showBottomSheet(context);
                      },
                      child: value.reportfileimage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(
                                value.reportfileimage!,
                              ),
                            )
                          : photo != ""
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(photo),
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/profileAvatar.png",
                                    scale: 4,
                                  )),
                    ),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "      Topic : ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return edtprofilrtxtfld1(
                    value.topiccontroller,
                    TextInputType.name,
                    "TOPIC",
                    "",
                  );
                }),
                Text(
                  "      Previous Salary : ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: 60,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black26, width: 1)),
                    child: Center(
                        child: Text(
                      previoussalary,
                      style: TextStyle(color: Colors.black),
                    )),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "      Increment Salary : ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Consumer<AdminProvider>(
                      builder: (context, value1, child) {
                    return TextFormField(
                      onChanged: (value) {
                        value1.getPreviousSalary(value);
                      },
                      textAlign: TextAlign.center,
                      controller: value1.incrementsalaryCt,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Increment Salary",
                        helperText: "",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: borderside,
                        focusedBorder: borderside,
                        enabledBorder: borderside,
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Increment Salary";
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                ),
                Text(
                  "      New Salary : ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  if (value.incrementsalaryCt.text.isNotEmpty) {
                    value.salary = int.parse(previoussalary.toString()) +
                        int.parse(value.incrementsalaryCt.text.toString());
                  } else {
                    value.salary = 0;
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: 60,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black26, width: 1)),
                    child: Center(
                        child: Text(
                      value.salary.toString(),
                      style: TextStyle(color: Colors.black),
                    )),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "      Effective Date : ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: value.effectivedateCt,
                      keyboardType: TextInputType.text,
                      onTap: () {
                        value.effectiveDateRangePicker(context);
                      },
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Effective Date",
                        helperText: "",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value123) {
                        if (value123!.trim().isEmpty) {
                          return "pick your effective date";
                        } else {
                          return null;
                        }
                      },
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Consumer<AdminProvider>(builder: (context1, value, child) {
                  return Center(
                    child: Container(
                        width: width / 1.2,
                        height: hieght / 14,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                value.AddIncrementReport(
                                    context,
                                    companyid,
                                    employeeid,
                                    name,
                                    designation,
                                    previoussalary,
                                    photo,subcompany);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: value.incrementreportloader
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Save",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ))),
                  );
                }),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.camera_enhance_sharp,
                    color: myGreen2,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () => {
                        adminProvider.getImgcamerareport(),
                        Navigator.pop(context)
                      }),
              ListTile(
                  leading: Icon(Icons.photo, color: myGreen2),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () => {
                        adminProvider.getImggalleryreport(),
                        Navigator.pop(context)
                      }),
            ],
          );
        });
    // ImageSource
  }
}
