import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/colors.dart';
import '../models/projectwisegraphmodel.dart';
import '../provider/admin_provider.dart';

class EmpWiseProjectReport extends StatelessWidget {
  String companyid;
  String empid;
  String empname;
  String subcompany;
   EmpWiseProjectReport({super.key,required this.companyid,required this.empid,required this.empname,required this.subcompany});

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: hieght,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/background.png'
        ),
          fit:BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Emp Wise Project Report',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15
          )
          ),
          centerTitle: true,
          actions: [

            Consumer<AdminProvider>(
                builder: (context,value2,child) {
                  return InkWell(
                    onTap: (){
                      value2.attedancereportdetails(context,companyid,"empprojectwise",empid,subcompany);
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
              print(valu.getempprjloader.toString()+"helloooohib"+valu.emptyempprjloader.toString());

              return valu.getempprjloader?Center(child: CircularProgressIndicator(color: Colors.green,))
                  :valu.emptyempprjloader? SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Text(empname,style: TextStyle(fontWeight: FontWeight.w800,color:dateGrad1,fontSize: 18 ),),
                    Consumer<AdminProvider>(
                        builder: (context,value,child) {
                          return  Container(
                            height: hieght,
                            width: width,

                            child: SfCartesianChart(
                              borderWidth: 10,
                              primaryXAxis: const CategoryAxis(labelStyle: TextStyle(
                                fontSize:5,// Adjust the font size as needed
                                fontWeight: FontWeight.bold, // Adjust font weight as needed
                                // You can also adjust other properties like color, etc. here
                              ),
                              ),
                              primaryYAxis: NumericAxis(minimum: 0, maximum: 300, interval: 40),
                              series: <CartesianSeries>[
                                ColumnSeries<projectwise,String>(
                                  color: overTimeClr,
                                  dataSource: value.empwiseprojectreport,//list of attendance
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
                  Text("Pie Chart in Percentage%",style: TextStyle(fontWeight: FontWeight.w800,color:dateGrad1,fontSize: 18 ),),

                  Consumer<AdminProvider>(
                        builder: (context,value,child) {
                          return   Center(
                              child: Container(
                                  child: SfCircularChart(
                                    series: <CircularSeries>[
                                        // Render pie chart
                                        PieSeries<projectwise, String>(
                                            dataSource: value.empwiseprojectreport,
                                            // pointColorMapper:(projectwise data,  _) => data.color,
                                          xValueMapper: (projectwise emp,_) =>emp.projectname,//employees name
                                          yValueMapper: (projectwise emp,_) =>((emp.totalworkinghour/value.empprgloopcount)*100),
                                            radius: '100%',
                                          dataLabelSettings: DataLabelSettings(isVisible: true,textStyle: TextStyle(fontSize: 8)),

                                        )
                                      ],
                                      legend:  Legend(isVisible: true,overflowMode: LegendItemOverflowMode.wrap,position: LegendPosition.bottom,
                                          textStyle:TextStyle(fontSize: 12) ),
                                  )
                              )
                          );
                        }
                    ),
                  ],
                ),
              )
                  :Center(
                child: Text("Select the date for Graph Report",
                  // textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),),
              );
            }
        ),

      ),
    );
  }
}
