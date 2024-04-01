import 'package:attendanceapp/Admin/spinesubcompanies.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/login_page.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../provider/main_provider.dart';
import 'addCompanyPage.dart';
import 'adminBottomNavigation.dart';
import 'adminStaffScreen.dart';

class CompanyList extends StatelessWidget {
  String companyid;
  String userid;
  String loginusername;
   CompanyList({super.key,required this.companyid,required this.userid,required this.loginusername});

  @override
  Widget build(BuildContext context) {
    List companyimg=[
      "assets/spine.png",
      "assets/neurobots.png",
      "assets/neurobots.png",
      
    ];
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: true);

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png',
          ),fit:BoxFit.fill,
        ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: companyid=="1704949040060"?SizedBox():Consumer<AdminProvider>(
          builder: (context,val,child) {
            return FloatingActionButton(backgroundColor: myGreen2,
              onPressed: () {
                val.clearcompany();
                callNext(AddCompanyPage(companyid: companyid,userid: userid,loginusername: loginusername
                  ,from: ""), context);

              },
               child: Icon(Icons.add,color: Colors.white,),
            );
          }
        ),
        appBar: AppBar(
          // backgroundColor: myGreen3,
          backgroundColor: Colors.transparent,

          title:  Text("COMPANIES",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0,bottom: 8),
              child: IconButton(onPressed: () {
                mainProvider.logOutAlert(context);
              }, icon: Icon(Icons.logout,color: Colors.black,),),
            ),
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Consumer<AdminProvider>(
              builder: (context,value,child) {
                return companyid=="1704949040060"
                    ?InkWell(onTap: () {
                  callNext(
                      AdminStaffScreen(companyid: companyid,subcompany: ""), context);
                },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [myGreen3,myGreen4,],
                            begin: Alignment.topCenter,
                            end: Alignment.center),
                        color: Colors.grey,borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text("INTERNS",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w700),)),),
                ):ListView.builder(
                  shrinkWrap: true,
                    itemCount: value.Companieslist.length,
                    itemBuilder: (context,index) {
                    print("hkdbchfc"+value.Companieslist.length.toString());
                    var item= value.Companieslist[index];
                    return InkWell(onTap: () {
                      print("bvejhvfejvhbf"+companyid.toString());

                      if(item.getsubcompany.isNotEmpty){
                        // value.getsubcompanies(companyid);


                        callNext(SpineSubCompanies(companyid: companyid,userid: userid, loginusername: loginusername, getsubcompany: item.getsubcompany,), context);
                      }else{
                        value.getData(companyid,'');
                        value.getStaffData(companyid,'');
                        callNext(AdminBottomNavigationScreen(userId: userid, userName: loginusername, type: 'Admin',companyid: item.companyid,subcompany: ""), context);
                      }
                        },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        width: width,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [myGreen3,myGreen4,],
                                begin: Alignment.topCenter,
                                end: Alignment.center),
                            color: Colors.grey,borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text(item.companyname,style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w700),)),),
                    );
                  }
                );
              }
            ),
          ],
        ),
      ),
    ) ;
  }
}
