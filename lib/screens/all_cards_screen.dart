

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:thinkdelievery/widgets/custom_container_widget.dart';
import 'package:thinkdelievery/widgets/input_field_border.dart';
import 'package:toast/toast.dart';

class AllCardsScreen extends StatefulWidget
{
  AllCardsState createState()=>AllCardsState();
}
class AllCardsState extends State<AllCardsScreen>
{
  List<dynamic> cardsList=[];
  FocusNode houseFocusNode = new FocusNode();
  FocusNode roadFocusNode = new FocusNode();
  FocusNode stateFocusNode = new FocusNode();
  FocusNode pinFocusNode = new FocusNode();
  var textControllerCardNo = new TextEditingController();
  var textControllerExpiryDate = new TextEditingController();
  var textControllerCVV = new TextEditingController();
  var textControllerName = new TextEditingController();
  var _fromData;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     floatingActionButton: FloatingActionButton(
       onPressed: () {

         addCardBottomSheet();
       },
       child: Icon(Icons.add,color: Colors.white,size: 40,),
       backgroundColor: MyColor.themeColorRed,
     ),
     backgroundColor: MyColor.appBgColor,
     body: Column(
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
             Text('Saved Card',
                 style: TextStyle(
                   fontSize: 20,
                   fontFamily: 'George',
                   fontWeight: FontWeight.w700,
                 )),
           ],
         ),
         SizedBox(height: 10),

         Expanded(
           child: ListView.builder(
               itemCount: 4,
               itemBuilder: (BuildContext context,int pos)
               {
                 return  Slidable(
                   actionPane: SlidableDrawerActionPane(),
                   actionExtentRatio: 0.25,
                   child: Column(
                     children: <Widget>[
                       Container(
                         margin: EdgeInsets.only(left: 15, right: 15),
                         padding: EdgeInsets.only(bottom: 15),
                         width: double.infinity,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             border: Border.all(
                                 color: Color.fromRGBO(143, 138, 138, 1), width: 1)),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             SizedBox(width: 15),
                             Container(
                               width: 58,
                               height: 58,
                               margin: EdgeInsets.only(top: 15),
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Color.fromRGBO(233,233,233,1),
                               ),
                               child: Padding(
                                 padding: EdgeInsets.all(15),
                                 child: Image.asset('images/visa.png'),

                               ),



                             ),
                             SizedBox(width: 15),
                             Expanded(
                                 child: Container(
                                   //  color: Colors.pink,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       SizedBox(height: 18),
                                       Text('Bank Of America',
                                           style: TextStyle(
                                             fontSize: 16,
                                             fontFamily: 'OpenSans',
                                             color: MyColor.defaultTextColor,
                                             fontWeight: FontWeight.w900,
                                           )),

                                       SizedBox(height: 5),

                                       Text('MasterCard',
                                         style: TextStyle(
                                           fontSize: 13,
                                           height: 1,
                                           fontFamily: 'OpenSans',
                                           color: Color.fromRGBO(40,43,47,0.7),
                                           fontWeight: FontWeight.w600,
                                         ),overflow: TextOverflow.ellipsis,maxLines: 2,),

                                       SizedBox(height: 20),


                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: <Widget>[

                                           Text('****  ****  ****  5678',
                                               style: TextStyle(
                                                 fontSize: 13,
                                                 height: 1,
                                                 fontFamily: 'OpenSans',
                                                 color: Color.fromRGBO(48,107,178,0.7),
                                                 fontWeight: FontWeight.w700,
                                               ),overflow: TextOverflow.ellipsis,maxLines: 2),



                                           Text('12/11',
                                               style: TextStyle(
                                                 fontSize: 13,
                                                 height: 1,
                                                 fontFamily: 'OpenSans',
                                                 color: Color.fromRGBO(40,43,47,0.7),
                                                 fontWeight: FontWeight.w600,
                                               ),overflow: TextOverflow.ellipsis,maxLines: 2),
                                         ],
                                       )




                                     ],
                                   ),
                                 )
                             ),
                             Container(
                               width: 55,
                               height: 45,
                               //transform: Matrix4.translationValues(0.0, -46.0, 0.0),
                               decoration: BoxDecoration(
                                 color: Color.fromRGBO(231,239,254,1),
                                 borderRadius: BorderRadius.only(
                                     topRight: Radius.circular(15),
                                     bottomLeft: Radius.circular(60)),
                               ),
                               child: Container(
                                   margin: EdgeInsets.only(left: 15),
                                   padding: EdgeInsets.all(12),
                                   child: Image.asset('images/edit_ic_blue.png')
                               ),
                             )


                           ],
                         ),
                       ),
                       SizedBox(height: 20,)
                     ],
                   ),
                   secondaryActions: <Widget>[
                     InkWell(
                       onTap:(){
                 },
                       child: Container(
                         width: 55,
                         height: 55,
                         margin: EdgeInsets.only(bottom: 20,right: 20),
                         decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: MyColor.appBgColor,
                             border: Border.all(color: MyColor.themeColorRed,width: 1)
                         ),
                         child: Center(
                           child: Icon(Icons.delete_outline,color: MyColor.themeColorRed,size: 27,),
                         ),
                       ),
                     )
                   ],
                 );
               }

           ),
         )




       ],
     ),
   );


  }





  addCardBottomSheet() {
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
                                  'Add new card',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'George',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(40, 43, 47, 1)),
                                ),
                              ),
                              SizedBox(height: 15),



                              Container(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: CustomContainer(
                                  labelText: 'Card Number',
                                  focusNode: houseFocusNode,
                                  onTap: _requestFocusHouseNo,
                                  hintText: 'Enter card Number',
                                  textBgColor: MyColor.appBgColor,
                                  controller: textControllerCardNo,
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
                                        labelText: 'Expiry Date',
                                        focusNode: stateFocusNode,
                                        onTap: _requestFocusState,
                                        hintText: 'Enter expiry date',
                                        isNumerickeyboard: true,
                                        controller: textControllerExpiryDate,
                                        textBgColor: MyColor.appBgColor,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Flexible(
                                      child: InputFieldBorder(
                                        labelText: 'CVV',
                                        focusNode: pinFocusNode,
                                        onTap: _requestFocusPin,
                                        hintText: 'Enter CVV',
                                        controller: textControllerCVV,
                                        isNumerickeyboard: true,
                                        textBgColor: MyColor.appBgColor,
                                      ),
                                    )


                                  ],
                                ),
                              ),

                              SizedBox(height: 5),


                              Container(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: CustomContainer(
                                  labelText: 'Name on Card',
                                  focusNode: roadFocusNode,
                                  onTap: _requestFocusRoad,
                                  hintText: 'Enter name',
                                  controller: textControllerName,
                                  textBgColor: MyColor.appBgColor,
                                ),
                              ),



                              SizedBox(height: 35),



                              InkWell(
                                onTap: () {

                                 // addCard();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: Color.fromRGBO(187, 49, 44, 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Add New Card',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white),
                                      ),
                                      SizedBox(width: 10),
                                      /* Image.asset(
            'images/arrow_right.png',
            width: 25,
            height: 15,
          )*/
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

  void _requestFocusHouseNo() {
    setState(() {
      FocusScope.of(context).requestFocus(houseFocusNode);
    });
  }

  getPackageTypes() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('cards-detail', context);
    Navigator.pop(context);
    print(response);
    setState(() {
      cardsList=response['data'];
    });
  }

  deleteCard() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('deletecard', context);
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
  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getPackageTypes();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _fromData = {
      'card_id':'',
      'expiry_date':'',
      'cvv':'',
      'name_on_card':'',
      'brand':'MasterCard',
    };
   // checkInternetAPIcall();
  }
  addCard() async {
    _fromData["card_id"]=textControllerCardNo.text;
    _fromData["expiry_date"]=textControllerExpiryDate.text;
    _fromData["cvv"]=textControllerCVV.text;
    _fromData["name_on_card"]=textControllerName.text;
    //_fromData["confirm_password"]=textControllerConfirmPassword.text;
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Adding Card...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPIWithHeader(
        'addcard',
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
      Navigator.pop(context);
    }

  }

}