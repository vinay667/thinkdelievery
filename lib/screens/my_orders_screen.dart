import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/screens/orderTab1.dart';
import 'orderTab2.dart';
import 'orderTab3.dart';

class MyOrdersScreen extends StatefulWidget {
  MyOrdersScreenState createState() => MyOrdersScreenState();
}

class MyOrdersScreenState extends State<MyOrdersScreen> {
  final textControllerEmail = new TextEditingController();
  final textControllerPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: MyColor.appBgColor,
        body: Column(

          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(187, 49, 44, 1),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60),
                  Text(
                    'Orders',
                    style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'George',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(height: 25),
                  Stack(
                    children: <Widget>[
                      Container(
                        // height: 53,
                        child: TextFormField(
                          //controller: textControllerSearch,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Color.fromRGBO(40, 40, 40, 1),
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontFamily: 'OpenSans'),
                          decoration: InputDecoration(
                            hintText: 'Search for orders',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15, right: 50),
                            hintStyle: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(250, 250, 255, 0.2),
                                fontSize: 17),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                                color: Color.fromRGBO(250, 250, 255, 0.88),
                                width: 1.5)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(right: 20, top: 15),
                                child: Image.asset('images/search_ic.png',
                                    width: 20, height: 20),
                              ),
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    child: TabBar(
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 3.0, color: Colors.white),
                        insets: EdgeInsets.symmetric(horizontal: 38.0),
                      ),
                      tabs: [
                        Tab(
                          text: 'In Transit',

                          //icon: Icon(Icons.directions_bike),
                        ),
                        Tab(
                          text: 'Completed',
                          /*icon: Icon(
                              Icons.directions_car,
                            )*/
                        ),
                        Tab(
                          text: 'Cancelled',

                          //icon: Icon(Icons.directions_bike),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
            //  height: 600,
              child: TabBarView(
                children: [
                  OrderTab1(),
                  OrderTab2(),
                  OrderTab3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
