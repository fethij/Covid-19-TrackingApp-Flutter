class CovidStats {
  final int cases, deaths, recovered, updated;

  CovidStats({
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.updated,
  });

  factory CovidStats.fromJson(Map<String, dynamic> json) {
    return CovidStats(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      updated: json['updated'],
    );
  }
}
