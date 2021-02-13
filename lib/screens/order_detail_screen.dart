import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';

class OrderDetailScreen extends StatefulWidget {
  final int id;
  OrderDetailScreen(this.id);
  OrderDetailState createState() => OrderDetailState(id);
}

class OrderDetailState extends State<OrderDetailScreen> {
  final int id;
  OrderDetailState(this.id);
  bool driverAssigned=false;
  String orderID='',packageType='',packageDesc='',sourceAddress='',destAddress='',date1='',date2='',finalAmount='';
  String driverImage='',driverRating='',driverPhone='',driverName='';
  String vImage='',vName='',vType='',vNum='';
  List<dynamic> imageList=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Image.asset('images/back_black_icon.png',
                      width: 30, height: 17),
                ),
              ),
              SizedBox(width: 15),
              Row(
                children: <Widget>[
                  Text('Order Detail',
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'George',
                        fontWeight: FontWeight.w700,
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(' (In Transit)',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                        )),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 12),
            //height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Color.fromRGBO(143, 138, 138, 1), width: 2)),
            child: Column(

              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 18),
                          child: Text(
                            orderID,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w900,
                                color: MyColor.defaultTextColor),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            packageType??'NA',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(138, 197, 122, 1)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width - 120,
                          padding: EdgeInsets.only(left: 10, top: 3),
                          child: Text(
                            packageDesc??'Description Not available',
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                color: MyColor.defaultTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(height: 17),
                      ],
                    ),
                    Container(
                      width: 70,
                      height: 60,
                    //  transform: Matrix4.translationValues(0.0, -46.0, 0.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 239, 239, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(60)),
                      ),
                      child: Center(
                        child: Text(
                          '\$'+finalAmount,
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

              imageList.length!=0?
              Container(
                height: 70,
                child:   ListView.builder(
                    padding: EdgeInsets.only(left: 10),
                    itemCount: imageList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(BuildContext context,int pos)
                    {
                      return Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 67,
                          height: 67,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromRGBO(143, 138, 138, 1))),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.network(imageList[pos]['image']),
                          ));
                    }

                ),
              ):Container(),

             /*   Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 15, left: 10),
                        width: 67,
                        height: 67,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(143, 138, 138, 1))),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset('images/box_dumm.jpg'),
                        )),
                    Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 67,
                        height: 67,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(143, 138, 138, 1))),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset('images/box_dumm.jpg'),
                        )),
                    Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 67,
                        height: 67,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(143, 138, 138, 1))),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset('images/box_dumm.jpg'),
                        )),
                 *//*   Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'View More',
                        style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w700,
                            color: MyColor.themeColorRed),
                      ),
                    ),*//*
                  ],
                ),*/

                Divider(
                  color: Color.fromRGBO(221, 221, 221, 1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Row(
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
                          Dash(
                              direction: Axis.vertical,
                              length: 40,
                              dashLength: 4,
                              dashColor: MyColor.themeColorRed),
                          Image.asset('images/locv_red.png',
                              width: 15, height: 15),
                          SizedBox(
                            height: 17,
                          )
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
                                  date1,
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
                              width: MediaQuery.of(context).size.width * 0.70,
                              child:   Text(
                                sourceAddress,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(40, 43, 47, 0.7),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 20),
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
                                  date2,
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
                              width: MediaQuery.of(context).size.width * 0.70,
                              child:
                              Text(
                                destAddress,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(40, 43, 47, 0.7)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),


                            SizedBox(height: 20),
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
                                  date2,
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
                              width: MediaQuery.of(context).size.width * 0.70,
                              child:
                              Text(
                                destAddress,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(40, 43, 47, 0.7)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: Color.fromRGBO(143, 138, 138, 0.16), width: 1)),
            margin: EdgeInsets.only(left: 10, right: 10),
            height: 180,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('images/map_dum.jpg',
                      width: MediaQuery.of(context).size.width - 20,
                      fit: BoxFit.fitWidth),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(114, 177, 218, 1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Color.fromRGBO(143, 138, 138, 0.16),
                                  width: 1)),
                          width: 30,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: Image.asset('images/full_ic.png'),
                          )),
                    ))
              ],
            ),
          ),
          SizedBox(height: 20),

   driverAssigned?
         Container(
           child: Column(
             children: <Widget>[
               Padding(
                   padding: EdgeInsets.only(left: 10, right: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Row(
                         children: <Widget>[
                           Container(
                               width: 55,
                               height: 55,
                               margin: EdgeInsets.only(right: 15),
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   image: DecorationImage(
                                       fit: BoxFit.fill,
                                       image:
                                       AssetImage('images/dum_men.jpg')))),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Text(
                                 driverName??'NA',
                                 style: TextStyle(
                                     fontSize: 14,
                                     fontFamily: 'OpenSans',
                                     fontWeight: FontWeight.w700,
                                     color: MyColor.defaultTextColor),
                               ),
                               SizedBox(height: 1),
                               Text(
                                 'Driver',
                                 style: TextStyle(
                                     fontSize: 11,
                                     fontFamily: 'OpenSans',
                                     fontWeight: FontWeight.w600,
                                     color: Color.fromRGBO(177, 176, 176, 1)),
                               ),
                               SizedBox(height: 2),

                               Row(

                                 children: <Widget>[

                                   Image.asset('images/rating_fill.png',width: 12,height: 12),

                                   SizedBox(width: 1),

                                   Image.asset('images/rating_fill.png',width: 12,height: 12),

                                   SizedBox(width: 1),

                                   Image.asset('images/rating_fill.png',width: 12,height: 12),
                                   SizedBox(width: 1),

                                   Image.asset('images/rating_fill.png',width: 12,height: 12),


                                   SizedBox(width: 1),

                                   Image.asset('images/rating_fill.png',width: 12,height: 12),




                                 ],
                               ),
                             ],
                           )
                         ],
                       ),
                       Row(
                         children: <Widget>[
                           Container(
                             width: 50,
                             height: 50,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 border: Border.all(
                                     color: MyColor.textFiledActiveColor, width: 1)),
                             child: Center(
                               child: Padding(
                                 padding: EdgeInsets.all(10),
                                 child: Image.asset('images/call_ic.png'),
                               ),
                             ),
                           ),
                           SizedBox(width: 18),
                           Container(
                             width: 50,
                             height: 50,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 border: Border.all(
                                     color: MyColor.themeColorRed, width: 1)),
                             child: Center(
                               child: Padding(
                                 padding: EdgeInsets.all(10),
                                 child: Image.asset('images/mes_ic.png'),
                               ),
                             ),
                           )
                         ],
                       )
                     ],
                   )),
               SizedBox(height: 14),
               Container(
                 margin: EdgeInsets.only(left: 10, right: 10),
                 height: 1,
                 width: double.infinity,
                 color: Colors.grey.withOpacity(0.2),
               ),
               Row(
                 children: <Widget>[
                   Container(
                     width: 55,
                     height: 55,
                     margin: EdgeInsets.only(right: 15),
                     child: Center(
                       child: Padding(
                         padding: EdgeInsets.all(12),
                         child: Image.asset('images/del_right.png'),
                       ),
                     ),
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text(
                         'Kawasaki Ninja',
                         style: TextStyle(
                             fontSize: 14,
                             fontFamily: 'OpenSans',
                             fontWeight: FontWeight.w700,
                             color: MyColor.defaultTextColor),
                       ),
                       SizedBox(height: 1),
                       Text(
                         vType==null || vType==''?'Bike':vType,
                         style: TextStyle(
                             fontSize: 11,
                             fontFamily: 'OpenSans',
                             fontWeight: FontWeight.w600,
                             color: Color.fromRGBO(177, 176, 176, 1)),
                       ),
                     ],
                   )
                 ],
               ),



             ],
           ),

         ):


           Padding(
             padding: EdgeInsets.only(left: 10),
             child:   Text(
               'Searching for driver...',
               style: TextStyle(
                   fontSize: 17,
                   fontFamily: 'OpenSans',
                   fontWeight: FontWeight.w600,
                   color: Color.fromRGBO(40, 43, 47, 0.7)),
               maxLines: 1,
               overflow: TextOverflow.ellipsis,
             ),


           ),
          SizedBox(height: 14),
        ],
      ),
    );
  }


  getOrderDetail() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.get('ordersdetail/$id', context);
    Navigator.pop(context);
    print(response);
    setState(() {
    orderID=response['data']['booking_id'];
    packageType=response['data']['package_type'];
    packageDesc=response['data']['package_description'];
    sourceAddress=response['data']['s_address'];
    destAddress=response['data']['d_address'];
    date1=getFormatDate(response['data']['pickup_date_time'].toString());
    if(response['data']['estimated_del_date']!=null)
      {
        date2=getFormatDate(response['data']['estimated_del_date']);
      }
    else{
      date2='NA';
    }
    finalAmount=response['data']['final_amount'].toString();
    imageList=response['data']['order_images'];
    if(response['data']['driver_details']!=null)
      {
        driverAssigned=true;
        driverImage=response['data']['driver_details']['pimage'];
        driverPhone=response['data']['driver_details']['mobile'].toString();
        driverName=response['data']['driver_details']['name'];
        driverRating=response['data']['driver_details']['average_rating'];
        vType=response['data']['driver_details']['type_of_vehicle'];
        vNum=response['data']['driver_details']['vehicle_number'];
      }





    });
  }
  String getFormatDate(String date)
  {
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
    checkInternetAPIcall();

  }


  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getOrderDetail();
    }
  }


}
