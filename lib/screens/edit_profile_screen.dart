import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/constants.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:thinkdelievery/widgets/btn_widget.dart';
import 'package:thinkdelievery/widgets/input_field__phone_widget.dart';
import 'package:thinkdelievery/widgets/input_field_widget.dart';
import 'package:toast/toast.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileState createState() => EditProfileState();
}
class EditProfileState extends State<EditProfileScreen> {
  File _image;
  final picker = ImagePicker();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  FocusNode userNameFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode phoneFocusNode = new FocusNode();
  String profileImage='';
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode vehicleFocusNode = new FocusNode();
  var textControllerEmail = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  var textControllerPhone = new TextEditingController();
  var textControllerName = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        backgroundColor: MyColor.appBgColor,
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: MyColor.themeColorRed,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 55),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'images/loc_red.png',
                              width: 25,
                              height: 25,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 13),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 21,
                                fontFamily: 'George',
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Center(
                          child: Container(
                        width: 110,
                        height: 84,
                        child: Stack(
                          children: <Widget>[
                            _image == null
                                ? Container(
                                    width: 84,
                                    height: 84,
                                    margin: EdgeInsets.only(right: 15, left: 5),
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: profileImage!=null
                                                ? NetworkImage(profileImage)
                                                : AssetImage(
                                                    'images/dum_men.jpg'))))
                                : Container(
                                    width: 84,
                                    height: 84,
                                    margin: EdgeInsets.only(right: 15, left: 5),
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new FileImage(_image))),
                                  ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    margin: EdgeInsets.only(right: 20, left: 5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: MyColor.driverThemeColor,
                                          width: 1.5),
                                    ),
                                    child: Image.asset(
                                      'images/edit_profile.png',
                                      color: MyColor.themeColorRed,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ))
                    ],
                  )),
              SizedBox(height: 45),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: <Widget>[
                    InputBoxWidget(
                        labelText: 'Name',
                        focusNode: userNameFocusNode,
                        controller: textControllerName,
                        validator: emptyStringValidator,
                        onTapTrigger: _requestFocusUserName),
                    SizedBox(height: 25),
                    InputBoxWidget(
                        labelText: 'Email',
                        focusNode: emailFocusNode,
                        controller: textControllerEmail,
                        validator: emailValidator,
                        onTapTrigger: _requestFocusEmail),
                    SizedBox(height: 25),
                    InputBoxPhoneWidget(
                        labelText: 'Phone',
                        controller: textControllerPhone,
                        focusNode: phoneFocusNode,
                        validator: phoneValidator,
                        onTapTrigger: _requestFocusPhone),

                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        _submitHandler(context);
                      },
                      child: ButtonWidget('UPDATE PROFILE'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _requestFocusUserName() {
    setState(() {
      FocusScope.of(context).requestFocus(userNameFocusNode);
    });
  }

  void _requestFocusEmail() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocusNode);
    });
  }

  void _requestFocusPhone() {
    setState(() {
      FocusScope.of(context).requestFocus(phoneFocusNode);
    });
  }

  void _requestFocusPassword() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }

  getUserProfile() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('details', context);
    Navigator.pop(context);
    print(response);
    setState(() {
      textControllerName.text = response['name'];
      textControllerEmail.text = response['email'];
      textControllerPhone.text = response['mobile'].toString();
      textControllerPassword.text = 'dqdegwgrg';
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  String emailValidator(String value) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'Email is required and should be valid Email address.';
    }
    return null;
  }

  String emptyStringValidator(String value) {
    if (value.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }

  void _submitHandler(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    updateProfileData();
  }

  updateProfileData() async {
    print(textControllerName.text);
    print(textControllerPhone.text);
    print(textControllerEmail.text);
    print(UserModel.userId);
    APIDialog.showAlertDialog(context, 'Updating Profile...');
    try {
      var formData;
      if(_image==null)
        {
           formData = FormData.fromMap({
            'name': textControllerName.text,
            'mobile': textControllerPhone.text,
            'email': textControllerEmail.text,
            'id': UserModel.userId,
          });
        }

      else{

        formData = FormData.fromMap({
          'name': textControllerName.text,
          'mobile': textControllerPhone.text,
          'email': textControllerEmail.text,
          'id': UserModel.userId,
          'pimage': _image == null
              ? null
              : await MultipartFile.fromFile(_image.path,
              filename: "profile_pic.jpg"),
        });
      }
      Dio dio = new Dio();
      print(AppConstant.appBaseURL+'updateprofile');
      dio.options.headers["Authorization"] = 'Bearer ' + UserModel.accessToken;
      final response = await dio.post(AppConstant.appBaseURL + 'updateprofile',
          data: formData);


      var res = response.data;
      print(res);
      Navigator.of(context, rootNavigator: true).pop();

      if (res['message'] == 'Profile Updated') {
        Toast.show('Profile Updated Successfully !!', context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
        Navigator.pop(context, 'Profile');
      } else {
        Toast.show(res['message'], context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
      }
    } on DioError catch (errorMessage) {
      Navigator.pop(context);
      String message = errorMessage.response.toString();
      print(message);
    }
  }

  String phoneValidator(String value) {
    if (value.length < 10) {
      return 'Phone number should have atleast 10 digits';
    }
    return null;
  }
}
