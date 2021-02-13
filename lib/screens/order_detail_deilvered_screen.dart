
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/network/api_dialog.dart';
import 'package:thinkdelievery/network/api_helper.dart';
import 'package:thinkdelievery/network/no_internet_check.dart';
import 'package:toast/toast.dart';
class OrderDetailDelivered extends StatefulWidget
{
  final String title;
  final int id;
  OrderDetailDelivered(this.title,this.id);
  OrderDetailDelState createState()=>OrderDetailDelState(id);
}
class OrderDetailDelState extends State<OrderDetailDelivered>
{
  List<String> tipList=['0','1','2','3','4','5'];
  int selectedTip=0;
  var _fromData;
  final int id;
  OrderDetailDelState(this.id);
  bool driverAssigned=false;
  bool isDriverRated=false;
  int userRating=3;
  var txtControllerComment=new TextEditingController();
  String orderID='',packageType='',packageDesc='',sourceAddress='',destAddress='',date1='',date2='',finalAmount='';
  String driverImage='',driverPhone='',driverName='',driverID='';
  String driverRating='0.0';
  String vImage='',vName='',vType='',vNum='';
  List<dynamic> imageList=[];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColor.appBgColor,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),

          Row(
            children: <Widget>[

              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child:  Padding(
                  padding: EdgeInsets.only(left: 15),
                  child:Image.asset('images/back_black_icon.png',width: 30,height: 17),
                ),
              ),
              SizedBox(width: 15),

              Row(
                children: <Widget>[

                  Text('Order Detail',style: TextStyle(
                    fontSize: 21,
                    fontFamily: 'George',
                    fontWeight: FontWeight.w700,
                  )),

                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child:   Text(widget.title=='Cancelled'?' (Cancelled)':' (Delivered)',style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'OpenSans',
                      color: widget.title=='Cancelled'?Colors.red:Colors.green,
                      fontWeight: FontWeight.w500
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
            //  crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: Text( packageType??'NA',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(138,197,122,1)),
                          ),
                        ),


                        SizedBox(height: 5),

                        Container(
                          width: MediaQuery.of(context).size.width-120,
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



                        SizedBox(height: 15),


                      ],
                    ),
                    Container(
                      width: 70,
                      height: 60,
                      //transform: Matrix4.translationValues(0.0, -31.0, 0.0),
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

                SizedBox(height: 8),
                Divider(
                  color: Color.fromRGBO(221, 221, 221, 1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,top: 10),
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
                          SizedBox(height: 17,)
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
                                  'Ordered:',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: MyColor.defaultTextColor),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  date1,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromRGBO(
                                          48, 107, 178, 1)),
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
                                  'Delivered:',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: MyColor.defaultTextColor),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  date2,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromRGBO(
                                          48, 107, 178, 1)),
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




          widget.title=='Cancelled'?
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
          'Order cancelled by User',
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(40, 43, 47, 0.7)),
        )

        ):

          Container(
            child: Column(
              children: <Widget>[


                Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Row(
                          children: <Widget>[
                            Container(
                                width: 55,
                                height: 55,
                                margin: EdgeInsets.only(right: 15),
                                decoration:  BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:  driverImage==null?AssetImage('images/dum_men.jpg'):NetworkImage(driverImage)
                                    )
                                )
                            ),



                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text(
                                  driverName,
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
                                      color: Color.fromRGBO(177,176,176,1)),
                                ),
                                SizedBox(height: 2),

                                /*    Row(

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
                          ),*/
                                RatingBar.builder(
                                  initialRating: double.parse(driverRating),
                                  minRating: 1,
                                  itemSize: 20,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  // itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: MyColor.themeColorRed,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),



                        Row(
                          children: <Widget>[

                            isDriverRated?
                            InkWell(
                              onTap: (){
                                showRateDriverDialog();
                              },
                              child:   Container(
                                  width: 130,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: MyColor.textFiledActiveColor,width: 1)
                                  ),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Image.asset('images/star_green.png',width: 15,height: 15,),
                                      SizedBox(width: 10),

                                      Text(
                                        'Rate Driver',
                                        style: TextStyle(

                                            fontFamily: 'OoenSans',
                                            fontSize: 15,
                                            color: Color.fromRGBO(138,197,122,1),
                                            fontWeight: FontWeight.w700


                                        ),
                                      )


                                    ],
                                  )



                              ),
                            ):

                            Text(
                              'Driver Rated',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(177,176,176,1)),
                            ),

                            SizedBox(width: 18),





                          ],
                        )

                      ],
                    )
                ),



                SizedBox(height: 14),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
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
                          'Bike',
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(177,176,176,1)),
                        ),


                      ],
                    )
                  ],
                ),

                SizedBox(height: 14),

              ],
            ),
          )




        ],
      ),


    );
  }




  showRateDriverDialog() {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(
          builder: (context,setState)

          {
            return Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                          ),
                          margin: EdgeInsets.zero,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[


                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 22,right: 15),
                                      child: Image.asset('images/cross_rect.png',width: 25,height: 25),
                                    ),
                                  )
                              ),


                              SizedBox(height: 5),

                             Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[

                                 Container(
                                     width: 60,
                                     height: 60,
                                     margin: EdgeInsets.only(right: 15),
                                     decoration:  BoxDecoration(
                                         shape: BoxShape.circle,
                                         image: DecorationImage(
                                             fit: BoxFit.fill,
                                             image:  driverImage!=null?NetworkImage(driverImage):AssetImage('images/dum_men.jpg')
                                         )
                                     )
                                 ),
                                 SizedBox(height: 10),



                                 Text(
                                  driverName,
                                   style: TextStyle(
                                       fontSize: 14,
                                       fontFamily: 'OpenSans',
                                       fontWeight: FontWeight.w700,
                                       color: MyColor.defaultTextColor),
                                 ),

                                 SizedBox(height: 11),
                                 
                                /* Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: <Widget>[
                                     
                                     Image.asset('images/rating_fill.png',width: 17,height: 17),

                                     SizedBox(width: 5),

                                     Image.asset('images/rating_fill.png',width: 17,height: 17),

                                     SizedBox(width: 5),

                                     Image.asset('images/rating_fill.png',width: 17,height: 17),
                                     SizedBox(width: 5),

                                     Image.asset('images/rating_fill.png',width: 17,height: 17),


                                     SizedBox(width: 5),

                                     Image.asset('images/rating_empty.png',width: 17,height: 17)


                                     
                                     
                                   ],
                                 ),*/


                                 Center(
                                   child: RatingBar.builder(
                                     initialRating: 3,
                                     minRating: 1,
                                     direction: Axis.horizontal,
                                     allowHalfRating: false,
                                     itemCount: 5,
                                     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                     itemBuilder: (context, _) => Icon(
                                       Icons.star,
                                       color: MyColor.themeColorRed,
                                     ),
                                     onRatingUpdate: (rating) {

                                       userRating=rating.floor();
                                       print(rating);
                                     },
                                   ),
                                 ),

                                 SizedBox(height: 15),
                                 
                                 


                               ],
                             ),
                              SizedBox(height: 5),
                           Padding(
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child:   Divider(
                               color: Colors.black12.withOpacity(0.2),
                             ),

                           ),

                              SizedBox(height: 17),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child:   Text('Thank you driver with a tip',style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'George',
                                  fontWeight: FontWeight.w700,
                                )),
                              ),



                              SizedBox(height: 20),

                              Container(
                                margin: EdgeInsets.only(left: 18),
                                height: 50,
                                child: ListView.builder(
                                    itemCount: 4,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context,int pos)
                                    {
                                      return  Row(
                                        children: <Widget>[
                                        InkWell(
                                          onTap:(){

                                            setState(() {
                                              selectedTip=pos;
                                            });
                                      },
                                          child:   Container(
                                            width: 70,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: selectedTip==pos?MyColor.textFiledActiveColor:Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(color: MyColor.textFiledActiveColor,width: 1)
                                            ),
                                            child: Center(
                                              child: Text('\$2',style: TextStyle(
                                                fontSize: 17,
                                                color: selectedTip==pos?Colors.white:MyColor.textFiledActiveColor,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.w700,
                                              )),
                                            ),



                                          ),

                                        ),
                                          SizedBox(width: 15)
                                        ],
                                      );

                                    }

                                ),
                              ),
                         /*    Row(
                               children: <Widget>[
*//*

                                 Container(
                                   width: 90,
                                   height: 50,
                                   margin: EdgeInsets.only(left: 20),
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(15),
                                       border: Border.all(color: MyColor.themeColorRed,width: 1.8)
                                   ),
                                   child: Center(
                                     child: Text('No tip',style: TextStyle(
                                       fontSize: 17,
                                       color: MyColor.themeColorRed,
                                       fontFamily: 'OpenSans',
                                       fontWeight: FontWeight.w700,
                                     )),
                                   ),



                                 ),
*//*

                                 Expanded(
                                   child:
                                 )


                               ],
                             ),*/




                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                                child:   Divider(
                                  color: Colors.black12.withOpacity(0.2),
                                ),

                              ),




                              SizedBox(height: 20),



                              Container(
                                height: 58,
                                margin: EdgeInsets.only(left: 20,right: 20),
                                //color: Colors.pink,
                                child: TextFormField(
                                  controller: txtControllerComment,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700),
                                  decoration: new InputDecoration(
                                    labelText: 'Please specify',
                                    labelStyle: TextStyle(
                                      color:Color.fromRGBO(40,43,47,0.25),
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                    //  contentPadding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 20),
                                    //contentPadding: EdgeInsets.all(20),
                                    //fillColor: Colors.green
                                  ),
                                ),
                              ),

                              SizedBox(height: 40),


                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                  giveRating();
                                },
                                child:  Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: Color.fromRGBO(187, 49, 44, 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Review & Pay',
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
                        )


                    ),
                  ],
                )
            );
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

  giveRating() async {
    FocusScope.of(context).unfocus();
    _fromData["driver_id"]=driverID;
    _fromData["user_rating"]=userRating;
    _fromData["user_comment"]=txtControllerComment.text;
    _fromData["tip"]=tipList[selectedTip];

    print(_fromData);
   // APIDialog.showAlertDialog(context, 'Changing password...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPIWithHeader(
        'ratings',
        _fromData,
        context);
    //Navigator.pop(context);
    print(response);
    if(response['status'].toString()=='200')
    {

      Toast.show(response['message'], context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.black);
    }
    else
      {
        Toast.show(response['message'], context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);

      }

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
      if(response['data']['order_rating']==null)
        {
          isDriverRated=true;
        }
      if(response['data']['driver_details']!=null)
      {
        driverAssigned=true;
        driverImage=response['data']['driver_details']['pimage'];
        driverID=response['data']['driver_details']['id'].toString();
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
    _fromData = {
      'order_id':id,
      'driver_id':'',
      'user_rating':3,
      'user_comment':'',
      'tip':'',
    };
    checkInternetAPIcall();

  }


  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getOrderDetail();
    }
  }


}