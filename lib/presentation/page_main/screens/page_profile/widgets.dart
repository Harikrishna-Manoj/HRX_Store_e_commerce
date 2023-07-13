import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/services/firebase_auth/fire_base_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:text_scroll/text_scroll.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    required this.image,
    required this.name,
    required this.email,
  });
  final String? image;
  final String? name;
  final String? email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.30,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            kHeight20,
            image != null
                ? CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      image!,
                    ))
                : SizedBox(
                    height: 140,
                    width: 140,
                    child: Image.asset(
                      'asset/images/profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
            TextScroll(
                fadedBorder: true,
                fadeBorderSide: FadeBorderSide.both,
                fadedBorderWidth: .045,
                mode: TextScrollMode.endless,
                velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                name ?? 'Name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            TextScroll(
                fadedBorder: true,
                fadeBorderSide: FadeBorderSide.both,
                fadedBorderWidth: .045,
                mode: TextScrollMode.endless,
                velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                email ?? "Email",
                style: const TextStyle(color: Colors.grey))
          ],
        ),
      ),
    );
  }
}

class PRofileItems extends StatelessWidget {
  const PRofileItems({
    super.key,
    required this.itemName,
    required this.iteamIcon,
    this.page,
  });
  final IconData iteamIcon;
  final String itemName;
  final Widget? page;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            PageTransition(child: page!, type: PageTransitionType.rightToLeft));
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Icon(iteamIcon),
          ),
          const SizedBox(
            width: 40,
          ),
          Text(
            itemName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
    required this.itemName,
    required this.iteamIcon,
  });
  final IconData iteamIcon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Log out of your account?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    FirebaseAuthentication.accountLogOut(context: context);
                  },
                  child: const Text('Log out',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)))
            ],
          ),
        );
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Icon(
              iteamIcon,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Text(
            itemName,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
