class CountryCovidStats {
  final int updated, cases, todayCases, todayDeaths, deaths, recovered;
  final String country, flag;

  CountryCovidStats({
    required this.updated,
    required this.cases,
    required this.todayCases,
    required this.todayDeaths,
    required this.deaths,
    required this.recovered,
    required this.country,
    required this.flag,
  });

  factory CountryCovidStats.fromJson(Map<String, dynamic> json) {
    return CountryCovidStats(
      updated: json['updated'],
      country: json['country'],
      flag: json['countryInfo']['flag'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
    );
  }
}

class CountryList {
  final List<CountryCovidStats> countries;

  CountryList({
    required this.countries,
  });

  factory CountryList.fromJson(List<dynamic> json) {
    List<CountryCovidStats> countries = [];
    countries = json.map((e) => CountryCovidStats.fromJson(e)).toList();

    return new CountryList(countries: countries);
  }
}
