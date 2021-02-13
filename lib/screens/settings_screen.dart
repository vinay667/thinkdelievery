import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:thinkdelievery/screens/address_screen.dart';
import 'package:thinkdelievery/screens/all_cards_screen.dart';
import 'package:thinkdelievery/screens/change_password.dart';
import 'package:thinkdelievery/screens/edit_profile_screen.dart';
import 'package:thinkdelievery/screens/faqs_screen.dart';
import 'package:thinkdelievery/screens/login_screen.dart';
import 'package:thinkdelievery/screens/notification_screen.dart';
import 'package:thinkdelievery/widgets/settings_widget.dart';
import 'package:toast/toast.dart';

import 'about_us_screen.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  var _fromData;
  String name='',email='',phone='',profileImage='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          InkWell(
            onTap: ()async{
              final result= await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
              if(result!=null)
              {
                checkInternetAPIcall();
              }
            },
            child:   Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                width: double.infinity,
                height: 181,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(187, 49, 44, 1),
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(35)),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'George',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),

                        Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'George',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),


                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Container(
                                    width: 48,
                                    height: 48,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image:profileImage!=null?
                                            NetworkImage(profileImage):
                                            AssetImage(
                                                'images/dum_men.jpg')



                                        ))),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 9, bottom: 3),
                                          child: Text(
                                            name==null?'':name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          phone,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color.fromRGBO(
                                                  254, 254, 254, 1),
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Text(
                                        email,
                                        style: TextStyle(
                                          color:
                                          Color.fromRGBO(254, 254, 254, 0.7),
                                          fontSize: 13.0,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 0.17,
                                        ),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddressScreen()));
            },
            child: SettingsWidget('Saved Addresses', 'images/loc_set.png'),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllCardsScreen()));
            },
            child: SettingsWidget('Saved Cards', 'images/card_set.png'),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()));
            },
            child: SettingsWidget('Change Password', 'images/lock_set.png'),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen(true)));
            },
            child: SettingsWidget('Notifications', 'images/not_set.png'),
          ),

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsScreen()));
            },
            child:  SettingsWidget('About Us', 'images/info_set.png'),
          ),

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQScreen()));
            },
            child:   SettingsWidget('FAQ’s', 'images/faq_set.png'),
          ),



          Column(
            children: <Widget>[
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: GestureDetector(
                  onTap: (){
                    showLogOutDialog(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Image.asset('images/power_set.png', width: 20, height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'George',
                              fontWeight: FontWeight.w700,
                              color: MyColor.themeColorRed),
                        ),
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(height: 12),
              Divider(
                color: Colors.black12,
              )
            ],
          )
        ],
      ),
    );
  }

  getUserProfile() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('details', context);
    Navigator.pop(context);
    print(response);
    setState(() {
      name=response['name'];
      email=response['email'];
      phone=response['mobile'].toString();
      profileImage=response['pimage'];

    });
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
  showLogOutDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        APIDialog.showAlertDialog(context, 'Logging out...');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        UserModel.setAccessToken('null');
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false);
        Toast.show('Logged Out Successfully !!', context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);

      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Are you sure you want to Log out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
