
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/location_model.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/constants.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:thinkdelievery/screens/custom_picker.dart';
import 'package:thinkdelievery/screens/location_picker_screen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class SelectLocationScreen extends StatefulWidget {
  final String addressType;
  SelectLocationScreen(this.addressType);
  SelectLocationScreenState createState() => SelectLocationScreenState(addressType);
}

class SelectLocationScreenState extends State<SelectLocationScreen>{
  bool isLoading = false;
  final String addressType;
  SelectLocationScreenState(this.addressType);
  List<dynamic> recentSearchList=[];
  List<dynamic> addressList=[];
  List<dynamic> placesList = [];
  var locationController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 60),

           GestureDetector(
             onTap: (){
               Navigator.pop(context);
             },
             child:Image.asset('images/loc_red.png',width: 30,height: 20),
           ),

            SizedBox(height: 20),

            Text(
              'Search for '+addressType+ ' Location',
              style: TextStyle(
                  fontSize: 21,
                  fontFamily: 'George',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(40, 43, 47, 1)),
            ),
            SizedBox(height: 20),



            Stack(
              children: <Widget>[
              GestureDetector(
                onTap: () async {
                  final result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomPicker()));
                  if(result!=null)
                  {
                    Navigator.pop(context,'Location Selected');
                  }
                },
                child:   Container(
                  // height: 53,
                  child: TextFormField(
                    maxLines: 1,
                    controller: locationController,
                    keyboardType: TextInputType.text,
                    enabled: false,
                    style: TextStyle(
                        color: Color.fromRGBO(40, 40, 40, 1),
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontFamily: 'OpenSans'),
                    decoration: InputDecoration(
                      hintText: 'Search Location',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15,right: 50),
                      hintStyle: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(40,43,47,0.2),
                          fontSize: 17),
                    ),
                  ),
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                          color: MyColor.textFiledActiveColor, width: 1.5)),
                ),
              ),
                GestureDetector(
                  onTap: () {},
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(

                        onTap: (){
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, top: 15),
                          child:
                          Image.asset('images/search_ic.png',
                              width: 20, height: 20),
                        ),

                      )),
                )
              ],
            ),
            SizedBox(height: 25),

            GestureDetector(
              onTap: ()async{
                final result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPickerScreen()));
               if(result!=null)
                 {
                   Navigator.pop(context,'Address Selected');
                 }
                },
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 2,right: 2),
                    child: Image.asset('images/locv_red.png',width: 17,height: 15),

                  ),
                  Text('Select location Via map',style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(187,49,44,0.9),
                      fontSize: 13),)

                ],


              ),
            ),

            SizedBox(height: 35),


            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  recentSearchList.length==0?Container():
                  Text(

                    'Recent Searches',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'George',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(40, 43, 47, 1)),
                  ),
                  SizedBox(height: 15),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: recentSearchList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context,int pos)
                      {
                        return  InkWell(
                          onTap: (){
                            Navigator.pop(context,'Address Updated');
                            LocationModel.setLattitude(double.parse(recentSearchList[pos]['latitude']));
                            LocationModel.setLongitude(double.parse(recentSearchList[pos]['longitude']));
                            LocationModel.setAddress(recentSearchList[pos]['address']);
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Image.asset('images/history_ic.png',width: 15,height:15),
                                  ),
                                  SizedBox(width: 7),
                                  Expanded(
                                    child: Text(
                                      recentSearchList[pos]['address'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(40, 43, 47, 1)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )


                                ],
                              ),

                              SizedBox(height: 8),
                              pos==1?Container():
                              Divider(
                                color: Colors.grey.withOpacity(0.3),
                              )



                            ],
                          ),
                        );
                      }

                  ),
                  SizedBox(height: 30),
                  addressList.length==0?Container():
                  Text(
                    'Saved Addresses',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'George',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(40, 43, 47, 1)),
                  ),
                  SizedBox(height: 15),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: addressList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context,int pos)
                      {
                        return   Column(
                          children: <Widget>[
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Image.asset('images/home_ic.png',width: 20,height:20),
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Text(
                                      addressList[pos]['address_type'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'George',
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(40, 43, 47, 1)),
                                    ),
                                    SizedBox(height: 2),



                                    Text(
                                      addressList[pos]['flat_no'] == null
                                          ? 'Address not Available'
                                          : addressList[pos]['flat_no'] +
                                          ',' +
                                          addressList[pos]['road'] +
                                          ',' +
                                          addressList[pos]['state'] +
                                          ',' +
                                          addressList[pos]['pin_code']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(40, 43, 47, 0.8)),
                                    ),
                                  ],
                                )


                              ],
                            ),

                            SizedBox(height: 8),
                            pos==1?Container():
                            Divider(
                              color: Colors.grey.withOpacity(0.3),
                            )



                          ],
                        );
                      }

                  ),
                ],
              ),
            ),



          ],
        ),
      )




    );
  }





  getRecentSearches() async {
    FocusScope.of(context).unfocus();
    String userID=UserModel.userId;
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('recent/$userID', context);
    Navigator.pop(context);
    print(response);
    if(response['success'].toString()=='true')
    {
      setState(() {
        recentSearchList=response['data'];
      });
    }
    else if(response['message']=='Invalid User Id')
    {
      Toast.show('No recent searches !!', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.black);

    }

    getAllAddress();
  }
  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getRecentSearches();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
  }
  getAllAddress() async {
    String userId=UserModel.userId;
    print(userId);
    FocusScope.of(context).unfocus();
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('getaddress/$userId', context);
    print(response);
    if(response['success'].toString()=='true')
    {
      setState(() {
        addressList = response['data'];
      });
    }
    else if(response['message']=='Invalid Id')
    {


    }

  }

}


