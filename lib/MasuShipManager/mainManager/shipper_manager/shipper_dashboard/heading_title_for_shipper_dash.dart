import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class heading_title_for_shipper_dash extends StatelessWidget {
  final int numberColumn;
  final List<String> listTitle;
  final double width;
  final double height;
  const heading_title_for_shipper_dash({super.key, required this.numberColumn, required this.listTitle, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 250, 255),
          border: Border.all(
              width: 1,
              color: Color.fromARGB(255, 225, 225, 226)
          )
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listTitle.length,
              itemBuilder: (context, index) {
                return Container(
                  width: (width)/(listTitle.length.toDouble()),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: (width)/(listTitle.length.toDouble()) - 1,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                              child: AutoSizeText(
                                listTitle[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'muli',
                                    color: Colors.black,
                                    fontSize: 100
                                ),
                              )
                          ),
                        ),
                      ),

                      Container(
                        width: 1,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 225, 225, 226)
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
