import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/address_model.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:thinkdelievery/screens/add_address_screen.dart';
import 'package:toast/toast.dart';

class AddressScreen extends StatefulWidget {
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {
  List<dynamic> addressList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
           final result=await Navigator.push(context,
               MaterialPageRoute(builder: (context) => AddAddressScreen('add',null)));

           if(result!=null)
             {
               checkInternetAPIcall();
             }
          // Add your onPressed code here!
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
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
              Text('Saved Addresses',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'George',
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                itemCount: addressList.length,
                itemBuilder: (BuildContext context, int pos) {
                  return Slidable(
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
                                  color: Color.fromRGBO(143, 138, 138, 1),
                                  width: 1)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 15),
                              Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MyColor.textFiledActiveColor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Image.asset(addressList[pos]['address_type']=='WORK'?'images/office_address.png':'images/home_ict.png'),
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
                                        Text(toBeginningOfSentenceCase(addressList[pos]['address_type']),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'OpenSans',
                                              color: MyColor.defaultTextColor,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Image.asset('images/locv_red.png',
                                                width: 15, height: 15),
                                            SizedBox(width: 7),
                                            Flexible(
                                              // /padding: EdgeInsets.only(bottom: 4),
                                              child: Text(
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
                                                  fontSize: 13,
                                                  height: 1,
                                                  fontFamily: 'OpenSans',
                                                  color:
                                                  Color.fromRGBO(40, 43, 47, 0.7),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                              InkWell(
                                onTap: () async {

                                  AddressModel.setAddressType(addressList[pos]['address_type']);
                                  AddressModel.setFlatNo(addressList[pos]['flat_no']);
                                  AddressModel.setPinCode(addressList[pos]['pin_code']);
                                  AddressModel.setStateName(addressList[pos]['state']);
                                  AddressModel.setRoad(addressList[pos]['road']);

                                  final result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddressScreen('update',addressList[pos]['id'].toString())));

                                  if(result!=null)
                                  {
                                    checkInternetAPIcall();
                                  }
                                },
                                child: Container(
                                  width: 55,
                                  height: 45,
                                  //transform: Matrix4.translationValues(0.0, -46.0, 0.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(231, 239, 254, 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(60)),
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.only(left: 15),
                                      padding: EdgeInsets.all(12),
                                      child:
                                      Image.asset('images/edit_ic_blue.png')),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                    secondaryActions: <Widget>[
                      InkWell(
                        onTap:(){
                          showAddressDeleteDialog(context,addressList[pos]['id']);

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
                }),
          )
        ],
      ),
    );
  }

  getAllAddress() async {
    String userId=UserModel.userId;
    print(userId);
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('getaddress/$userId', context);
    Navigator.pop(context);
    print(response);
    if(response['success'].toString()=='true')
      {
        setState(() {
          addressList = response['data'];
        });
      }
    else if(response['message']=='Invalid Id')
    {
      Toast.show('No Addresses found !!', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.black);

    }
  }
  deleteAddress(int addressID) async {
    String userId=UserModel.userId;
    FocusScope.of(context).unfocus();
    String baseEnd='delete/address/'+userId+'/'+addressID.toString();
    ApiBaseHelper helper = new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Removing..');
    var response = await helper.get(baseEnd, context);
    Navigator.pop(context);
     if(response['success'])
       {
         Toast.show(response['message'], context,
             duration: Toast.LENGTH_LONG,
             gravity: Toast.BOTTOM,
             backgroundColor: Colors.black);
         Navigator.pop(context);
       }


    print(response);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
  }
  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getAllAddress();
    }
  }

  showAddressDeleteDialog(BuildContext context,int addressID) {
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        Navigator.pop(context);
        deleteAddress(addressID);

      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Remove Address"),
      content: Text("Are you sure you want to remove this address ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
