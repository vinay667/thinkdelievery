import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/model/coupon_model.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:toast/toast.dart';

class CouponScreen extends StatefulWidget {
  CouponScreenState createState() => CouponScreenState();
}

class CouponScreenState extends State<CouponScreen> {
  List<dynamic> couponList = [];
  var txtEditControllerCoupon = new TextEditingController();
  List<String> couponNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Image.asset('images/loc_red.png', width: 30, height: 20),
            ),
          ),
          SizedBox(height: 13),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Coupon Codes',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'George',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(40, 43, 47, 1)),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Stack(
              children: <Widget>[
                Container(
                  // height: 53,
                  child: TextFormField(
                    //controller: textControllerSearch,
                    maxLines: 1,
                    controller: txtEditControllerCoupon,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        color: Color.fromRGBO(40, 43, 47, 1),
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans'),
                    decoration: InputDecoration(
                      hintText: 'Enter Coupon',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, right: 50),
                      hintStyle: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(40, 43, 47, 0.2),
                          fontSize: 17),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                          color: Color.fromRGBO(130, 131, 130, 1), width: 1.5)),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          if (couponNames
                              .contains(txtEditControllerCoupon.text)) {
                            print('This is a valid Coupon Code');
                            int selectedIndex = 0;
                            for (int i = 0; i < couponList.length; i++) {
                              if (txtEditControllerCoupon.text ==
                                  couponList[i]['promo_code']) {
                                selectedIndex = i;
                                break;
                              }
                            }

                            CouponModel.setCouponID(
                                couponList[selectedIndex]['id']);
                            CouponModel.setAmount(couponList[selectedIndex]
                                    ['discount']
                                .toString());
                            CouponModel.setCouponName(
                                couponList[selectedIndex]['promo_code']);
                            CouponModel.setDiscountType(
                                couponList[selectedIndex]['discount_type']);
                            Toast.show(
                                'Coupon Applied Successfully !!', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM,
                                backgroundColor: Colors.black);

                            // CouponModel.setCouponID(couponList[pos])

                            print(CouponModel.couponName);
                            print(CouponModel.amount);
                            print(CouponModel.couponId.toString());
                            print(CouponModel.type);

                            Navigator.pop(context, 'Coupon Applied');
                          } else {
                            Toast.show('Invalid Coupon Code !!', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM,
                                backgroundColor: Colors.black);
                            print('Not a valid coupon');
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, top: 15),
                          child: Text(
                            'Apply',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(187, 49, 44, 1)),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'Or',
              style: TextStyle(
                  color: Color.fromRGBO(40, 43, 47, 0.3),
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans'),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(left: 15, right: 15),
                itemCount: couponList.length,
                itemBuilder: (BuildContext context, int position) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          txtEditControllerCoupon.text =
                              couponList[position]['promo_code'];
                        },
                        child: Container(
                          height: 120,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  width: 0.7)),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: couponList[position]['image'] == null
                                      ? Image.asset(
                                          'images/g1.jpg',
                                          width: 90,
                                          height: 90,
                                        )
                                      : Image.network(
                                          couponList[position]['image'],
                                          width: 90,
                                          height: 90,
                                        )),
                              SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 13),
                                    Text(
                                      couponList[position]['title'] != null
                                          ? couponList[position]['title']
                                          : 'NA',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w800,
                                          color: Color.fromRGBO(40, 43, 47, 1),
                                          fontSize: 15),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      couponList[position]['description'] !=
                                              null
                                          ? couponList[position]['description']
                                          : 'NA',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(40, 43, 47, 1),
                                          fontSize: 10),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                        'Valid until: ' +
                                            _showDateInFormat(
                                                couponList[position]
                                                        ['expiration']
                                                    .toString()),
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic,
                                            color: Color.fromRGBO(
                                                114, 177, 218, 1),
                                            fontSize: 10),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(height: 5),
                                    Text(
                                      couponList[position]['promo_code']
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w900,
                                          color: Colors.cyan,
                                          fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                height: 120,
                                color: Color.fromRGBO(221, 221, 221, 1),
                                width: 1,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      couponList[position]['discount_type'] ==
                                              'percent'
                                          ? couponList[position]['discount']
                                                  .toString() +
                                              '%'
                                          : '\$' +
                                              couponList[position]['discount']
                                                  .toString(),
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: 'George',
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromRGBO(138, 197, 122, 1)),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Discount',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'George',
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(40, 43, 47, 1)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
                color: MyColor.themeColorRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 25, top: 20),
                      child: Text(
                        'Maximum Savings:',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(250, 250, 255, 0.9)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, top: 5),
                      child: Text(
                        '\$250',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'George',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (couponNames.contains(txtEditControllerCoupon.text)) {
                      print('This is a valid Coupon Code');
                      int selectedIndex = 0;
                      for (int i = 0; i < couponList.length; i++) {
                        if (txtEditControllerCoupon.text ==
                            couponList[i]['promo_code']) {
                          selectedIndex = i;
                          break;
                        }
                      }

                      CouponModel.setCouponID(couponList[selectedIndex]['id']);
                      CouponModel.setAmount(
                          couponList[selectedIndex]['discount'].toString());
                      CouponModel.setCouponName(
                          couponList[selectedIndex]['promo_code']);
                      CouponModel.setDiscountType(
                          couponList[selectedIndex]['discount_type']);
                      Toast.show('Coupon Applied Successfully !!', context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.black);

                      // CouponModel.setCouponID(couponList[pos])

                      print(CouponModel.couponName);
                      print(CouponModel.amount);
                      print(CouponModel.couponId.toString());
                      print(CouponModel.type);

                      Navigator.pop(context, 'Coupon Applied');
                    } else {
                      Toast.show('Invalid Coupon Code !!', context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.black);
                      print('Not a valid coupon');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 30),
                    width: 120,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: GestureDetector(
                      child: Text(
                        'Apply',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(187, 49, 44, 1)),
                      ),
                    )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  getAllCoupons() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('coupons', context);
    Navigator.pop(context);
    print(response);
    setState(() {
      couponList = response['data'];
    });

    if (couponNames.length != 0) {
      couponNames.clear();
    }
    for (int i = 0; i < couponList.length; i++) {
      couponNames.add(couponList[i]['promo_code']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getAllCoupons();
    }
  }

  String _showDateInFormat(String date) {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat timeFormatter = DateFormat.yMMMM();
    String timeAsString = timeFormatter.format(dateTime);
    print(timeAsString);
    return timeAsString;
  }
}
