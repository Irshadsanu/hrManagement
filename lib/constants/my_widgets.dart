import 'package:attendanceapp/constants/colors.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Widget autocomplete(BuildContext context,List<String>list,TextEditingController controller,String hint,String validation){
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      return (list)
          .where((String item) => item
          .toLowerCase()
          .contains(textEditingValue.text.toLowerCase()))
          .toList();
    },
    displayStringForOption: (String option) => option,
    fieldViewBuilder: (BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        fieldTextEditingController.text = controller.text;
      });

      return SizedBox(
        child: TextFormField(
          maxLines: null,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
            hintStyle:  const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),
            fillColor: Colors.white,
            filled: true,
            enabled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 0.5, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:  BorderSide(
                    color: Colors.white,width: 1)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 0.5, color: Colors.white,
              ),
            ),
            hintText: hint,
            suffixIcon: const Icon(
              Icons.arrow_drop_down_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
          validator: (value2) {
            if (value2!.trim().isEmpty || !list.map((item) => item).contains(value2)) {
              return validation;
            } else {
              return null;
            }
          },
          onChanged: (txt) {
            controller.text = txt;
          },
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
        ),
      );
    },

    onSelected: (String selection) {

      controller.text=selection;
      FocusManager.instance.primaryFocus?.unfocus();

    },
    optionsViewBuilder: (BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          child: Container(
            width:  MediaQuery.of(context).size.width*0.86,
            height: MediaQuery.of(context).size.height*0.3,
            color: Colors.white,
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final String option = options.elementAt(index);

                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.86,
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(option,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10)
                        ]),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

Widget applicationautocomp(BuildContext context,List<String>list,TextEditingController controller,String hint,){
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      return (list)
          .where((String item) => item
          .toLowerCase()
          .contains(textEditingValue.text.toLowerCase()))
          .toList();
    },
    displayStringForOption: (String option) => option,
    fieldViewBuilder: (BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        fieldTextEditingController.text = controller.text;
      });

      return SizedBox(
        child: TextFormField(
          maxLines: null,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
            hintStyle:  const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),
            fillColor: Colors.white,
            filled: true,
            enabled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 0.5, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:  BorderSide(
                    color: Colors.white,width: 1)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 0.5, color: Colors.white,
              ),
            ),
            hintText: hint,
            suffixIcon: const Icon(
              Icons.arrow_drop_down_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
          // validator: (value2) {
          //   if (value2!.trim().isEmpty || !list.map((item) => item).contains(value2)) {
          //     return validation;
          //   } else {
          //     return null;
          //   }
          // },
          onChanged: (txt) {
            controller.text = txt;
          },
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
        ),
      );
    },

    onSelected: (String selection) {

      controller.text=selection;
      FocusManager.instance.primaryFocus?.unfocus();

    },
    optionsViewBuilder: (BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          child: Container(
            width:  MediaQuery.of(context).size.width*0.86,
            height: MediaQuery.of(context).size.height*0.3,
            color: Colors.white,
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final String option = options.elementAt(index);

                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.86,
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(option,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10)
                        ]),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}


