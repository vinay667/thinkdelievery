import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';

class MainChatScreen extends StatefulWidget {
  MainChatState createState() => MainChatState();
}

//receive peer ID
class MainChatState extends State<MainChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, top: 22),
            height: 100,
            color: MyColor.appBgColor,
            child: Row(
              children: <Widget>[
                // /Icon(Icons.arrow_back_ios,color: MyColor.driverThemeColor,size: 30,),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'images/loc_red.png',
                    width: 25,
                    height: 25,
                  ),
                ),

                SizedBox(width: 20),
                Container(
                    width: 55,
                    height: 55,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/men2.jpg')))),

                Text('James Charles',
                    style: TextStyle(
                      color: MyColor.defaultTextColor,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w900,
                    )),
              ],
            ),
          ),
          Container(height: 1, color: Colors.grey.withOpacity(0.2)),
          Center(
            child: Container(
              width: 75,
              height: 24,
              decoration: BoxDecoration(
                color: Color.fromRGBO(219, 239, 214, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7)),
              ),
              child: Center(
                child: Text(
                  'Today',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(40, 43, 47, 0.6)),
                ),
              ),
            ),
          ),
          SizedBox(height: 17),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 5,
                itemBuilder: (BuildContext context, int pos) {
                  return Column(
                    children: <Widget>[
                      //  SizedBox(height: 5),
                      pos % 2 == 0
                          ?
                          //my chat
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 60),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Bubble(
                                        margin:
                                            BubbleEdges.only(top: 10, right: 8),
                                        nip: BubbleNip.rightBottom,
                                        color: Color.fromRGBO(114, 177, 218, 1),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              left: 5,
                                              right: 5),
                                          child: Text(
                                              'When do you expect to reach the destination?',
                                              style: TextStyle(
                                                  fontFamily: 'George',
                                                  color: Colors.white,
                                                  letterSpacing: 0.4,
                                                  fontSize: 12
                                                  ),
                                              textAlign: TextAlign.left),
                                        )),
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 5, left: 7),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '09:25 PM',
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    203, 203, 203, 0.7)),
                                          ),
                                        )),
                                  ],
                                )),
                                Padding(
                                  padding: EdgeInsets.only(top: 14, right: 10),
                                  child: Container(
                                      width: 52,
                                      height: 52,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'images/men2.jpg')))),
                                ),
                              ],
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 15),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 15,
                                    ),
                                    child: Container(
                                        width: 52,
                                        height: 52,
                                        margin: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    'images/driver_dummy.jpg')))),
                                  ),
                                  // SizedBox(width: 15),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /*  Container(
                                   margin: EdgeInsets.only(right: 20),
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: Color.fromRGBO(237,179,177,1),
                                       */ /*boxShadow: [
                                         new BoxShadow(
                                             color: Colors.lightBlueAccent
                                                 .withOpacity(0.2),
                                             blurRadius: 10.0,
                                             spreadRadius: 0.1),
                                       ]*/ /*),
                                   child: Padding(
                                     padding: EdgeInsets.all(10),
                                     child: Text(
                                       'Hello This is Flutter',
                                       style: TextStyle(
                                           fontFamily: 'Poppins',
                                           fontSize: 14,
                                           color: Color.fromRGBO(60, 60, 60, 1),
                                           fontWeight: FontWeight.w400,
                                           height: 1.3),
                                     ),
                                   )),*/

                                      Bubble(
                                          margin: BubbleEdges.only(
                                              top: 10, right: 105),
                                          nip: BubbleNip.leftBottom,
                                          color:
                                              Color.fromRGBO(237, 179, 177, 1),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 5,
                                                right: 5),
                                            child: Text(
                                                'I should reach the drop-off location in 7 minutes',
                                                style: TextStyle(
                                                    fontFamily: 'George',
                                                    color: MyColor
                                                        .defaultTextColor,
                                                    letterSpacing: 0.4,
                                                    fontSize: 12
                                                    // fontWeight: FontWeight.normal
                                                    ),
                                                textAlign: TextAlign.left),
                                          )),
                                      Container(
                                          padding: EdgeInsets.only(
                                              top: 5, right: 111),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              '09:27 PM',
                                              style: TextStyle(
                                                  fontFamily: 'OpenSans',
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      203, 203, 203, 0.7)),
                                            ),
                                          )),
                                    ],
                                  ))
                                ],
                              ),
                            ),

                      SizedBox(height: 10)
                    ],
                  );
                }),
          ),
          Container(height: 1, color: Colors.grey.withOpacity(0.2)),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: MyColor.appBgColor,
              ),
              height: 80,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 18, bottom: 20),
                    child: Image.asset('images/chat_smile.png'),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      height: 54,
                      margin: EdgeInsets.only(
                          left: 2, right: 15, top: 14, bottom: 15),
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Color.fromRGBO(40, 43, 47, 1),
                            fontSize: 15,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'OpenSans'),
                        decoration: InputDecoration(
                          hintText: 'Write message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15),
                          hintStyle: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(40, 43, 47, 0.2),
                              fontSize: 17),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          border: Border.all(
                              color: MyColor.driverThemeColor, width: 2)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2, bottom: 2),
                    padding: EdgeInsets.all(13),
                    width: 49,
                    height: 49,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColor.driverThemeColor,
                    ),
                    child: Image.asset('images/chat_send.png'),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
