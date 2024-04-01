import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProjects extends StatelessWidget {
  String uid;
  AddProjects({super.key, required this.uid});

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
          title: const Text("Add Projects",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Consumer<AdminProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: value.projectCT,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    hintText: "Project Name",
                    helperText: "",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.black26,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.black26,
                        width: 1,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Enter Name";
                    } else {
                      return null;
                    }
                  },
                ),
              );
            }),
            const SizedBox(height: 50),
            Consumer<AdminProvider>(builder: (context, value, child) {
              return ElevatedButton(
                  onPressed: () {
                    value.addProject(uid,context);
                  },
                  child: const Text(
                    "Submit",
                  ));
            })
          ],
        ),
      ),
    );
  }
}
