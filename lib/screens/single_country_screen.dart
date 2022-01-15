import 'package:covid_19_tracking/components/country_covid_block.dart';
import 'package:covid_19_tracking/model/country_covid_stats.dart';
import 'package:flutter/material.dart';

class SingleCountryScreen extends StatelessWidget {
  const SingleCountryScreen({Key? key, required this.singleCountry})
      : super(key: key);

  final CountryCovidStats singleCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(singleCountry.country),
      ),
      body: Container(
        height: MediaQuery.of(context).size.width / 2.5,
        padding: const EdgeInsets.all(10),
        child: CountryCovidBlock(
          imageUrl: singleCountry.flag,
          country: singleCountry.country,
          cases: singleCountry.cases.toString(),
          todayCases: singleCountry.todayCases.toString(),
          todayDeaths: singleCountry.todayDeaths.toString(),
          deaths: singleCountry.deaths.toString(),
          recovered: singleCountry.recovered.toString(),
        ),
      ),
    );
  }
}
