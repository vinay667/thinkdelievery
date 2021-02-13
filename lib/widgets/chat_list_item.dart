import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/screens/main_chat_screen.dart';

class ChatListItem extends StatelessWidget {
  int pos;
  ChatListItem(this.pos);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainChatScreen()));
      },
      child: Container(
        decoration: BoxDecoration(

          border:
          Border(bottom: BorderSide(width: 1.0, color: Color(0x66c5e0ff))),
        ),
        child: Column(
          children: <Widget>[
            Divider(
              height: 1,
              color: MyColor.defaultTextColor.withOpacity(0.3),
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                pos%2==0?
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(114,177,218,1),
                     shape: BoxShape.circle
                     // borderRadius: BorderRadius.circular(3.0)

                  ),
                  height: 8.0,
                  width: 8.0,
                ):Container( height: 8.0,
                  width: 8.0,),
                SizedBox(
                  width: 11.0,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                      width: 48,
                      height: 48,
                      margin: EdgeInsets.only(right: 15),
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image:  AssetImage('images/driver_dummy.jpg')
                          )
                      )
                  ),
                ),
               Expanded(
                 child:  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[

                     Row(
                       mainAxisAlignment:MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Padding(
                           padding: EdgeInsets.only(top: 9,bottom: 3),
                           child: Text(
                             'Adalberto',
                             style: TextStyle(
                               color: MyColor.defaultTextColor,
                               fontSize: 17.0,
                               fontFamily: 'OpenSans',
                               fontWeight: FontWeight.w700,
                             ),
                           ),
                         ),



                         Text(
                           'Today 12:00',
                           style: TextStyle(
                               fontSize: 11.5,
                               color: Color.fromRGBO(40,43,47,0.36),
                               fontFamily: 'OpenSans',
                               fontWeight: FontWeight.w500),
                         ),
                       ],
                     ),

                     Container(
                       child:  Text(
                         'Hi, When do you expect to reach destination?',
                         style: TextStyle(
                             color: pos%2!=0?Color.fromRGBO(40,43,47,0.5):MyColor.defaultTextColor,
                             fontSize: 13.0,
                             fontFamily: 'OpenSans',
                             letterSpacing: 0.17,
                             fontWeight: FontWeight.w600),
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                       ),
                     )
                   ],
                 ),
               ),
                SizedBox(
                  width: 3.0,
                ),


                SizedBox(
                  width: 6.0,
                ),
              ],
            ),

            SizedBox(height: 13),

          ],
        ),
      ),
    );
  }
}