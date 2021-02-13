import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/screens/customer_home_screen.dart';
import 'package:thinkdelievery/screens/forgot_password_screen.dart';
import 'package:thinkdelievery/screens/landing_screen.dart';
import 'package:thinkdelievery/screens/sign_up_screen.dart';
import 'package:thinkdelievery/widgets/btn_widget.dart';
import 'package:thinkdelievery/widgets/input_field_widget.dart';
import 'package:toast/toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordScreen> {
  FocusNode confirmPasswordFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode oldPasswordFocusNode = new FocusNode();
  var _fromData;
  String userEmail='';
  var textControllerOld = new TextEditingController();
  var textControllerNewPassword = new TextEditingController();
  var textControllerConfirmPassword = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.appBgColor,
        body: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),

                Row(
                  children: <Widget>[

                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Image.asset('images/loc_red.png',
                            width: 30, height: 20),
                      ),
                    ),

                    Spacer(),
                  ],
                ),

                SizedBox(height: 15),

                Text(
                  'Change Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'George',
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(40, 43, 47, 1)),
                ),

                SizedBox(height: 10),
                Text(
                  'You New Password Must Be Different From Previous Used Password.',
                  style: TextStyle(
                      fontSize: 12.5,
                      fontFamily: 'George',
                      color: Color.fromRGBO(40, 43, 47,1)),
                ),

                SizedBox(height: 30),
                InputBoxWidget(
                    labelText: 'New Password',
                    focusNode: passwordFocusNode,
                    isObscureText: true,
                    validator: passwordValidator,
                    controller: textControllerNewPassword,
                    onTapTrigger:_requestFocusPass ),
                SizedBox(height: 35),
                InputBoxWidget(
                    labelText: 'Confirm New Password',
                    focusNode: confirmPasswordFocusNode,
                   validator: passwordValidator,
                   controller: textControllerConfirmPassword,
                   // isObscureText: true,
                    onTapTrigger: _requestFocusConfirmP),
               /* SizedBox(height: 15),
                Text(
                  'Both password must match.',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'MontserratAlternates',
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(40, 43, 47, 1)),
                ),*/
                SizedBox(height: 35),
                InkWell(
                  onTap: () {

                    _submitHandler(context);
                  },
                  child: ButtonWidget('Reset Password'),
                ),
                SizedBox(height: 15),
              ],
            ),
          )
        ));
  }
  void _submitHandler(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    changePassword();

    ///all set to login
  }
  void _requestFocusConfirmP() {
    setState(() {
      FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
    });
  }

  void _requestFocusPass() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }

  void _requestFocusOldPass() {
    setState(() {
      FocusScope.of(context).requestFocus(oldPasswordFocusNode);
    });
  }
  changePassword() async {
    _fromData["password"]=textControllerNewPassword.text;
    _fromData["password_confirmation"]=textControllerConfirmPassword.text;
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Changing password...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPIWithHeader(
        'change/password',
        _fromData,
        context);
    Navigator.pop(context);
    print(response);
    if(response['success'])
      {
        Navigator.pop(context);
        Toast.show(response['message'], context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
      }

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
    _fromData = {
      'password':'',
      'password_confirmation':'',
    };
  }

  getEmail ()async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    userEmail=prefs.getString('email'??'');
    print(userEmail);


  }

  String passwordValidator(String value) {
    if (value.isEmpty || value.length < 6) {
      return 'Password is required.';
    }
    return null;
  }

}
