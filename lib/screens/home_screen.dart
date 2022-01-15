import 'dart:convert';

import 'package:covid_19_tracking/components/statistics_block.dart';
import 'package:covid_19_tracking/model/covid_stats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<CovidStats> covidStats;

  String baseUrl = 'https://corona.lmao.ninja/v2/all?yesterday';

  Future<CovidStats> getCovidStatistics() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return CovidStats.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load statistics');
    }
  }

  // _launchMythBusterURL() async {
  //   const url =
  //       'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // _launchDonateURL() async {
  //   const url =
  //       'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  _launchMythBusterURL() async {
    await FlutterWebBrowser.openWebPage(
      url:
          'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters',
    );
  }

  _launchDonateURL() async {
    await FlutterWebBrowser.openWebPage(
      url:
          'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate',
    );
  }

  @override
  void initState() {
    super.initState();
    covidStats = getCovidStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Stats'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Center(
                child: FutureBuilder<CovidStats>(
                  future: covidStats,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var millis = snapshot.data!.updated;
                      var dt = DateTime.fromMillisecondsSinceEpoch(millis);

                      return Column(
                        children: [
                          Text('Last updated: ${dt.toString()}'),
                          SizedBox(
                            height: 10,
                          ),
                          StatisticsBlock(
                            nameKey: 'Cases',
                            nameValue: snapshot.data!.cases
                                .toString()
                                .replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},'),
                          ),
                          StatisticsBlock(
                            nameKey: 'Recovered',
                            nameValue: snapshot.data!.recovered
                                .toString()
                                .replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},'),
                          ),
                          StatisticsBlock(
                            nameKey: 'Death',
                            nameValue: snapshot.data!.deaths
                                .toString()
                                .replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},'),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: _launchMythBusterURL,
                    child: Text(
                      'MYTH BUSTERS',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _launchDonateURL,
                    child: Text(
                      'DONATE',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
