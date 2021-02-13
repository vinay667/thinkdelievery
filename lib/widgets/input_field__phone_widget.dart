import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thinkdelievery/colors/colors.dart';

class InputBoxPhoneWidget extends StatelessWidget {
  FocusNode focusNode;
  Function onTapTrigger;
  String labelText;
  final controller;
  Function validator;
  InputBoxPhoneWidget({this.focusNode, this.onTapTrigger, this.labelText,this.controller,this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 58,
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(15),
          WhitelistingTextInputFormatter(RegExp("[0-9]")),
        ],
        onTap: onTapTrigger,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        style: TextStyle(
            fontSize: 15.0,
            color:MyColor.defaultTextColor,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w600),
        decoration: new InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: focusNode.hasFocus
                  ? MyColor.textFiledActiveColor
                  : Color.fromRGBO(40,43,47,0.25),
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w700,
              fontSize: focusNode.hasFocus?18:17,
              ),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 20,right: 20,top: 27,bottom: 10),
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide: new BorderSide(
                color: MyColor.textFiledInActiveColor, width: 1.0),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide:
                new BorderSide(color: MyColor.textFiledActiveColor, width: 1.5),
          ),



          focusedErrorBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide:
            new BorderSide(color: Colors.red, width: 1.5),
          ),
          errorBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide:
            new BorderSide(color: Colors.red, width: 1.5),
          ),

          //fillColor: Colors.green
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
