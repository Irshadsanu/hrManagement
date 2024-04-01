import 'package:flutter/material.dart';

import '../constants/colors.dart';

class UserAchievementCard extends StatelessWidget {
  const UserAchievementCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150),

              child: Center(
                child: Column(
                  children: [
                    Text("1st Work Anniversary",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,
                fontFamily: 'Poppins-Regular',color: myGreen2)),
    SizedBox(height: 20,),
    Container(
    width: 350,
    height: 350,
    padding: new EdgeInsets.all(10.0),
    child: Card(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    ),

    elevation: 30,
      child: Image.asset("assets/probation.png"),
    ),),
                  ],
                ),
              ),
            ),Padding(padding: EdgeInsets.symmetric(vertical: 40,horizontal: 120),
          child: Row(
            children: [
              InkWell(
              child:Container(height: 50,width: 50,decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: Icon(Icons.file_download_outlined,size: 20,),),),
              SizedBox(width:50,),
              InkWell(
                child: Container(height: 50,width: 50,decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                  child: Icon(Icons.share_outlined,size: 18,),),
              ),
            ],
          ),
        )
      ],
      ));
  }
}

