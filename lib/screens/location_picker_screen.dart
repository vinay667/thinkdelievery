import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thinkdelievery/model/location_model.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/constants.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:thinkdelievery/widgets/btn_widget.dart';

class LocationPickerScreen extends StatefulWidget {
  LocationPickerState createState() => LocationPickerState();
}

class LocationPickerState extends State<LocationPickerScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  String _mapStyle;
  var _fromData;
  String address = '';
  LatLng currentLocation = LatLng(53.4808, 2.2426);
  BitmapDescriptor pinLocationIcon;
  Set<Marker> markers = Set();
  bool CurrentLoc = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(53.4808, 2.2426),
    zoom: 10.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: _onMapCreated,
            markers: markers,
          ),
          Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(187, 49, 44, 1),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(35)),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      SizedBox(height: 60),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset('images/loc_red.png',
                                width: 28, height: 20, color: Colors.white),
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Set pickup location',
                            style: TextStyle(
                                fontSize: 21,
                                fontFamily: 'George',
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 37),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Image.asset('images/green_dot.png',
                              width: 10, height: 10),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(255, 255, 255, 0.9)),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              Expanded(
                child: Container(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  InkWell(
                    onTap: () {
                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(currentLocation.latitude,
                                  currentLocation.longitude),
                              zoom: 10.4746),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15, bottom: 25),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color.fromRGBO(48, 107, 178, 1),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(13),
                          child: Image.asset('images/loc_white.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (address != '') {
                    Navigator.pop(context, 'Address Selected');
                  }
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
                  child: ButtonWidget('Next'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);

    setState(() {
      _controller.complete(controller);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    getCurrentLocation();
    _fromData = {
      'user_id': UserModel.userId,
      'address': '',
      'latitude': '',
      'longitude': '',
    };
    setCustomMapPin();
    /* BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/pin_map.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });*/
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.2), 'images/pin_map.png');
  }

  fetchLocationName(double latt, double long) async {
    print('API called Location Fetch');
    const _host = 'https://maps.google.com/maps/api/geocode/json';
    String apiKey = AppConstant.googleAPIKey;
    var latitude = latt;
    var longitude = long;

    final uri = Uri.parse('$_host?key=$apiKey&latlng=$latitude,$longitude');
    print(uri);

    try {
      http.Response response = await http.get(uri);
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          address = responseJson['results'][0]['formatted_address'];
        });
        LocationModel.setLattitude(latt);
        LocationModel.setLongitude(long);
        LocationModel.setAddress(address);
        //  addToRecentSearch(latt, long, address);
        print(address);
      }
    } catch (exception) {
      print(exception.toString());
    }
  }

  addToRecentSearch(double latt, double longg, String address) async {
    _fromData["address"] = address;
    _fromData["latitude"] = latt.toString();
    _fromData["longitude"] = longg.toString();
    ApiBaseHelper helper = new ApiBaseHelper();
    var response =
        await helper.postAPIWithHeader('recent/add', _fromData, context);
    print(response);
  }

  Future<void> requestPermission() async {
    final status = await Permission.location.request();
    if (status.toString() == 'PermissionStatus.denied') {
    } else {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    if (await Permission.location.isGranted) {

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 10.4746),
        ),
      );

      setState(() {
        address = 'Fetching Location...';
        currentLocation = LatLng(position.latitude, position.longitude);
        markers.addAll([
          Marker(
              markerId: MarkerId('value'),
              draggable: true,
              position: currentLocation,
              onDragEnd: ((newPosition) {
                print(newPosition.latitude);
                print(newPosition.longitude);
                setState(() {
                  address = 'Fetching Location...';
                });

                fetchLocationName(
                    newPosition.latitude, newPosition.longitude);
              })),
        ]);
      });
      fetchLocationName(position.latitude, position.longitude);



    } else {
      requestPermission();
    }
  }
}
