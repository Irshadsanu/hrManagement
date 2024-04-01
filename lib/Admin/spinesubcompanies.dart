import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/my_functions.dart';
import '../provider/admin_provider.dart';
import '../provider/main_provider.dart';
import 'addCompanyPage.dart';
import 'adminBottomNavigation.dart';



class SpineSubCompanies extends StatelessWidget {
  String companyid;
  String userid;
  String loginusername;
  List<dynamic>getsubcompany=[];
   SpineSubCompanies({super.key,required this.companyid,required this.userid,required this.loginusername,required this.getsubcompany});

  @override
  Widget build(BuildContext context) {

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
                  ,from: "sub",), context);
              },
              child: Icon(Icons.add,color: Colors.white,),
            );
          }
        ),
        appBar: AppBar(
          // backgroundColor: myGreen3,
          backgroundColor: Colors.transparent,
          title:  Text("SUB-COMPANIES",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Consumer<AdminProvider>(
                builder: (context,value,child) {
                  print("dnbjefbv"+value.getsubcompany.length.toString());
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: getsubcompany.length,
                      itemBuilder: (context,index) {
                        var item=getsubcompany[index];
                        return InkWell(onTap: () {
                          print(companyid+'aaaa');
                          print('jjjjj'+item.toString());
                          value.getData(companyid,item);
                          value.getStaffData(companyid,item);
                          callNext(AdminBottomNavigationScreen(userId: userid, userName: loginusername, type: 'Admin',companyid: companyid,subcompany: item), context);
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
                            child: Center(child: Text(item,style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w700),)),),
                        );
                      }
                  );
                }
            ),
          ],
        ),
      ),
    ) ;
  }}
