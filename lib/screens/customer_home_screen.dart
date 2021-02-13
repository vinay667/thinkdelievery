import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/location_model.dart';
import 'package:thinkdelievery/model/package_model.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/constants.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:thinkdelievery/screens/customer_home2_screens.dart';
import 'package:thinkdelievery/screens/select_location_screen.dart';
import 'package:thinkdelievery/widgets/btn_widget.dart';
import 'package:thinkdelievery/widgets/custom_container_widget.dart';
import 'package:thinkdelievery/widgets/input_field_multiline__widget.dart';
import 'package:toast/toast.dart';

class CustomerHomeScreen extends StatefulWidget {
  CustomerHomeScreenState createState() => CustomerHomeScreenState();
}

class CustomerHomeScreenState extends State<CustomerHomeScreen> {
  FocusNode pickUpPointNode = new FocusNode();
  FocusNode dropPointNode = new FocusNode();
  FocusNode datePointNode = new FocusNode();
  bool cbValue = false;
  List<bool> _isChecked;
  File _image1, _image2, _image3;
  String selectedPackageType = '';
  List<File> selectedPackageImages = [];
  List<dynamic> packageTypes = [];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<String> packageContentList = [
    'Food/Beverage',
    'Book',
    'Clothes/Accessories',
    'Household Items',
    'Furniture',
    'Electronics',
    'Sports Equipm'
  ];
  final picker = ImagePicker();
  FocusNode desPointNode = new FocusNode();
  var textEditControllerPickUp = new TextEditingController();
  var textEditControllerDrop = new TextEditingController();
  var textEditControllerPickUpDate = new TextEditingController();
  var textEditControllerDesc = new TextEditingController();
  String dropdownValue = 'Select';
  double pickUpLat;
  double pickUpLong;
  double dropLat;
  double dropLong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 230,
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
                              Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child:
                                        Image.asset('images/package_icon.png'),
                                  )),
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
                              GestureDetector(
                                onTap: () {
                                  /* Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Home2()));*/
                                },
                                child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                250, 250, 255, 1))),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Image.asset('images/del_icon.png'),
                                    )),
                              ),
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
          SizedBox(height: 20),
          Container(
            //padding: EdgeInsets.only(left: 30,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: CustomContainer(
                    labelText: 'Pickup Location',
                    focusNode: pickUpPointNode,
                    onTap: _requestFocusPass,
                    isEnabled: false,
                    hintText: 'Enter Location',
                    rightIcon: 'images/search_ic.png',
                    textBgColor: Colors.white,
                    controller: textEditControllerPickUp,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: CustomContainer(
                    labelText: 'Drop-off Location',
                    focusNode: dropPointNode,
                    hintText: 'Enter Location',
                    rightIcon: 'images/search_ic.png',
                    onTap: _requestFocusDest,
                    isEnabled: false,
                    textBgColor: Colors.white,
                    controller: textEditControllerDrop,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: CustomContainer(
                    labelText: 'Pickup Date and Time',
                    focusNode: datePointNode,
                    rightIcon: 'images/calender_ic.png',
                    hintText: 'Enter Date and Time',
                    onTap: _requestFocusDate,
                    isEnabled: false,
                    controller: textEditControllerPickUpDate,
                    textBgColor: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 80,
                      ),
                      Positioned(
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              showPackageTypeDialog();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 60,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: /*focusNode.hasFocus?MyColor.textFiledActiveColor:*/ MyColor
                                        .textFiledInActiveColor,
                                    width: 1.5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      // width: MediaQuery.of(context).size.width-,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        selectedPackageType.length == 0
                                            ? 'Select Package Type'
                                            : selectedPackageType,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: MyColor.defaultTextColor,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w600),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                          left: 10,
                          bottom: 45,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  'Select Package Type',
                                  style: TextStyle(
                                      color: Color.fromRGBO(40, 43, 47, 0.8),
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600),
                                )),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: CustomContainerMulti(
                    labelText: 'Package Description',
                    focusNode: desPointNode,
                    hintText: 'Enter Message',
                    onTap: _requestFocusDes,
                    controller: textEditControllerDesc,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Package Image',
                          style: TextStyle(
                              color: Color.fromRGBO(40, 43, 47, 0.8),
                              fontSize: 13,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '(Optional)',
                          style: TextStyle(
                            color: Color.fromRGBO(40, 43, 47, 0.8),
                            fontSize: 12,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    SizedBox(width: 30),
                    InkWell(
                      onTap: () {
                        getImage1();
                      },
                      child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromRGBO(40, 43, 47, 1))),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: _image1 == null
                                ? Image.asset('images/dummy_gal.png')
                                : Image.file(_image1),
                          )),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        getImage2();
                      },
                      child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromRGBO(40, 43, 47, 1))),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: _image2 == null
                                ? Image.asset('images/dummy_gal.png')
                                : Image.file(_image2),
                          )),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        if (_image1 != null && _image2 != null) {
                          getImage3();
                        }
                      },
                      child: _image3 == null
                          ? Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 0.8,
                                      color: Color.fromRGBO(40, 43, 47, 1))),
                              child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Center(
                                    child: Image.asset('images/add_red.png'),
                                  )))
                          : InkWell(
                              onTap: () {
                                getImage3();
                              },
                              child: Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Color.fromRGBO(40, 43, 47, 1))),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: _image3 == null
                                        ? Image.asset('images/dummy_gal.png')
                                        : Image.file(_image3),
                                  )),
                            ),
                    )
                  ],
                ),
                SizedBox(height: 35),
                InkWell(
                  onTap: () {
                    /*  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home2()));*/

                    if (textEditControllerPickUp.text == '') {
                      Toast.show('Source Location cannot be empty !!', context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.black);
                    } else if (textEditControllerDrop.text == '') {
                      Toast.show('Drop Location cannot be empty !!', context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.black);
                    } else if (textEditControllerPickUpDate.text == '') {
                      Toast.show('Pick up date cannot be empty !!', context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.black);
                    } else if (selectedPackageType == '') {
                      Toast.show('Please select a Package Type !!', context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.black);
                    } else if (textEditControllerDesc.text == '') {
                      Toast.show(
                          'Please add some description about the package !! !!',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.black);
                    } else {
                      _moveUserToNextScreen();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: ButtonWidget('Next'),
                  ),
                ),
                SizedBox(height: 35),
              ],
            ),
          )
        ],
      ),
    );
  }

  _requestFocusPass() async {
    setState(() {
      FocusScope.of(context).requestFocus(pickUpPointNode);
    });
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectLocationScreen('Pickup')));

    if (result != null) {
      setState(() {
        textEditControllerPickUp.text = LocationModel.address;
      });

      pickUpLat = LocationModel.lattitude;
      pickUpLong = LocationModel.longitude;
    }
  }

  Future<void> _requestFocusDest() async {
    setState(() {
      FocusScope.of(context).requestFocus(dropPointNode);
    });
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectLocationScreen('Drop-off')));
    if (result != null) {
      setState(() {
        textEditControllerDrop.text = LocationModel.address;
      });
      dropLat = LocationModel.lattitude;
      dropLong = LocationModel.longitude;
    }
  }

  void _requestFocusDate() {
    setState(() {
      FocusScope.of(context).requestFocus(datePointNode);
    });
    DateTime now = new DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);
    DatePicker.showDateTimePicker(context,
        theme: DatePickerTheme(
          headerColor: MyColor.themeColorRed,
          backgroundColor: Colors.white,
          itemStyle: TextStyle(
              color: MyColor.defaultTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              fontFamily: 'OpenSans'),
          doneStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'OpenSans'),
          cancelStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'OpenSans'),
        ),
        minTime: DateTime(
            now.year, now.month, now.day, now.hour, now.minute, now.second),
        /* minTime: DateTime(2020, 5, 5, 20, 50),
        maxTime: DateTime(2020, 6, 7, 05, 09),*/

        showTitleActions: true, onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      print('confirm $date');

      DateTime dateTime = DateTime.parse(date.toString());
      final DateFormat timeFormatter = DateFormat.yMEd().add_jms();
      String timeAsString = timeFormatter.format(dateTime);
      print(timeAsString);

      setState(() {
        textEditControllerPickUpDate.text = timeAsString;
      });
    },
        currentTime: DateTime(
            now.year, now.month, now.day, now.hour, now.minute, now.second));
  }

  void _requestFocusDes() {
    setState(() {
      FocusScope.of(context).requestFocus(desPointNode);
    });
  }

  showPackageTypeDialog() {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35))),
                          margin: EdgeInsets.zero,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 22, right: 15),
                                      child: Image.asset(
                                          'images/cross_rect.png',
                                          width: 25,
                                          height: 25),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 5),
                                child: Text(
                                  'Select Package Content Type',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'George',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(40, 43, 47, 1)),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: packageTypes.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int pos) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 10),
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 7),
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Checkbox(
                                                  value: _isChecked[pos],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _isChecked[pos] = value;
                                                    });
                                                    if (selectedPackageType
                                                            .length ==
                                                        0) {
                                                      selectedPackageType =
                                                          packageTypes[pos]
                                                              ['package_name'];
                                                      _updateViews();
                                                    } else {
                                                      selectedPackageType =
                                                          selectedPackageType +
                                                              ',' +
                                                              packageTypes[pos][
                                                                  'package_name'];
                                                      _updateViews();
                                                    }

                                                    print(selectedPackageType);
                                                    print(_isChecked);
                                                  },
                                                  activeColor:
                                                      MyColor.themeColorRed,
                                                  checkColor: Colors.white,
                                                  tristate: false,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 12, right: 5),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    90,
                                                child: Text(
                                                  packageTypes[pos]
                                                      ['package_name'],
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: _isChecked[pos] ==
                                                              false
                                                          ? Color.fromRGBO(
                                                              40, 43, 47, 1)
                                                          : MyColor
                                                              .themeColorRed,
                                                      fontSize: 13,
                                                      letterSpacing: -0.2),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      })),
                              SizedBox(height: 20),
                              Container(
                                height: 58,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                //color: Colors.pink,
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700),
                                  decoration: new InputDecoration(
                                    labelText: 'Please specify',
                                    labelStyle: TextStyle(
                                      color: Color.fromRGBO(40, 43, 47, 0.25),
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: Color.fromRGBO(187, 49, 44, 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Done',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ));
          },
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  Future getImage1() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image1 = File(pickedFile.path);
    });
  }

  Future getImage2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image2 = File(pickedFile.path);
    });
  }

  Future getImage3() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image3 = File(pickedFile.path);
    });
  }

  _moveUserToNextScreen() {
    if (selectedPackageImages.length != 0) {
      selectedPackageImages.clear();
    }
    if (_image1 != null) {
      selectedPackageImages.add(_image1);
    }
    if (_image2 != null) {
      selectedPackageImages.add(_image2);
    }

    if (_image3 != null) {
      selectedPackageImages.add(_image3);
    }

    PackageModel.setImageList(selectedPackageImages);
    PackageModel.setPickUpLocation(textEditControllerPickUp.text);
    PackageModel.setPickUpLat(pickUpLat);
    PackageModel.setPickUpLong(pickUpLong);
    PackageModel.setDropLocation(textEditControllerDrop.text);
    PackageModel.setDropLat(dropLat);
    PackageModel.setDropLong(dropLong);
    PackageModel.setPickDate(selectedPackageType);
    PackageModel.setPackageDesc(textEditControllerDesc.text);
    //values set move to next screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home2()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        myBackgroundMessageHandler(message);
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }




  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];

      print("data $data");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("onMessage: $data")));
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      _showNotificationWithDefaultSound(
          notification['title'], notification['body']);
      print('notification ${notification['title']}');
    }

    // Or do other work.
  }

  Future _showNotificationWithDefaultSound(String title, String message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'com.taxiapp', 'taxi_customer', 'channel_description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '$title',
      '$message',
      platformChannelSpecifics,
    );
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  getPackageTypes() async {
    String userId = UserModel.userId;
    print(userId);
    FocusScope.of(context).unfocus();
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('packagelist', context);
    print(response);
    if (response['success'].toString() == 'true') {
      setState(() {
        packageTypes = response['data'];
      });
    }
    _isChecked = List<bool>.filled(packageTypes.length, false);
    /*  else if(response['message']=='Invalid Id')
    {
      Toast.show('No Addresses found !!', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.black);

    }*/
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getPackageTypes();
    }
  }

  _updateViews() {
    setState(() {});
  }
}
