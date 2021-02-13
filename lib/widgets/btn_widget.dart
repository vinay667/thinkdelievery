

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget
{
  final String btnText;
  ButtonWidget(this.btnText);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          color: Color.fromRGBO(187, 49, 44, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            btnText,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
          SizedBox(width: 10),
          Image.asset(
            'images/arrow_right.png',
            width: 25,
            height: 15,
          )
        ],
      ),
    );
  }

}