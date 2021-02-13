import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';

class DriverInputBoxWidget extends StatelessWidget {
  FocusNode focusNode;
  Function onTapTrigger;
  String labelText;

  DriverInputBoxWidget({this.focusNode, this.onTapTrigger, this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(53,52,89,0.7)),
          ),


          TextFormField(
            onTap: onTapTrigger,
            focusNode: focusNode,
            style: TextStyle(
                fontSize: 15.0,
                color: MyColor.defaultTextColor,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600),
            decoration: new InputDecoration(
              hintText: labelText,
              prefixIcon: Container(
                width: 20,
                height: 20,
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'images/username_ic.png',
                  fit: BoxFit.fill,
                ),
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color:Color.fromRGBO(40,43,47,0.25),
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
                fontSize: focusNode.hasFocus?18:15,
              ),
              fillColor: Colors.white,
              //  contentPadding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 20),
              //contentPadding: EdgeInsets.all(20),

              //fillColor: Colors.green
            ),
            keyboardType: TextInputType.emailAddress,
          ),

          Container(color: Colors.black,height: 1,width: double.infinity,)

        ],
      )
    );
  }
}
