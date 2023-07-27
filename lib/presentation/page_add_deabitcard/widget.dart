import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:hrx_store/core/constant.dart';

class CardLayout extends StatelessWidget {
  const CardLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          kHeight20,
          const HeaderWidgets(),
          kHeight10,
          const SwiperBuilder(),
        ],
      ),
    );
  }
}

class HeaderWidgets extends StatelessWidget {
  const HeaderWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.75,
            child: Text(
              'Click to add more credit cards to wallet.',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.75), fontSize: 15),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              onPressed: () {
                //          return await showDialog(
                // context: context,
                // builder: (context) {
                //   bool isChecked = false;
                //   return StatefulBuilder(builder: (context, setState) {
                //     return AlertDialog(
                //       content: Form(
                //           key: _formKey,
                //           child: Column(
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               TextFormField(
                //                 controller: _textEditingController,
                //                 validator: (value) {
                //                   return value.isNotEmpty ? null : "Enter any text";
                //                 },
                //                 decoration:
                //                     InputDecoration(hintText: "Please Enter Text"),
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Text("Choice Box"),
                //                   Checkbox(
                //                       value: isChecked,
                //                       onChanged: (checked) {
                //                         setState(() {
                //                           isChecked = checked;
                //                         });
                //                       })
                //                 ],
                //               )
                //             ],
                //           )),
                //       title: Text('Stateful Dialog'),
                //       actions: <Widget>[
                //         InkWell(
                //           child: Text('OK   '),
                //           onTap: () {
                //             if (_formKey.currentState.validate()) {
                //               // Do something like updating SharedPreferences or User Settings etc.
                //               Navigator.of(context).pop();
                //             }
                //           },
                //         ),
                //       ],
                //     );
                //   });
                // });
              },
              icon: const Icon(
                Icons.add_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SwiperBuilder extends StatelessWidget {
  const SwiperBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> imageUrl = [
      'asset/images/card_1.png',
      'asset/images/card_2.png',
      'asset/images/card_3.png',
    ];
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Swiper(
              itemWidth: 400,
              itemHeight: 225,
              loop: true,
              duration: 500,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imageUrl[index])),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
              itemCount: imageUrl.length,
              layout: SwiperLayout.STACK,
            ),
          ),
        ),
      ),
    );
  }
}
