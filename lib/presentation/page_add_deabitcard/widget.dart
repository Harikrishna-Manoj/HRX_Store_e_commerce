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
    Size size = MediaQuery.sizeOf(context);
    ValueNotifier<String> numberNotifier = ValueNotifier<String>('');
    ValueNotifier<String> dateNotifier = ValueNotifier<String>('');
    ValueNotifier<String> cvNotifier = ValueNotifier<String>('');
    TextEditingController cardNumberController = TextEditingController();
    TextEditingController cardDateController = TextEditingController();
    TextEditingController cardCVController = TextEditingController();
    List<String> allMonths = [
      'month',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    String dropdownMonthValue = allMonths.first;
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
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          title: const Text('Add card'),
                          content: SizedBox(
                            height: size.height * 0.2,
                            child: Column(
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    numberNotifier.value = value;
                                  },
                                  controller: cardNumberController,
                                  decoration: const InputDecoration(
                                      hintText: "Card number"),
                                ),
                                kHeight30,
                                Row(
                                  children: [
                                    StatefulBuilder(
                                      builder: (context, setState) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: DropdownButton<String>(
                                            // underline: Divider(),
                                            value: dropdownMonthValue,
                                            icon: const Icon(Icons
                                                .keyboard_arrow_down_outlined),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            elevation: 8,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            disabledHint: Container(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropdownMonthValue = value!;
                                              });
                                            },
                                            items: allMonths
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: TextField(
                                        onChanged: (value) {
                                          dateNotifier.value = value;
                                        },
                                        controller: cardDateController,
                                        decoration: const InputDecoration(
                                            hintText: "date"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: TextField(
                                        onChanged: (value) {
                                          cvNotifier.value = value;
                                        },
                                        controller: cardCVController,
                                        decoration: const InputDecoration(
                                            hintText: "CV"),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              child: const Text('Save'),
                              onPressed: () {},
                            ),
                          ],
                        );
                      });
                    });
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
