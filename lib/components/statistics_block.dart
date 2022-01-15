import 'package:flutter/material.dart';

class StatisticsBlock extends StatelessWidget {
  const StatisticsBlock({
    Key? key,
    required this.nameKey,
    required this.nameValue,
  }) : super(key: key);

  final String nameKey, nameValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/country');
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(
          bottom: 5,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xffcccccc).withOpacity(0.3),
              blurRadius: 1,
              spreadRadius: 2,
              offset: Offset(0, 0.3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nameKey),
            Text(nameValue),
          ],
        ),
      ),
    );
  }
}
