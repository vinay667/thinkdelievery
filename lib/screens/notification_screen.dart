import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';

class NotificationScreen extends StatefulWidget {
  final bool isShowBack;

  NotificationScreen(this.isShowBack);

  NotificationScreenState createState() => NotificationScreenState(isShowBack);
}

class NotificationScreenState extends State<NotificationScreen> {
  final bool isShowBack;
  Map<String, dynamic> fromData;

  NotificationScreenState(this.isShowBack);

  List<dynamic> notificationList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.appBgColor,
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Row(
                children: <Widget>[
                  isShowBack == true
                      ? InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Image.asset('images/loc_red.png',
                                width: 30, height: 20),
                          ),
                        )
                      : Container(),
                  Text(
                    'Notifications',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'George',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(40, 43, 47, 1)),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int pos) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15),
                          Text(
                            'Today',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(40, 43, 47, 0.4)),
                          ),

                          SizedBox(height: 15),
                          Divider(
                            color: Colors.black.withOpacity(0.2),
                          ),

                          //SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 0),
                                child: Text(
                                  'Just Now',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'OpenSans',
                                      color: Color.fromRGBO(48, 107, 178, 0.8)),
                                ),
                              )
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'Hi, Lorem ipsum this is dummy text lorem ipsum ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.defaultTextColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 12),
                          Divider(
                            color: Colors.black.withOpacity(0.2),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Text(
                                  'Just Now',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'OpenSans',
                                      color: Color.fromRGBO(48, 107, 178, 0.8)),
                                ),
                              )
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'Hi, When do you expect to reach destination?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.defaultTextColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 12),
                          Divider(
                            color: Colors.black.withOpacity(0.2),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Text(
                                  'Just Now',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'OpenSans',
                                      color: Color.fromRGBO(48, 107, 178, 0.8)),
                                ),
                              )
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'Hi, When do you expect to reach destination?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.defaultTextColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 12),
                          Divider(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      );
                    }),
              )
            ],
          ),
        ));
  }

  getUserProfile() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response =
        await helper.postAPIWithHeader('pushnotification', fromData, context);
    Navigator.pop(context);
    print(response);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getUserProfile();
    }
  }
}
