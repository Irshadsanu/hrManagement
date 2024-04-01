import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/colors.dart';
import '../models/projectwisegraphmodel.dart';
import '../provider/admin_provider.dart';

class ProjectWiseGraphReport extends StatelessWidget {
  String companyid;
  String subcompany;
   ProjectWiseGraphReport({super.key,required this.companyid,required this.subcompany});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: hieght,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png',
          ),fit:BoxFit.fill,
        ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Project Wise Report',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15)),
          centerTitle: true,
          actions: [

            Consumer<AdminProvider>(
                builder: (context,value2,child) {
                  return InkWell(
                    onTap: (){
                      value2.attedancereportdetails(context,companyid,"projectwise","",subcompany);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5,right: 10),
                      child: SizedBox(
                          width: 50,
                          child: Image.asset("assets/img_6.png",scale: 1.5)),
                    ),
                  );
                }
            ),

          ],
        ),
        body:  Consumer<AdminProvider>(
            builder: (context,valu,child) {
              print("hahahahhaha"+valu.projectwisereport.length.toString());
              return valu.projectwisereport.isEmpty? const Center(
                child: Text("Select the date for Graph Report",
                  // textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),),
              ): SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return  Container(
                        height: hieght,
                        width: width,
                        child: SfCartesianChart(
                          borderWidth: 5,
                          primaryXAxis: const CategoryAxis(labelStyle: TextStyle(
                            fontSize:4,// Adjust the font size as needed
                            fontWeight: FontWeight.bold, // Adjust font weight as needed
                            // You can also adjust other properties like color, etc. here
                          ),
                          ),
                          primaryYAxis: NumericAxis(minimum: 0, maximum: 300, interval: 40),
                          series: <CartesianSeries>[
                            ColumnSeries<projectwise,String>(
                              color: overTimeClr,
                              dataSource: value.projectwisereport,//list of attendance
                              xValueMapper: (projectwise emp,_) =>emp.projectname,//employees name
                              yValueMapper: (projectwise emp,_) => emp.totalworkinghour,
                                  // double.parse(emp.totalworkinghour.toString()),//attendance hour
                              dataLabelSettings: DataLabelSettings(isVisible: true),
                            )
                          ],
                        ),
                      );
                    }
                ),
              );
            }
        ),
      ),
    );
  }
}
