import 'dart:io';

import 'package:attendanceapp/constants/colors.dart';
import 'package:flutter/material.dart';


class Update extends StatelessWidget {
  String text;
  String button;
  Update({Key? key,required this.text,required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:   BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    cWhite,
                    myCyan,
                  ]
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.disabled_visible,
                  size: 82,
                  color: Colors.brown.shade600
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                child: Text(text,style: const TextStyle(fontWeight: FontWeight.w800,
                fontSize: 25),textAlign: TextAlign.center),
              ),
              InkWell(
                splashColor: Colors.white,
                onTap: (){
                  exit(0);
                },
                child: Container(
                  height: 40,
                  width: 150,

                  decoration: BoxDecoration(
                    color: Colors.brown,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                      child: Center(
                        child: Text(button,style:  TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          color: cWhite,
                        ),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}