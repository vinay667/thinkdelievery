
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';

class SettingsWidget extends StatelessWidget
{
 final String text,imageURI;
 SettingsWidget(this.text,this.imageURI);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(left: 15,right: 15),
          child: Row(
            children: <Widget>[
              Image.asset(imageURI,width: 20,height: 20),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child:  Text(
                text,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'George',
                      fontWeight: FontWeight.w700,
                      color: MyColor.defaultTextColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Divider(
          color: Colors.black12,
        )

      ],
    );
  }

}