import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../provider/admin_provider.dart';
import '../provider/main_provider.dart';
import 'add_Project_Screen.dart';


class AdminTrackerScreen extends StatelessWidget {
  String uid;
  String companyid;
  String subcompany;
  AdminTrackerScreen({Key? key, required this.uid, required this.companyid, required this.subcompany }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("vjbvjbfjfh"+companyid);
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    mainProvider.generateMonthsList();

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return  Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(


        image: DecorationImage(

          image: AssetImage('assets/background.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: InkWell(
          onTap: (){
            adminProvider.projectCT.clear();
            callNext(AddProjects(uid: uid), context);
          },
          child: Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(15),color:timeColor,),

            child: const Center(child: Text("Add Projects",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text("Tracker",style:TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              // fontFamily: 'Poppins-Regular'
          ),),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          // leading: InkWell(onTap: () {
          //   finish(context);
          // },
          //   child: const Icon(
          //     Icons.keyboard_arrow_left,
          //     size: 30,
          //     color: Colors.black,
          //   ),
          // ),
          actions: [
            InkWell(
              onTap: (){
                mainProvider.dateRangePickerFlutter(context,"ADMIN",'',companyid,subcompany);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5,right: 10),
                child: SizedBox(
                    width: 50,
                    child: Image.asset("assets/img_6.png",scale: 1.5)),
              ),
            ),
          ],
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Consumer<MainProvider>(
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
                                value.getFilterByMonthTracker(month,companyid,subcompany);
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
                                child: Center(child: Text(month,style: const TextStyle(color: Colors.white
                                    ,fontWeight: FontWeight.w500),)),
                              ):index==value.currentMonth?Container(
                                height: 30,
                                width: 104,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                                  gradient: LinearGradient(
                                      colors: [myGreen3,myGreen4,],
                                      begin: Alignment.topCenter,
                                      end: Alignment.center),
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
                        child: Consumer<MainProvider>(
                            builder: (context, value, child) {
                              return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child:value.trackerLoader?const CircularProgressIndicator():
                                  value.trackerEmptyLoader?
                                  DataTable(
                                    showBottomBorder: false,
                                    showCheckboxColumn: false,
                                    horizontalMargin: 1,
                                    dividerThickness: 1,
                                    dataRowColor: MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                    headingRowHeight: 60,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                      BoxShadow(color: cWhite,blurRadius: 5)
                                    ],
                                        // border: Border.all(width: 1,color: grey)
                                    ),
                                    dataRowHeight: 70,
                                    headingRowColor:
                                    MaterialStateColor
                                        .resolveWith((states) =>cWhite),
                                    // columnSpacing: 1,
                                    border: TableBorder.all(
                                      width: 1.0,
                                      color:Colors.black38,
                                     ),
                                    columns:   const [
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Align(alignment: Alignment.center,
                                              child: Text('Date',
                                                  style: TextStyle(fontWeight: FontWeight.w400)),
                                            ),
                                          ),
                                        ),
                                        tooltip: 'Date',
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Align(alignment: Alignment.center,
                                            child: Text('Name',
                                                style: TextStyle(fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                        tooltip: 'Name',
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 160,
                                          child: Text('Project',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        tooltip: 'Project',
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text('Application',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                        tooltip: 'Application',
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text('File Name',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                        tooltip: 'File Name',
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 155,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text('Development Process',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                        tooltip: 'Development Process',
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 160,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text('Task',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                        tooltip: 'Task',
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text('Hours worked',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                        tooltip: 'Hours worked',
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text('Status',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                        tooltip: 'Status',
                                        numeric: false,
                                      ),
                                    ],

                                    rows: value.trackerDataList
                                        .map((data) => DataRow(
                                        cells: [
                                          DataCell(SizedBox(
                                              width: 120,
                                              child: Center(
                                                child: Container(
                                                  height: 50,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: dateClr,
                                                      borderRadius: BorderRadius.circular(12)
                                                  ),

                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 0.0),
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Column(
                                                        children: [
                                                          Text(data.date,
                                                            textAlign: TextAlign.center,
                                                            style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                          DataCell(SizedBox(
                                            width: 120,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                data.userName,
                                                style: const TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 160,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                data.project,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 120,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                data.applicationType,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 120,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                data.fileName,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 120,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                data.process,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 160,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                data.task,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 120,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                data.workingHours,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 120,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                data.status,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )),


                                        ],
                                        color:  MaterialStateProperty.all<
                                            Color>(
                                            Colors.white
                                                .withOpacity(
                                                0.3))
                                    ))
                                        .toList(),
                                  ):
                                  Container(
                                    alignment: Alignment.center,
                                    height: height*.55,
                                    child: const Center(
                                      child: Text("No Data Found !!!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.w600),),
                                     ),
                                  ));
                            })
                           ),
                        ))
                     ],
               ),
        ),
         ),
    );
    //   Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children:  [
    //     ElevatedButton(onPressed: () {
    //       callNext(AddProjects(uid: uid), context);
    //     }, child: const Text("Add Projects")),
    //
    //     Center(child: Text("Coming Soon",style: TextStyle(fontWeight: FontWeight.w600),))
    //   ],
    // );
  }
}
