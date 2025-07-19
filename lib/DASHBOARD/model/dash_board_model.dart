class DashBoardModel {
  String? site;
  String? individual;
  String? date;
  String? time;
  double? parameterA;
  double? parameterB;

  DashBoardModel(
      {this.site,
        this.individual,
        this.date,
        this.time,
        this.parameterA,
        this.parameterB});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    site = json['Site'];
    individual = json['Individual'];
    date = json['Date'];
    time = json['Time'];
    parameterA = json['Parameter_A'];
    parameterB = json['Parameter_B'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Site'] = this.site;
    data['Individual'] = this.individual;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Parameter_A'] = this.parameterA;
    data['Parameter_B'] = this.parameterB;
    return data;
  }
}
