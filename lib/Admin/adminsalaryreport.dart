import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../provider/main_provider.dart';

class SalaryReportScreen extends StatelessWidget {
  const SalaryReportScreen({super.key});

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
          title: const Text("  Salary Report",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Poppins-Regular")),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Consumer<MainProvider>(builder: (context, value, child) {
              print("vknv,jnjnv" + value.currentYear.toString());
              // print("nvbf,jbvh"+value.monthsList.length.toString());
              // print("${DateTime.now().month}mffjj");
              return SizedBox(
                height: 50,
                // width: 150,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: value.yearsTilPresent.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final year = value.yearsTilPresent[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: InkWell(
                        onTap: () {
                          value.getSelectedyear(index);
                          print("${value.currentYear}rrrtt");
                          print("${DateTime.now().year}kxlspp");
                          // value.getUserFilterByMonthTracker(monthh,userId);
                        },
                        child: index == value.currentYear
                            ? Container(
                                height: 42,
                                width: 104,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  gradient: LinearGradient(
                                      colors: [
                                        dateGrad2,
                                        dateGrad3,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                child: Center(
                                    child: Text(
                                  year.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                              )
                            : index == 14
                                ? Container(
                                    height: 42,
                                    width: 104,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      gradient: LinearGradient(
                                          colors: [
                                            myGreen3,
                                            myGreen4,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                    ),
                                    child: Center(
                                        child: Text(
                                      year.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  )
                                : Center(
                                    child: Text(
                                    year.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  )),
                      ),
                    );
                  },
                ),
              );
            }),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              width: width,
              height: 80,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 3)
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Month",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w300)),
                  Text("Working Days",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w300)),
                  Text("Salary",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 15,
                          fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            Consumer<MainProvider>(builder: (context, value, child) {
              return SizedBox(
                height: hieght,
                width: 150,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: value.monthsList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final month = value.monthsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: InkWell(
                        onTap: () {
                          value.getSelectedColor(index);
                          print("${value.selectedIndex}rrrtt");
                          // value.getFilterByMonthTracker(month,companyid);
                        },
                        child: index == value.selectedIndex
                            ? Container(
                                height: 42,
                                width: 104,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  gradient: LinearGradient(
                                      colors: [
                                        dateGrad2,
                                        dateGrad3,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                child: Center(
                                    child: Text(
                                  month,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                              )
                            : index == value.currentMonth
                                ? Container(
                                    height: 30,
                                    width: 104,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(35)),
                                      gradient: LinearGradient(
                                          colors: [
                                            myGreen3,
                                            myGreen4,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.center),
                                    ),
                                    child: Center(
                                        child: Text(
                                      month,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  )
                                : Center(
                                    child: Text(
                                    month,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  )),
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
