import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thinkdelievery/colors/colors.dart';
class AboutUsScreen extends StatefulWidget
{
  AboutUsState createState()=>AboutUsState();
}

class AboutUsState extends State<AboutUsScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:Image.asset(
                      'images/loc_red.png',
                      width: 25,
                      height: 25,
                    ),
                ),
                SizedBox(width: 16),
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'George',
                      fontWeight: FontWeight.w700,
                      color:MyColor.defaultTextColor),
                ),

              ],
            ),

            SizedBox(height: 15),


            Text(
              'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo',

              style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  fontFamily: 'George',
                  color:MyColor.defaultTextColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 40,
            ),




          ],


        ),
      ),







    );
  }

}


