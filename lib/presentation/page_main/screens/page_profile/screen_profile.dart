import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_address/screen_address.dart';
import 'package:hrx_store/presentation/page_main/screens/page_profile/widgets.dart';
import 'package:hrx_store/presentation/page_order_history/screen_order_history.dart';
import 'package:hrx_store/presentation/page_returned_product/screen_returned_product.dart';
import 'package:hrx_store/presentation/page_wishlist/screen_wishlist.dart';

import '../../../../core/constant.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 10,
            ),
            child: Column(
              children: [
                kHeight10,
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text('My Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                  ],
                ),
                kHeight10,
                ProfilePhoto(
                    image: user!.photoURL,
                    name: user.displayName,
                    email: user.email),
                kHeight30,
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const PRofileItems(
                            itemName: 'My Wishlist',
                            iteamIcon: Icons.favorite_outlined,
                            page: ScreenWishlist()),
                        kHeight30,
                        const PRofileItems(
                          itemName: 'Shipping Address',
                          iteamIcon: Icons.location_on_rounded,
                          page: ScreenAddress(),
                        ),
                        kHeight30,
                        const PRofileItems(
                          itemName: 'Order History',
                          iteamIcon: Icons.history_outlined,
                          page: ScreenOrderHistory(),
                        ),
                        kHeight30,
                        const PRofileItems(
                          itemName: 'Returns',
                          iteamIcon: Icons.production_quantity_limits,
                          page: ScreenReturnedProduct(),
                        ),
                        kHeight30,
                        const LogOutButton(
                            itemName: 'Log out', iteamIcon: Icons.exit_to_app)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
