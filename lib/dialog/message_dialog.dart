import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../colors/colors.dart';
import 'package:http/http.dart' as http;

import '../colors/colors.dart';

class SuccessDialog extends StatelessWidget {
  String message;
  BuildContext context;
  Color themeColor;
  SuccessDialog(this.message,this.context,this.themeColor);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 10.0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                    transform: Matrix4.translationValues(5.0, -5.0, 0.0),
                    width: 24,
                    height: 24,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(1.0, 1.0),
                            spreadRadius: 0.0)
                      ],
                    ),
                    child: Center(
                        child: Image.asset(
                          'images/cross_white.png',color: Colors.white,
                          width: 8,
                          height: 8,
                        ))),


              )
          ),
          SizedBox(height: 10,),
          Text('Message',textAlign:TextAlign.center,style: TextStyle(
              fontSize: 20,
              color: MyColor.infoSnackColor,
              decoration: TextDecoration.none,
              fontFamily: 'OpenSans')),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Text(message,maxLines: 3,overflow: TextOverflow.ellipsis,textAlign:TextAlign.center,style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey,
                decoration: TextDecoration.none,
                fontFamily: 'OpenSans')),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                width: 140,
                height: 45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: themeColor),
                child: Center(child: Text('OK',style: TextStyle(color: Colors.white,fontSize: 17),))
            ),

          ),
          SizedBox(height: 10,),



        ],


      ),

    );
  }






}
