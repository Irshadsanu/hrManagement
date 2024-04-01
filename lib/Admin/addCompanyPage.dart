import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/my_widgets.dart';
import '../provider/admin_provider.dart';
import 'CompanyListScreen.dart';

class AddCompanyPage extends StatelessWidget {
  String companyid;
  String userid;
  String loginusername;
  String from;
  AddCompanyPage(
      {super.key,
      required this.companyid,
      required this.userid,
      required this.loginusername,required this.from});

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
          backgroundColor: myGreen3,
          title: from=="sub"?Text(
            " ADD SUB-COMPANIES",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, color: cWhite),
          ):Text(
            " ADD COMPANIES",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, color: cWhite),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<AdminProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextForm1("Name", value.Cnamecontroller),
              );
            }),
            const SizedBox(
              height: 60,
            ),
            Consumer<AdminProvider>(builder: (context, value, child) {
              return InkWell(
                  onTap: () {
                    if(from=="sub"){

                    value.addsubcompanies(companyid);
                    callNext(
                        CompanyList(
                          companyid: companyid,
                          userid: userid,
                          loginusername: loginusername,
                        ),
                        context);

                  }else{
                    value.Addcompany();
                    callNext(
                        CompanyList(
                          companyid: companyid,
                          userid: userid,
                          loginusername: loginusername,
                        ),
                        context);
                  }

                  },
                  child: button());
            })
          ],
        ),
      ),
    );
  }
}
