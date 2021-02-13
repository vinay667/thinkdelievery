
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/Utils.dart';
import 'package:thinkdelievery/screens/forgot_password_screen.dart';
import 'package:thinkdelievery/screens/landing_screen.dart';
import 'package:thinkdelievery/screens/sign_up_screen.dart';
import 'package:thinkdelievery/widgets/btn_widget.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/widgets/input_field_widget.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  FocusNode emailFocusNode = new FocusNode();
  String fcmToken='';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FocusNode passwordFocusNode = new FocusNode();
  var textControllerEmail = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  var _fromData;
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
                SizedBox(height: 70),
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(40, 43, 47, 0.9)),
                ),
                SizedBox(height: 8),
                Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'George',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(40, 43, 47, 1)),
                ),
                SizedBox(height: 45),
                InputBoxWidget(
                    labelText: 'Email or Phone Number',
                    focusNode: emailFocusNode,
                    controller: textControllerEmail,
                    validator: emailValidator,
                    onTapTrigger: _requestFocusEmail),
                SizedBox(height: 35),
                InputBoxWidget(
                    labelText: 'Password',
                    focusNode: passwordFocusNode,
                    controller: textControllerPassword,
                    isObscureText: true,
                    validator: passwordValidator,
                    onTapTrigger: _requestFocusPass),
                SizedBox(height: 20),
                Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'MontserratAlternates',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(40, 43, 47, 1)),
                      ),
                    )
                ),
                SizedBox(height: 35),
                InkWell(
                  onTap: () {
                    _submitHandler(context);
                     /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));*/
                  },
                  child: ButtonWidget('Sign In'),
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don’t have an account?',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(14, 11, 32, 1)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        ' Sign Up',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(187, 49, 44, 1)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ));
  }

  void _requestFocusEmail() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocusNode);
    });
  }

  void _requestFocusPass() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }

  void _submitHandler(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    loginUser(context);

    ///all set to login
  }

  loginUser(BuildContext context) async {
    _fromData["email"]=textControllerEmail.text;
    _fromData["password"]=textControllerPassword.text;
    _fromData["device_token"]=fcmToken==null?'This is dummy token':fcmToken;
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Logging in...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPI(
        'userlogin',
        _fromData,
        context);
    Navigator.pop(context);
    _saveUserDetail(response);
    Route route = MaterialPageRoute(
        builder: (context) => MainScreen());
    Navigator.pushAndRemoveUntil(
        context, route, (Route<dynamic> route) => false);
    Toast.show('Logged in Successfully !!', context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.black);
  }
  _saveUserDetail(var response) async {
    UserModel.setAccessToken(response['data']['token']);
    UserModel.setUserId(response['data']['id'].toString());
    MyUtils.saveSharedPreferences('access_token', response['data']['token']);
    MyUtils.saveSharedPreferences('id', response['data']['id'].toString());
    MyUtils.saveSharedPreferences('email', response['data']['email']);
    MyUtils.saveSharedPreferences('name', response['data']['name']);
    MyUtils.saveSharedPreferences('mobile', response['data']['mobile']);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFCMTOken();


    _fromData = {
      'email': '',
      'password': '',
      'device_type':'android',
      'device_token':'',
      'device_id':'ahdgfdgfef'
    };
  }
  String emailValidator(String value) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'Email is required and should be valid Email address.';
    }
    return null;
  }
  fetchFCMTOken()async{
    fcmToken = await MyUtils.getDeviceToken(_firebaseMessaging);
    print(fcmToken);
    print('This is FCM token');
  }

  String passwordValidator(String value) {
    if (value.isEmpty || value.length < 6) {
      return 'Password is required.';
    }
    return null;
  }

}
