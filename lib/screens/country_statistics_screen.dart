import 'dart:convert';

import 'package:covid_19_tracking/components/country_covid_block.dart';
import 'package:covid_19_tracking/model/country_covid_stats.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryStatisticsScreen extends StatefulWidget {
  CountryStatisticsScreen({Key? key}) : super(key: key);

  @override
  _CountryStatisticsScreenState createState() =>
      _CountryStatisticsScreenState();
}

class _CountryStatisticsScreenState extends State<CountryStatisticsScreen> {
  late Future<List<dynamic>> countryCovidStats;

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List countries = [];
  List filteredCountries = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Country');

  String baseUrl = 'https://corona.lmao.ninja/v2/countries/';

  void _getCountries() async {
    final response = await dio.get(baseUrl);
    List tempList = [];
    for (int i = 0; i < response.data.length; i++) {
      tempList.add(response.data[i]);
    }
    setState(() {
      countries = tempList;
      filteredCountries = countries;
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('Search Country');
        filteredCountries = countries;
        _filter.clear();
      }
    });
  }

  _CountryStatisticsScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = '';
          filteredCountries = countries;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List tempList = [];
      for (int i = 0; i < filteredCountries.length; i++) {
        if (filteredCountries[i]['country']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredCountries[i]);
        }
      }
      filteredCountries = tempList;
    }
    return ListView.builder(
        itemCount: countries.isEmpty ? 0 : filteredCountries.length,
        itemBuilder: (context, index) {
          return CountryCovidBlock(
            imageUrl: filteredCountries[index]['countryInfo']['flag'],
            country: filteredCountries[index]['country'],
            cases: filteredCountries[index]['cases'].toString(),
            todayCases: filteredCountries[index]['todayCases'].toString(),
            todayDeaths: filteredCountries[index]['todayDeaths'].toString(),
            deaths: filteredCountries[index]['deaths'].toString(),
            recovered: filteredCountries[index]['recovered'].toString(),
          );
        });
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Future<List<dynamic>> getCountryData() async {
    http.Response response = await http.get(Uri.parse(baseUrl));

    final data = json.decode(response.body);
    List<dynamic> responseBody =
        data.map((item) => CountryCovidStats.fromJson(item)).toList();

    return responseBody;
  }

  @override
  void initState() {
    super.initState();
    _getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _buildBar(context),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }
}
