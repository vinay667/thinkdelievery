import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/screens/main_chat_screen.dart';
import 'package:thinkdelievery/widgets/chat_list_item.dart';
class ChatScreen extends StatefulWidget {
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: MyColor.appBgColor,
      body:Padding(
        padding: EdgeInsets.only(left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 50),
            Text(
              'Message',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'George',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(40, 43, 47, 1)),
            ),
            SizedBox(height: 20),
            Stack(
              children: <Widget>[
                Container(
                   height: 57,
                  child: TextFormField(
                    //controller: textControllerSearch,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        color: Color.fromRGBO(40, 43, 47, 1),
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans'),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, right: 50,top: 5),
                      hintStyle: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(40, 43, 47, 0.2),
                          fontSize: 17),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: MyColor.themeColorRed, width: 1.5)),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, top: 18),
                          child: Image.asset('images/search_ic.png',
                              width: 20, height: 20),
                        ),
                      )),
                )
              ],
            ),
            SizedBox(height: 22),

            Expanded(
              child: ListView.builder(
                  itemCount: 9,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                      onTap: (){

                      },
                      child: ChatListItem(position),
                    );
                  }),
            )



          ],
        ),
      )




    );

  }





}
