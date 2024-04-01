import 'package:attendanceapp/User/user_tracker.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../provider/main_provider.dart';

class TrackerListScreen extends StatelessWidget {
  String userName;
  String userId;
  String companyid;
  String subcompany;
   TrackerListScreen({super.key,required this.userName,required this.userId,required this.companyid,required this.subcompany});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    mainProvider.generateMonthsList();
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(

        image: DecorationImage(

          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
       backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            mainProvider.clearTracker();

            adminProvider.getProjects();
            callNext(UserTracker(userName: userName,userId: userId, companyid: companyid,subcompany: subcompany), context);
          },
          backgroundColor: timeColor,
        child: Icon(Icons.add,size: 35,color: Colors.white,),),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text("Tracker",
            style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins-Regular'),
          ),
          automaticallyImplyLeading: true,
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
                mainProvider.dateRangePickerFlutter(context,"USER",userId,companyid,subcompany);
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
          Column(
              children: [
                Consumer<MainProvider>(
                    builder: (context,value,child) {
                      print("${DateTime.now().month}mffjj");
                     return SizedBox(
                       height: 50,
                       // width: 150,
                       child: ListView.builder(
                         padding: EdgeInsets.zero,
                          itemCount: value.monthsList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final monthh = value.monthsList[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                              child: InkWell(
                                onTap: (){
                                  value.getSelectedColor(index);
                                  print("${value.selectedIndex}rrrtt");
                                  print("${DateTime.now().month}kxlspp");
                                  value.getUserFilterByMonthTracker(monthh,userId,companyid,subcompany);
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
                                  child: Center(child: Text(monthh,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
                                ):index==value.currentMonth?Container(
                                  height: 42,
                                  width: 104,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    gradient: LinearGradient(
                                        colors: [myGreen3,myGreen4,],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                  ),
                                  child: Center(child: Text(monthh,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
                                ):Center(child: Text(monthh,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),)),
                              ),
                            );
                          },
                        ),
                     );
                    }
                ),

                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return value.trackerDataList.isNotEmpty?SizedBox(
                        height: height * .63,
                        // color:Colors.red,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child:
                              Consumer<MainProvider>(
                                  builder: (context, value, child) {
                                    return
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: value.trackerLoader?const CircularProgressIndicator():
                                        value.trackerEmptyLoader?DataTable(
                                          showBottomBorder: false,
                                          showCheckboxColumn: false,
                                          horizontalMargin: 1,
                                          dividerThickness: 1,
                                          dataRowColor: MaterialStateColor
                                              .resolveWith(
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
                                                width: 100,
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
                                                width: 180,
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
                                                width: 160,
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
                                                width: 180,
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
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 0.0),
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
                                                    width: 110,
                                                    child: Center(
                                                      child: Container(
                                                        height: 50,
                                                        width: 85,
                                                        decoration: BoxDecoration(
                                                          color: dateClr,
                                                          borderRadius: BorderRadius.circular(12)
                                                        ),

                                                        child: Center(
                                                          child: Text(data.date,textAlign: TextAlign.center,
                                                            style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                                        ),
                                                      ),
                                                    ))),
                                                DataCell(SizedBox(
                                                  width: 180,
                                                  child: Text(
                                                    data.project,
                                                    style: const TextStyle(fontSize: 15),
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
                                                  width: 160,
                                                  child: Text(
                                                    data.process,
                                                    style: const TextStyle(fontSize: 15),
                                                  ),
                                                )),
                                                DataCell(SizedBox(
                                                  width: 180,
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
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0),
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
                                                  Color>(Colors.white.withOpacity(0.3))
                                                  ))
                                              .toList(),
                                        ): Container(
                                          alignment: Alignment.center,
                                          height: height*.55,
                                          child: const Center(
                                            child: Text("No Data Found !!!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.w600),),
                                          ),
                                        ),
                                      );
                                  })),
                        )):
                    SizedBox(
                      height: height*.55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text("No Data Found !!!"),
                        ],
                      ),
                    );
                  }
                )
              ],
            ),


      ),
    );
  }
}
