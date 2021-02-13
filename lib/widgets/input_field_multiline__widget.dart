import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';

class CustomContainerMulti extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final Function onTap;
  final String hintText;
  var controller;
  CustomContainerMulti({this.labelText,this.focusNode,this.onTap,this.hintText,this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 100,
        ),
        Positioned(
          bottom: 0,
          child: Container(
              width: MediaQuery.of(context).size.width-60,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: focusNode.hasFocus?MyColor.textFiledActiveColor:MyColor.textFiledInActiveColor, width: 1.5),
              ),
              child:TextFormField(
                onTap: onTap,
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                focusNode: focusNode,
                style: TextStyle(
                    fontSize: 15.0,
                    color: MyColor.defaultTextColor,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600),
                decoration: new InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(40,43,47,0.25),
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  fillColor: Colors.white,
                  //  contentPadding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 20),
                  contentPadding: EdgeInsets.all(10),
                  //fillColor: Colors.green
                ),
              )
          ),
        ),
        Positioned(
            left: 10,
            bottom: 65,
            child: Container(color: Colors.white, child: Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Text(labelText,style:TextStyle(
                    color: focusNode.hasFocus
                        ? MyColor.textFiledActiveColor
                        : Color.fromRGBO(40,43,47,0.8),
                    fontSize: 14,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600

                ),
                )),
            ))
      ],
    );
  }
}
