

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/address_model.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:thinkdelievery/widgets/btn_widget.dart';
import 'package:thinkdelievery/widgets/custom_container_widget.dart';
import 'package:thinkdelievery/widgets/input_field_border.dart';
import 'package:toast/toast.dart';

class AddAddressScreen extends StatefulWidget {
  final String callbackType;
  final String addId;
  AddAddressScreen(this.callbackType,this.addId);
  AddAddressState createState() => AddAddressState(callbackType,addId);
}
class AddAddressState extends State<AddAddressScreen>{
  final String callbackType;
  final String addId;
  AddAddressState(this.callbackType,this.addId);
  var _fromData;
  String dropdownSelectedItem = 'Address Type';
  List<String> listItems = ['Address Type', 'HOME', 'WORK'];
  FocusNode houseFocusNode = new FocusNode();
  FocusNode roadFocusNode = new FocusNode();
  FocusNode stateFocusNode = new FocusNode();
  FocusNode pinFocusNode = new FocusNode();
  var textControllerFlatNo = new TextEditingController();
  var textControllerColony = new TextEditingController();
  var textControllerState = new TextEditingController();
  var textControllerPinCode = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: ListView(
        padding: EdgeInsets.zero,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child:
                  Image.asset('images/loc_red.png', width: 30, height: 17),
                ),
              ),
              SizedBox(width: 20),
              Text('Add Address',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'George',
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),


          SizedBox(height: 10),


          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'Flat/Apartment/House No.',
              focusNode: houseFocusNode,
              controller: textControllerFlatNo,
              onTap: _requestFocusHouseNo,
              hintText: 'Enter Address',
              textBgColor: MyColor.appBgColor,
            ),
          ),

          SizedBox(height: 5),


          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'Road/Area/Colony',
              focusNode: roadFocusNode,
              controller: textControllerColony,
              onTap: _requestFocusRoad,
              hintText: 'Enter Address',
              textBgColor: MyColor.appBgColor,
            ),
          ),


          SizedBox(height: 5),


          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[


                Flexible(
                  child:   InputFieldBorder(
                    labelText: 'State',
                    focusNode: stateFocusNode,
                    onTap: _requestFocusState,
                    hintText: 'Enter State',
                    controller: textControllerState,
                    textBgColor: MyColor.appBgColor,
                  ),
                ),
                SizedBox(width: 15),
                Flexible(
                  child: InputFieldBorder(
                    labelText: 'Pincode',
                    focusNode: pinFocusNode,
                    onTap: _requestFocusPin,
                    hintText: 'Enter Pin Code',
                    controller: textControllerPinCode,
                    isNumerickeyboard: true,
                    textBgColor: MyColor.appBgColor,
                  ),
                )


              ],
            ),
          ),



          SizedBox(height: 8),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 80,
                ),
                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: (){
                      //onTap();
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width-60,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color:MyColor.textFiledInActiveColor, width: 1),
                        ),
                        child:Padding(
                          padding: EdgeInsets.only(left: 15,right: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                isExpanded: true,
                                iconEnabledColor: MyColor.themeColorRed,
                                iconDisabledColor: MyColor.defaultTextColor,
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 35,
                                items: listItems.map((String val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: new Text(val,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromRGBO(
                                                53, 52, 89, 0.7))),
                                  );
                                }).toList(),
                                hint: Text(
                                  dropdownSelectedItem,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(53, 52, 89, 0.7)),
                                ),
                                onChanged: (String val) {
                                  dropdownSelectedItem = val;
                                  setState(() {});
                                }),
                          ),
                        )
                    ),
                  ),
                ),
                Positioned(
                    left: 10,
                    bottom: 45,
                    child: Container(color: MyColor.appBgColor, child: Padding(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        child: Text('Select Address type',style:TextStyle(
                            color: Color.fromRGBO(40,43,47,0.8),
                            fontSize: 14,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600

                        ),
                        )),
                    )),


              ],
            ),
          ),



          SizedBox(height: 35),


          InkWell(
            onTap: () {
              //addAddress();
              if(textControllerFlatNo.text=='')
                {
                  Toast.show('House No. cannot be empty !!', context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.black);
                }
              else if(textControllerColony.text=='')
                {
                  Toast.show('Area cannot be empty !!', context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.black);
                }
              else if(textControllerState.text=='')
              {
                Toast.show('State cannot be empty !!', context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.black);
              }
              else if(textControllerPinCode.text.length!=6)
                {
                  Toast.show('Pin code length should be equal to 6  !!', context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.black);
                }
              else if(dropdownSelectedItem=='Address Type')
                {

                  Toast.show('Please Select a Valid address type !!', context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.black);
                }
              else
                addAddress();


            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ButtonWidget('Save'),
            )
          ),



        ],
      ),



    );
  }




  void _requestFocusHouseNo() {
    setState(() {
      FocusScope.of(context).requestFocus(houseFocusNode);
    });
  }



  void _requestFocusRoad() {
    setState(() {
      FocusScope.of(context).requestFocus(roadFocusNode);
    });
  }

  void _requestFocusState() {
    setState(() {
      FocusScope.of(context).requestFocus(stateFocusNode);
    });
  }
  void _requestFocusPin() {
    setState(() {
      FocusScope.of(context).requestFocus(pinFocusNode);
    });
  }
  addAddress() async {
    _fromData["flat_no"]=textControllerFlatNo.text;
    _fromData["pin_code"]=textControllerPinCode.text;
    _fromData["road"]=textControllerColony.text;
    _fromData["state"]=textControllerState.text;
    _fromData["address_type"]=dropdownSelectedItem;
    //_fromData["confirm_password"]=textControllerConfirmPassword.text;
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Adding Address...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPI(
        'add/address',
        _fromData,
        context);
    Navigator.pop(context);
    print(response);
    if(response['success'])

      {
        Toast.show(response['message'], context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
        Navigator.pop(context,'Address Updated');
      }

  }

  setAddress() async {

    textControllerFlatNo.text=AddressModel.flatNo;
    textControllerColony.text=AddressModel.road;
    textControllerState.text=AddressModel.state;
    textControllerPinCode.text=AddressModel.pinCode.toString();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(callbackType=='update')
      {

        setAddress();
        _fromData = {
          'add_id':addId,
          'user_id':UserModel.userId,
          'flat_no':'',
          'address_type':'',
          'pin_code': '',
          'road':'',
          'state':'',
        };
      }
    else{
      _fromData = {
        'user_id':UserModel.userId,
        'flat_no':'',
        'address_type':'',
        'pin_code': '',
        'road':'',
        'state':'',
      };
    }

  }




}
