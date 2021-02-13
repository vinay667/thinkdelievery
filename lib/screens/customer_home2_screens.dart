import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/dialog/message_dialog.dart';
import 'package:thinkdelievery/model/coupon_model.dart';
import 'package:thinkdelievery/model/package_model.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/Utils.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/constants.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:path/path.dart' as path;
import 'package:thinkdelievery/screens/customer_home_screen.dart';
import 'package:thinkdelievery/screens/landing_screen.dart';
import 'package:thinkdelievery/widgets/btn_widget_blank.dart';
import 'package:thinkdelievery/widgets/custom_container_widget.dart';
import 'package:toast/toast.dart';

import 'coupon_code_screen.dart';

class Home2 extends StatefulWidget {
  Home2State createState() => Home2State();
}

class Home2State extends State<Home2> {
  FocusNode delDateNode = new FocusNode();
  bool cbValue = false;
  List<dynamic> deliveryVehicleList = [];
  int selectedBox = 0;
  String couponName = '';
  int deliveryFee = 0;
  int finalAmount = 0;
  int seletedDeliveryTypeID = null;
  int couponDiscount = 0;
  String userName='';
  var textControllerDate = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.appBgColor,
        body: ListView(padding: EdgeInsets.zero, children: <Widget>[
          Container(
            height: 213,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(187, 49, 44, 1),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 60),
                Center(
                  child: Text(
                    'Home',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'George',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(250, 250, 255, 1)),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 0.5,
                        width: 100,
                        color: Color.fromRGBO(250, 250, 255, 1),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                          height: 1.5, width: 100, color: Colors.white),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        height: 0.5,
                        width: 100,
                        color: Color.fromRGBO(250, 250, 255, 1),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -23.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Image.asset(
                                          'images/package_icon.png'),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Package Information',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Color.fromRGBO(250, 250, 255, 0.9)),
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromRGBO(
                                              250, 250, 255, 1))),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset('images/del_icon.png'),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Delivery & Payment',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Color.fromRGBO(250, 250, 255, 0.9)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Delivery Type',
              style: TextStyle(
                  color: Color.fromRGBO(40, 43, 47, 0.8),
                  fontSize: 13,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 15),
          Container(
              height: 65,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ListView.builder(
                  itemCount: deliveryVehicleList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int pos) {
                    return Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedBox = pos;
                              deliveryFee = deliveryVehicleList[pos]['price'];
                              finalAmount = deliveryFee - couponDiscount;
                              seletedDeliveryTypeID =
                                  deliveryVehicleList[pos]['id'];
                            });
                          },
                          child: Container(
                              width: 90,
                              height: 62,
                              decoration: BoxDecoration(
                                  color: selectedBox == pos
                                      ? MyColor.textFiledActiveColor
                                      : Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: MyColor.textFiledActiveColor),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Padding(
                                padding: EdgeInsets.all(17),
                                child: Image.network(
                                    deliveryVehicleList[pos]['image'],
                                    color: selectedBox == pos
                                        ? Colors.white
                                        : MyColor.textFiledActiveColor),
                              )),
                        ),
                        SizedBox(width: 15)
                      ],
                    );
                  })),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'Estimated Delivery Date',
              focusNode: delDateNode,
              hintText: '12th June',
              onTap: _requestFocusDelDate,
              isEnabled: false,
              textBgColor: MyColor.appBgColor,
              controller: textControllerDate,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Payment Details',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'George',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(40, 43, 47, 1)),
            ),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            // height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(114, 177, 218, 1),
                borderRadius: BorderRadius.circular(25)),

            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Delivery Fee',
                        style: TextStyle(
                            color: Color.fromRGBO(250, 250, 255, 0.9),
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 20, right: 20),
                      child: Text(
                        '\$' + deliveryFee.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(250, 250, 255, 0.9),
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(
                    color: Color.fromRGBO(75, 144, 190, 1),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        'Coupon ' + couponName,
                        style: TextStyle(
                            color: Color.fromRGBO(250, 250, 255, 0.9),
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 20),
                      child: Text(
                        '\$' + couponDiscount.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(250, 250, 255, 0.9),
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(
                    color: Color.fromRGBO(75, 144, 190, 1),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        'Total',
                        style: TextStyle(
                            color: Color.fromRGBO(250, 250, 255, 0.9),
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 20),
                      child: Text(
                        '\$' + finalAmount.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(250, 250, 255, 0.9),
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () async {



              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CouponScreen()));
              if (result != null) {
                print(CouponModel.amount);

                if (CouponModel.type == 'percent') {
                  couponDiscount = finalAmount * int.parse(CouponModel.amount);
                  double dis = couponDiscount / 100;
                  setState(() {
                    couponDiscount = dis.round();
                    finalAmount = deliveryFee - couponDiscount;
                    couponName = '(' + CouponModel.couponName + ')';
                    print(couponName);
                  });
                } else {
                  setState(() {
                    couponDiscount = int.parse(CouponModel.amount);
                    finalAmount = deliveryFee - couponDiscount;
                    couponName = '(' + CouponModel.couponName + ')';
                    print(couponName);
                  });
                }

                //couponDiscount
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1.5, color: MyColor.textFiledActiveColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/coupon.png', width: 35, height: 17),
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 5),
                    child: Text(
                      'Apply Discount Code',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'George',
                          fontWeight: FontWeight.w800,
                          color: MyColor.textFiledActiveColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    value: cbValue,
                    onChanged: (value) {
                      setState(() {
                        cbValue = value;
                      });
                    },
                    activeColor: MyColor.themeColorRed,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  width: MediaQuery.of(context).size.width - 90,
                  child: Text(
                    'Pickup items do not include cash, weapons, live animals, prescription drugs or any illegal items',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(40, 43, 47, 1),
                        fontSize: 12,
                        letterSpacing: -0.2),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () {
               if (cbValue == false) {
                Toast.show(
                    'Please agree to our terms and conditions !!', context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.black);
              } else
                createPackage();

              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrdersScreen()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ButtonWidgetBlank('Pay \$' + finalAmount.toString()),
            ),
          ),
          SizedBox(height: 30),
        ]));
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
  }

  void _requestFocusDelDate() {
    setState(() {
      FocusScope.of(context).requestFocus(delDateNode);
    });
  }

  getDeliveryType() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('delivery/type', context);
    Navigator.pop(context);
    print(response);
    setState(() {
      deliveryVehicleList = response['data'];

    });

    if(deliveryVehicleList.length!=0)
      {
        seletedDeliveryTypeID=deliveryVehicleList[0]['id'];
        deliveryFee=deliveryVehicleList[0]['price'];
        finalAmount=deliveryVehicleList[0]['price'];
      }
  }

  /* getEstimatedPrice() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('delivery/type', context);
    Navigator.pop(context);
    print(response);
    setState(() {
      deliveryVehicleList=response['data'];
    });
  }*/

  getDeliveryDate() async {
    FocusScope.of(context).unfocus();
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('estimate/delivery', context);
    print(response);
    setState(() {
      textControllerDate.text = response['data']['estimate_date'].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
    _fetchUserName();
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getDeliveryType();
      getDeliveryDate();
    }
  }

  createPackage() async {

    APIDialog.showAlertDialog(context, 'Creating Order...');

    try {
      List<Object> filesData = new List<Object>();

      /*for (final file in PackageModel.imageList) {
        filesData.add(MultipartFile.fromFileSync(file.path,
            filename: file.path.split('/').last));
      }*/

      print('');
      var formData = FormData.fromMap({
        'pickup_location': PackageModel.pickUpLocation,
        'pickup_location_lat': PackageModel.sourceLat,
        'pickup_location_long': PackageModel.sourceLong,
        'drop_location': PackageModel.dropLocation,
        'drop_location_lat': PackageModel.destLat,
        'drop_location_long': PackageModel.destLong,
        'package_type': 'bundle',
        'pickup_date_time': '2020/12/31  14:57:01',
        'package_description': PackageModel.packageDesc,
        'delivery_type_id': seletedDeliveryTypeID,
        'estimated_del_date': textControllerDate.text,
        'del_fee': deliveryFee,
        'coupon_discount': couponDiscount,
        'customer_name': userName,
        'final_amount': finalAmount,
     /*   'images': PackageModel.imageList.length!=0?await MultipartFile.fromFile(PackageModel.imageList[0].path,
            filename: "package_image.jpg"):null,*/
          'images':
        [
          for(int i=0;i<PackageModel.imageList.length;i++)
            await MultipartFile.fromFile(PackageModel.imageList[i].path,filename: 'image'+i.toString()+'.jpg'),
        ],
      });

      print(formData.fields);
      print('** API PARAMS**');
      print(PackageModel.imageList);
      Dio dio = new Dio();

      dio.options.headers["Authorization"] = 'Bearer ' + UserModel.accessToken;

      final response = await dio.post(AppConstant.appBaseURL + 'package/create',
          data: formData);
      Navigator.of(context, rootNavigator: true).pop();
      debugPrint(response.data.toString());
      var res = response.data;
      if (res['success']) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (Route<dynamic> route) => false);

        Toast.show(res['message'], context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);

        showDialog(
          context: context,
          builder: (_) => SuccessDialog(
              'Your Order has been placed successfully !!  ',
              context,
              MyColor.themeColorRed),
        );
      } else {
        Toast.show(res['message'], context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
      }

      // Navigator.pop(context, true);
    } catch (errorMessage) {
      Navigator.pop(context);
      if (errorMessage is DioError) {
        print(errorMessage.response);
      } else {}
      String message = errorMessage.toString();
      print(message);
    }
  }


  _fetchUserName() async {
    userName=await MyUtils.getSharedPreferences('name');
  }

}
