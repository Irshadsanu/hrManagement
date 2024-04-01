import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminProvider>(
        builder: (context,value,child) {
          return InkWell(onTap: () {
            // value.loop();
          },
            child: Center(
              child: Container(
                height: 50,
                width: 200,
                color: Colors.red,
              ),
            ),
          );
        }
      ),
    );
  }
}
