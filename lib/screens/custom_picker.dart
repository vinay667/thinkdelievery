import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/location_model.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/constants.dart';
class CustomPicker extends StatefulWidget {
  CustomPickerState createState() => CustomPickerState();
}
class CustomPickerState extends State<CustomPicker> {
  bool isLoading = false;
  String selectedPlaceID = '';
  List<dynamic> placesList = [];
  var _fromData;
  var locationController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 55),
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
          SizedBox(height: 20),
          Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 11),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        /* boxShadow: [
                         new BoxShadow(
                           color: Colors.lightBlueAccent.withOpacity(0.2),
                           blurRadius: 7.0,
                         ),
                       ],*/
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: TextField(
                      onChanged: (query) {
                        if (query.length > 1) {
                          fetchGooglePlaces(query);
                          //api call
                        } else {
                          if (placesList.length != 0) {
                            setState(() {
                              placesList.clear();
                            });
                          }
                        }
                      },
                      controller: locationController,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          fontFamily: 'GilroySemibold'),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 10.0,),
                        border: InputBorder.none,
                        hintText: 'Search Location',
                        hintStyle: TextStyle(
                            color: Colors.black12,
                            decoration: TextDecoration.none,
                            fontFamily: 'GilroySemibold'),
                      ),
                    ),
                    height: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 45, top: 28),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: isLoading == true
                          ? Container(
                              height: 12,
                              width: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  locationController.text == '';
                                  placesList.clear();
                                });
                              },
                              child: Image.asset('images/cross_white.png',
                                  color: MyColor.themeColorRed,
                                  height: 12,
                                  width: 12),
                            )),
                )
              ],
            ),
          ),
          Expanded(
            // fetchlatLong(placesList[position]['place_id']);
            child: ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: placesList.length,
                itemBuilder: (BuildContext context, int position) {
                  return Container(
                      child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Image.asset(
                              'images/loc_trip.png',
                              width: 20,
                              height: 20,
                              color: MyColor.themeColorRed,
                            ),
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              fetchlatLong(placesList[position]['place_id']);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 4, right: 10),
                                  child: Text(
                                    placesList[position]['description'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 5, right: 10),
                                  child: Text(
                                    placesList[position]
                                                    ['structured_formatting']
                                                ['secondary_text'] !=
                                            null
                                        ? placesList[position]
                                                ['structured_formatting']
                                            ['secondary_text']
                                        : '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black.withOpacity(0.4),
                                        decoration: TextDecoration.none,
                                        fontFamily: 'GilroySemibold'),
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        color: MyColor.greyDivider,
                      )
                    ],
                  ));
                }),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Powered by Google',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(30, 30, 30, 0.89)),
                  ),
                  SizedBox(width: 6),
                  Image.asset(
                    'images/google_icon.png',
                    width: 20,
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  fetchGooglePlaces(String loc) async {
    String message = '';
    try {
      setState(() {
        isLoading = true;
      });
      http.Response response;
      response = await http.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?sensor=false&key=' +
              AppConstant.googleAPIKey +
              '&input=' +
              loc,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
          });
      Map<String, dynamic> fetchTokenResponse = json.decode(response.body);
      print(fetchTokenResponse);
      setState(() {
        isLoading = false;
        placesList = fetchTokenResponse['predictions'];
      });
    } catch (errorMessage) {
      message = errorMessage.toString();
    }
  }

  fetchlatLong(String placeID) async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Getting location...');
    try {
      http.Response response;
      response = await http.post(
          'https://maps.googleapis.com/maps/api/place/details/json?placeid=' +
              placeID +
              '&key=' +
              AppConstant.googleAPIKey,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
          });
      Map<String, dynamic> fetchAPIResponse = json.decode(response.body);
      Navigator.pop(context);
      print(fetchAPIResponse.toString());
      double latt = fetchAPIResponse['result']['geometry']['location']['lat'];
      double long = fetchAPIResponse['result']['geometry']['location']['lng'];
      String locationName = fetchAPIResponse['result']['formatted_address'];
      LocationModel.setLattitude(latt);
      LocationModel.setLongitude(long);
      LocationModel.setAddress(locationName);
      addToRecentSearch(latt, long, locationName);
      Navigator.pop(context,'Address Selected');

    } catch (errorMessage) {
      Navigator.pop(context);
      message = errorMessage.toString();
      print(message);
    }
  }

  showAlertDialog(BuildContext context, String dialogText) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            backgroundColor: MyColor.themeColor,
          ),
          Container(margin: EdgeInsets.only(left: 15), child: Text(dialogText)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  addToRecentSearch(double latt,double longg,String address) async {
    _fromData["address"]=address;
    _fromData["latitude"]=latt.toString();
    _fromData["longitude"]=longg.toString();
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPIWithHeader(
        'recent/add',
        _fromData,
        context);
    print(response);


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fromData = {
      'user_id':UserModel.userId,
      'address':'',
      'latitude': '',
      'longitude': '',
    };
    locationController.text = '';
  }
}