Widget TextForm1( String name,TextEditingController controller){
  return  TextFormField(

    controller: controller,
    style: const TextStyle(
        color: Colors.black,
        decorationColor:Colors.white30,
        fontSize: 16,
        fontWeight: FontWeight.w600),
       decoration:  InputDecoration(


         focusedBorder:border,
         enabledBorder: border,
         errorBorder: border,
         border:border,

      hintText: name, hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
      // border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    ),  validator: (value) {
    if (value!.isEmpty) {
      return "This field is Required";
    } else {

    }
  },


  );
}
InputBorder border=OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: grey,width: 0.2)
);
Widget button(){
  return  Container(
    height: 50,
    width: 100,
    decoration: BoxDecoration(color: myGreen2,borderRadius: BorderRadius.circular(10)),
    child: Center(child: const Text("ADD",style: TextStyle(fontWeight:FontWeight.w800,fontSize: 15,color: Colors.white),)),
  );
}
 final OutlineInputBorder borderKnm=OutlineInputBorder(
  borderSide: const BorderSide(
      color:Colors.white, ),
  borderRadius: BorderRadius.circular(30),
);

 final OutlineInputBorder borderside=OutlineInputBorder(
  borderRadius: BorderRadius.circular(30.0),
  borderSide: const BorderSide(
    color: Colors.black26,
    width:1,
  ),
);


   Widget edtprofilrtxtfld(TextEditingController controller,TextInputType keyboardtype,String hinttext,String type,String validationtext){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextFormField(
      enabled:type=="EDIT"?false:true,
      textAlign: TextAlign.center,
      controller:controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
        hintText: hinttext,
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
            width:1,
          ),
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return validationtext;
        } else {
          return null;
        }
      },
    ),
  );
}

   Widget edtprofilrtxtfld1(TextEditingController controller,TextInputType keyboardtype,String hinttext,String type,){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextFormField(
      enabled:type=="EDIT"?false:true,
      textAlign: TextAlign.center,
      controller:controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
        hintText: hinttext,
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
            width:1,
          ),
        ),
      ),

    ),
  );
}




   Widget edtprofilrphntxtfld(TextEditingController controller,TextInputType keyboardtype,String hinttext,String type,String validationtext,){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextFormField(
      enabled:type=="EDIT"?false:true,
      textAlign: TextAlign.center,
      inputFormatters: [LengthLimitingTextInputFormatter(10)],
      controller:controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(

        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
        hintText: hinttext,
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
            width:1,
          ),
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return validationtext;
        } else {
          return null;
        }
      },
    ),
  );
}

   Widget edtprofilradhartxtfld(TextEditingController controller,TextInputType keyboardtype,String hinttext,String type,String validationtext,){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextFormField(
      enabled:type=="EDIT"?false:true,
      textAlign: TextAlign.center,
      inputFormatters: [

          FilteringTextInputFormatter.allow(RegExp("[0-9]")),

        LengthLimitingTextInputFormatter(12)],
      controller:controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(

        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
        hintText: hinttext,
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
            width:1,
          ),
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return validationtext;
        } else {
          return null;
        }
      },
    ),
  );
}

//    Widget phntxtfld(TextEditingController controller,TextInputType keyboardtype,String hinttext,String type,String validationtext){
//   return  Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 15),
//     child: Container(
//       decoration: BoxDecoration(
//           color:Colors.red ,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0x26000000),
//               blurRadius: 2.0, // soften the shadow
//               spreadRadius: 1.0, //extend the shadow
//             ),
//           ] ),
//
//       child: TextFormField(
//         enabled:type=="EDIT"?false:true,
//         textAlign: TextAlign.center,
//         inputFormatters: [LengthLimitingTextInputFormatter(10)],
//         controller:controller,
//         keyboardType: keyboardtype,
//         decoration: InputDecoration(
//           // contentPadding: const EdgeInsets.symmetric(vertical: 14),
//           hintText: hinttext,
//           helperText: "",
//           hintStyle: TextStyle(color: Colors.grey[400]),
//           // prefixIcon:const Icon(Icons.person,color: Colors.green,),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30.0),
//             borderSide: const BorderSide(
//               color: Colors.black26,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30.0),
//             borderSide: const BorderSide(
//               color: Colors.black26,
//               width:1,
//             ),
//           ),
//         ),
//         validator: (value) {
//           if (value!.trim().isEmpty) {
//             return validationtext;
//           } else {
//             return null;
//           }
//         },
//       ),
//     ),
//   );
// }

Widget edtprofilremailtxtfld(TextEditingController controller,TextInputType keyboardtype,String hinttext,String type,String validationtext){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextFormField(
      enabled:type=="EDIT"?false:true,
      textAlign: TextAlign.center,
      controller:controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
        hintText: hinttext,
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
            width:1,
          ),
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Please Enter Email";
        } else if (!RegExp( r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',)
            .hasMatch(value) ) {
          return "Enter Correct Email";
        } else {
          return null;
        }
      },
    ),
  );
}
Widget reportbutton( double width,double height,String name){
     return Container(
       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
       width: width,
       height: height,
       padding: const EdgeInsets.only(left: 16),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(40),
         border: Border.all(color: Colors.grey.withOpacity(0.2)),
         boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.2),
             spreadRadius: 1,
             blurRadius: 3,
             offset:
             const Offset(0, 1), // changes position of shadow
           ),
         ],
       ),
       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(name,style: TextStyle(color: clGreen,fontWeight: FontWeight.bold)),
           Padding(
             padding: EdgeInsets.only(right: 10),
             child: Icon(Icons.arrow_forward),
           ),
         ],
       ),

     );
}

