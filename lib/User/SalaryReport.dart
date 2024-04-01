import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../provider/admin_provider.dart';
import '../provider/main_provider.dart';

class UserSalaryReport extends StatelessWidget {
  const UserSalaryReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
  var height=MediaQuery.of(context).size.height;

    return  Container(
      width: width,
      height: height,
      decoration: BoxDecoration(

        image: DecorationImage(

          image: AssetImage('assets/background.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Salary Report',
            style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins-Regular'),
          ),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: InkWell(onTap: () {
            finish(context);
          },
            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [Consumer<MainProvider>(
              builder: (context,value,child) {
                return SizedBox(
                  height: 50,
                  // width: 150,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: value.monthsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final month = value.monthsList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8),
                        child: InkWell(
                          onTap: (){
                            value.getSelectedColor(index);
                            print("${value.selectedIndex}rrrtt");
                          },
                          child: index==value.selectedIndex?Container(
                            height: 42,
                            width: 104,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              gradient: LinearGradient(
                                  colors: [dateGrad2,dateGrad3,],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                            ),
                            child: Center(child: Text(month,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
                          ):Center(child: Text(month,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),)),
                        ),
                      );
                    },
                  ),
                );
              }
          ),
            SizedBox(
                height: height * .63,
                // color:Colors.red,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:
                      Consumer<AdminProvider>(
                          builder: (context, value, child) {
                            return
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: width,
                                  child: DataTable(

                                    showBottomBorder: false,
                                    showCheckboxColumn: false,
                                    horizontalMargin: 1,
                                    dividerThickness: 1,
                                    dataRowColor: MaterialStateColor
                                        .resolveWith(
                                            (states) => Colors.white),
                                    headingRowHeight: 60,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(color: cWhite,blurRadius: 5)
                                    ],
                                        border: Border.all(width: 1,color: grey)),
                                    dataRowHeight: 50,

                                    headingRowColor:
                                    MaterialStateColor
                                        .resolveWith((states) =>cWhite),
                                    // columnSpacing: 1,
                                    columns:   const [
                                      DataColumn(
                                        label: SizedBox(
                                          width: 100,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Align(alignment: Alignment.center,
                                              child: Text('Months',
                                                  style: TextStyle(fontWeight: FontWeight.w400)),
                                            ),
                                          ),
                                        ),
                                        tooltip: 'Months',
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Text('Working Days',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        tooltip: 'Working Days',
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text('Salary',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                        tooltip: 'Salary',
                                        numeric: false,
                                      ),
                                    ], rows: [
                                      DataRow(cells:  <DataCell>[
                                      DataCell(Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text('December'),
                                      )),
                            DataCell(Center(child: Text('30'))),
                            DataCell(Text('17,000')),
                            ],
                            ),
                                    DataRow(cells:  <DataCell>[
                                      DataCell(Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text('November'),
                                      )),
                                      DataCell(Center(child: Text('28'))),
                                      DataCell(Text('15,000')),
                                    ],
                                    ),
                                  ],


                                  ),
                                ),
                              );
                          })),
                )),

          ],
        ),

      ),
    );
  }
}
