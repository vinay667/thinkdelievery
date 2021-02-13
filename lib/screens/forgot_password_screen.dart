
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/widgets/btn_widget_blank.dart';
import 'package:thinkdelievery/widgets/custom_container_widget.dart';
import 'package:thinkdelievery/widgets/input_field_widget.dart';
class ForgotPasswordScreen extends StatefulWidget
{
  ForgotPasswordState createState()=>ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPasswordScreen>
{
  FocusNode emailFocusNode = new FocusNode();
  var textControllerEmail =new TextEditingController();
  var _fromData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[

            SizedBox(height: 120),

            Center(
              child:  Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'George',
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(53,52,89, 1)),
              ),
            ),

            SizedBox(height: 15),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Enter The Eamil Address Associated With Your Account',
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'George',
                    color: MyColor.defaultTextColor),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),


            SizedBox(height: 30),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),

              child:

              InputBoxWidget(
                  labelText: 'Email or Phone Number',
                  focusNode: emailFocusNode,
                  controller: textControllerEmail,
                  validator: emailValidator,
                  onTapTrigger: _requestFocusEmail),

              /*CustomContainer(
              labelText: 'Enter Email',
              focusNode:emailFocusNode,
              hintText: 'Enter email',
              onTap: _requestFocusEmail,
              textBgColor: MyColor.appBgColor,

            ),*/
            ),

            SizedBox(height: 35),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child:  InkWell(
                onTap: () {


                  _submitHandler(context);
                },
                child: ButtonWidgetBlank('RESET PASSWORD'),
              ),
            )
          ],
        ),
      )


    );
  }
  String emailValidator(String value) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'Email is required and should be valid Email address.';
    }
    return null;
  }
  void _submitHandler(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(textControllerEmail.text);
  //  forgotPasswordAPI();
  }
  void _requestFocusEmail() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocusNode);
    });
  }

  forgotPasswordAPI() async {
    _fromData["email"]=textControllerEmail.text;
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPI(
        'forgotpassword',
        _fromData,
        context);
    Navigator.pop(context);
    print(response);
  /*  Route route = MaterialPageRoute(
        builder: (context) => MainScreen());*/
   /* Navigator.pushAndRemoveUntil(
        context, route, (Route<dynamic> route) => false);*/
   /* Toast.show('Logged in Successfully !!', context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.black);*/
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fromData = {
      'email': '',
    };
  }
}



