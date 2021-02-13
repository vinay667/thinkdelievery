import 'package:flutter/material.dart';
import 'package:thinkdelievery/colors/colors.dart';
import 'package:thinkdelievery/screens/chat_screen.dart';
import 'package:thinkdelievery/screens/customer_home2_screens.dart';
import 'package:thinkdelievery/screens/customer_home_screen.dart';
import 'package:thinkdelievery/screens/my_orders_screen.dart';
import 'package:thinkdelievery/screens/notification_screen.dart';
import 'package:thinkdelievery/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    CustomerHomeScreen(),
    MyOrdersScreen(),
    ChatScreen(),
    NotificationScreen(false),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: MyColor.themeColorRed,
          unselectedItemColor: Color.fromRGBO(10, 10, 10, 0.7),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5,top: 6),
                child: ImageIcon(AssetImage("images/home_nav.png")),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5,top: 6),
                child: ImageIcon(AssetImage("images/order_nav.png")),
              ),
              title: Text(
                'Order List',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5,top: 6),
                child: ImageIcon(AssetImage("images/chat_nav.png")),
              ),
              title: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5,top: 6),
                child: ImageIcon(AssetImage("images/not_nav.png")),
              ),
              title: Text(
                'Notification',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),


            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5,top: 6),
                child: ImageIcon(AssetImage("images/set_nav.png")),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
