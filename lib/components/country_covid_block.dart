import 'package:flutter/material.dart';

class CountryCovidBlock extends StatelessWidget {
  const CountryCovidBlock({
    Key? key,
    required this.imageUrl,
    required this.country,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
  }) : super(key: key);

  final String imageUrl,
      country,
      cases,
      todayCases,
      deaths,
      todayDeaths,
      recovered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                height: 20,
                child: Text(
                  country,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width / 4,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('CASES: $cases'),
              Text('TODAY CASES: $todayCases'),
              Text('TODAY DEATHS: $todayDeaths'),
              Text('DEATHS: $deaths'),
              Text('RECOVERED: $recovered'),
            ],
          ),
        ],
      ),
    );
  }
}
