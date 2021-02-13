
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/screens/login_screen.dart';
import 'package:thinkdelievery/widgets/btn_widget.dart';
import 'package:thinkdelievery/widgets/input_field__phone_widget.dart';
import 'package:thinkdelievery/widgets/input_field_widget.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen>{
  FocusNode nameFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode phoneFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode cPasswordFocusNode = new FocusNode();
  var textControllerEmail = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  var textControllerConfirmPassword = new TextEditingController();
  var textControllerName = new TextEditingController();
  var textControllerPhone = new TextEditingController();
  var _fromData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: Padding(
        padding: EdgeInsets.only(left: 25,right: 25),
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
                'Sign Up',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'George',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 43, 47, 1)),
              ),
              SizedBox(height: 45),


              InputBoxWidget(
                  labelText: 'Your Name',
                  focusNode: nameFocusNode,
                  validator: emptyStringValidator,
                  controller: textControllerName,
                  onTapTrigger: _requestFocusName),


              SizedBox(height: 35),



              InputBoxWidget(
                  labelText: 'Email Address',
                  focusNode: emailFocusNode,
                  validator: emailValidator,
                  controller: textControllerEmail,
                  onTapTrigger: _requestFocusEmail),

              SizedBox(height: 35),
              InputBoxPhoneWidget(
                  labelText: 'Phone Number',
                  focusNode: phoneFocusNode,
                  validator: phoneValidator,
                  controller: textControllerPhone,
                  onTapTrigger: _requestFocusPhone),

              SizedBox(height: 35),

              InputBoxWidget(
                  labelText: 'Password',
                  focusNode: passwordFocusNode,
                  isObscureText: true,
                  controller: textControllerPassword,
                  validator: emptyStringValidator,
                  onTapTrigger: _requestFocusPassword),

              SizedBox(height: 35),
              InputBoxWidget(
                  labelText: 'Confirm Password',
                  focusNode: cPasswordFocusNode,
                  isObscureText: true,
                  controller: textControllerConfirmPassword,
                  validator: emptyStringValidator,
                  onTapTrigger: _requestFocusCPassword),

              SizedBox(height: 18),
              Text(
                'By signing up, You agree to our Terms & Conditions and Privacy Policy',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'George',
                    color: Color.fromRGBO(40, 43, 47, 0.7)),
              ),
              SizedBox(height: 35),
             InkWell(
               onTap: (){

                 _submitHandler(context);

               },
               child:  ButtonWidget('Sign Up'),
             ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an Account?',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(14, 11, 32, 1)),
                  ),
                  InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Text(
                      ' Sign In',
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

              SizedBox(height: 35),



            ],
          ),
        )
      )

    );
  }


  void _requestFocusName() {
    setState(() {
      FocusScope.of(context).requestFocus(nameFocusNode);
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


  void _requestFocusCPassword() {
    setState(() {
      FocusScope.of(context).requestFocus(cPasswordFocusNode);
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
    createUser();

  }
  createUser() async {
    _fromData["email"]=textControllerEmail.text;
    _fromData["name"]=textControllerName.text;
    _fromData["mobile"]=textControllerPhone.text;
    _fromData["password"]=textControllerPassword.text;
    //_fromData["confirm_password"]=textControllerConfirmPassword.text;
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Creating account...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPI(
        'usersignup',
        _fromData,
        context);

    if(response['success'])
      {
        Navigator.pop(context);
        Route route = MaterialPageRoute(
            builder: (context) => LoginScreen());
        Navigator.pushAndRemoveUntil(
            context, route, (Route<dynamic> route) => false);
        Toast.show(response['message'], context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
      }
    else
      {
        Toast.show(response['message'], context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);

      }



  }
  String phoneValidator(String value) {
    if (value.length<10) {
      return 'Phone number should have atleast 10 digits';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fromData = {
      'name':'',
      'mobile':'',
      'email': '',
      'password': '',
      'device_type':'android',
      'device_token':'XjdAggfAhgAff',
      'device_id':'ahdgfdgfef'
    };
  }


}


