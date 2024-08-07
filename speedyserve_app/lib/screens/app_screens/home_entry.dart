import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:SpeedyServe/screens/app_screens/cart_screen.dart';
import 'package:SpeedyServe/screens/app_screens/home_screen.dart';
import 'package:SpeedyServe/screens/app_screens/profile_screen.dart';

class HomeEntry extends StatefulWidget {
  const HomeEntry({super.key});

  @override
  State<HomeEntry> createState() => _HomeEntryState();
}

class _HomeEntryState extends State<HomeEntry> {
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  // starting point of our navbar

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.grey.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12, vertical: 8),
            child: GNav(
              // rippleColor: Colors.grey[300]!,
              // hoverColor: Colors.grey[100]!,
              gap: 0,
              activeColor: Colors.red.shade500,
              iconSize: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.transparent,
              color: Colors.grey[400]!,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: '',
                ),
                GButton(
                  icon: Icons.search,
                  text: '',
                ),
                GButton(
                  icon: Icons.shopping_cart_checkout_outlined,
                  text: '',
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  text: '',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}