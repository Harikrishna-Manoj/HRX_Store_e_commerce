import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hrx_store/presentation/page_main/screens/page_cart/screen_cart.dart';
import 'package:hrx_store/presentation/page_main/screens/page_home/screen_home.dart';
import 'package:hrx_store/presentation/page_main/screens/page_order/screen_order.dart';
import 'package:hrx_store/presentation/page_main/screens/page_profile/screen_profile.dart';

ValueNotifier<int> indexChangingNotifer = ValueNotifier(0);

class ScreenNavigationbar extends StatelessWidget {
  ScreenNavigationbar({super.key});
  final screens = [
    ScreenHome(),
    const ScreenCart(),
    const ScreenOrder(),
    const ScreenProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: indexChangingNotifer,
        builder: (BuildContext context, int index, _) {
          return screens[index];
        },
      )),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ValueListenableBuilder(
      valueListenable: indexChangingNotifer,
      builder: (BuildContext context, int index, _) {
        return Padding(
          padding: EdgeInsets.only(
              right: size.width * 0.10,
              left: size.width * 0.10,
              bottom: 8,
              top: 3),
          child: GNav(
            selectedIndex: index,
            rippleColor: Colors.black38,
            backgroundColor: Colors.transparent,
            onTabChange: (value) {
              indexChangingNotifer.value = value;
            },
            tabBorderRadius: 10,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
            color: Colors.black,
            activeColor: Colors.white,
            iconSize: 24,
            tabBackgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: ' Home',
              ),
              GButton(
                icon: Icons.trolley,
                text: ' Cart',
              ),
              GButton(
                icon: Icons.delivery_dining,
                text: ' Order',
              ),
              GButton(
                icon: Icons.person,
                text: ' Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
