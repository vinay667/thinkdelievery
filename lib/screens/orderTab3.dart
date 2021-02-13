import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:intl/intl.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/user_model.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/constants.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:http/http.dart' as http;
import 'package:thinkdelievery/screens/order_detail_deilvered_screen.dart';
import 'package:thinkdelievery/screens/order_detail_screen.dart';
import 'package:thinkdelievery/screens/pagination_demo.dart';

class OrderTab3 extends StatefulWidget {
  OrderTab3State createState() => OrderTab3State();
}

class OrderTab3State extends State<OrderTab3> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  bool isLoading = true;
  List<dynamic> ordersList = [];
  var formdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: Paginator.listView(
        padding: EdgeInsets.zero,
        key: paginatorGlobalKey,
        pageLoadFuture: sendOrdersDataRequest,
        pageItemsGetter: listItemsGetter,
        listItemBuilder: listItemBuilder,
        loadingWidgetBuilder: loadingWidgetMaker,
        errorWidgetBuilder: errorWidgetMaker,
        emptyListWidgetBuilder: emptyListWidgetMaker,
        totalItemsGetter: totalPagesGetter,
        pageErrorChecker: pageErrorChecker,
        scrollPhysics: BouncingScrollPhysics(),
      ),
    );
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
  }

  Future<OrdersData> sendOrdersDataRequest(int page) async {
    try {
      String url =
          Uri.encodeFull(AppConstant.appBaseURL + 'orderslist?page=$page');
      print(url);
      http.Response response =
          await http.post(url, body: jsonEncode(formdata), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + UserModel.accessToken,
        /* 'Accept':'application/json',
        'X-Requested-With':'XMLHttpRequest'*/
      });
      return OrdersData.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return OrdersData.withError('Please check your internet connection.');
      } else {
        print(e.toString());
        return OrdersData.withError('Something went wrong.');
      }
    }
  }

  List<dynamic> listItemsGetter(OrdersData countriesData) {
    List<dynamic> list = [];
    countriesData.orderList.forEach((value) {
      list.add(value);
    });
    return list;
  }

  Widget listItemBuilder(value, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailDelivered('Cancelled',1)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: Color.fromRGBO(143, 138, 138, 1), width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Image.asset(
                      'images/message_ic.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 18),
                          child: Text(
                            value['booking_id'],
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w900,
                                color: MyColor.defaultTextColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 3),
                          child: Text(
                            value['package_description'] ?? '',
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                color: MyColor.defaultTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 60,
                    transform: Matrix4.translationValues(0.0, -8, 0.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 239, 239, 1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(18),
                          bottomLeft: Radius.circular(60)),
                    ),
                    child: Center(
                      child: Text(
                        '\$' + value['final_amount'].toString(),
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'George',
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(187, 49, 44, 1)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Color.fromRGBO(221, 221, 221, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset('images/locv_red.png',
                              width: 15, height: 15),
                          Dash(
                              direction: Axis.vertical,
                              length: 40,
                              dashLength: 4,
                              dashColor: MyColor.themeColorRed),
                          Image.asset('images/locv_red.png',
                              width: 15, height: 15),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'From:',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromRGBO(206, 206, 206, 1)),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  getFormatDate(value['pickup_date_time']),
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromRGBO(48, 107, 178, 1)),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: Text(
                                value['s_address'] != null
                                    ? value['s_address']
                                    : 'NA',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(40, 43, 47, 0.7)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: <Widget>[
                                Text(
                                  'To:',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromRGBO(206, 206, 206, 1)),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  value['estimated_del_date'] != null
                                      ? getFormatDate(
                                          value['estimated_del_date'])
                                      : 'NA',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromRGBO(48, 107, 178, 1)),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.50,
                              //color: Colors.pink,
                              child: Text(
                                value['d_address'] ?? '',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(40, 43, 47, 0.7)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.only(top: 30, right: 5),
                    child: Column(
                      children: <Widget>[

                        Image.asset('images/del_bike.png',
                            width: 34, height: 30),





                        Text(
                          value['driver_details']==null?
                          'Not Assigned':value['driver_details']['name'],
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              color: MyColor.defaultTextColor),
                        ),
                        Text(
                          'Driver',
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(206, 206, 206, 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget loadingWidgetMaker() {
    return Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(MyColor.themeColorRed),
          ),
        ));
  }

  Widget errorWidgetMaker(OrdersData ordersData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(ordersData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text('Retry'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(OrdersData countriesData) {
    return Center(
      child: Text(
        'No Orders yet !!',
        style: TextStyle(
            color: Color.fromRGBO(40, 40, 40, 1),
            fontSize: 15,
            decoration: TextDecoration.none,
            fontFamily: 'OpenSans'),
      ),
    );
  }

  int totalPagesGetter(OrdersData countriesData) {
    return countriesData.total;
  }

  bool pageErrorChecker(OrdersData countriesData) {
    return countriesData.statusCode != 200;
  }

  String getFormatDate(String date) {
    DateTime dateTime = DateTime.parse(date.toString());
    final DateFormat timeFormatter = DateFormat.yMMMEd();
    String timeAsString = timeFormatter.format(dateTime);
    print(timeAsString);
    return timeAsString;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formdata = {
      'status': 'CANCELLED',
    };
    // checkInternetAPIcall();
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      //fetchUserOrders();
    }
  }
}

class OrdersData {
  List<dynamic> orderList;
  int statusCode;
  String errorMessage;
  int total;
  int nItems;

  OrdersData.fromResponse(http.Response response) {
    this.statusCode = response.statusCode;
    print(statusCode);
    // List jsonData = json.decode(response.body);

    var responseJson = jsonDecode(response.body.toString());
    print(responseJson);
    orderList = responseJson['data']['data'];
    total = responseJson['data']['total'];
    nItems = orderList.length;
  }

  OrdersData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}
