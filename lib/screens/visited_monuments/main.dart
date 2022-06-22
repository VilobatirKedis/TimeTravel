import 'package:flutter/material.dart';
import 'package:time_travel/utils/constants.dart';
import 'package:tcard/tcard.dart';
import 'package:time_travel/utils/monumentJSON.dart';


class VisitedMonuments extends StatelessWidget {
  VisitedMonuments({Key? key}) : super(key: key);
  
  final List<Widget> cards = List.generate(
    1,//dataMarker.length,
    (index) => Container(
      child: Column(
        children: [
          Text("Ciao")//dataMarker[index].image
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      child: TCard(
        cards: cards
      )
    );
  }
}