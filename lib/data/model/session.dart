class Session {
  final Map<String, dynamic> plate;
  final Map<String, dynamic> dtStart;
  final String positionToken;
  final String token;
  final List<dynamic> coordinates;
  final Map<String, dynamic> costTimePair;

  const Session({
    this.plate,
    this.dtStart,
    this.positionToken,
    this.token,
    this.coordinates,
    this.costTimePair,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      plate: json["plate"],
      dtStart: json['dtstart'],
      positionToken: json["position_token"],
      token : json['token'],
      coordinates: json['coordinates'],
      costTimePair: json['cost_time_pair'],
    );
  }

  Map<String, dynamic> toJson() => {
        'plate': plate,
        'dtstart': dtStart,
        'position_token': positionToken,
        'token' : token,
        'coordinates': coordinates,
        'cost_time_pair': costTimePair,
      };

  String getPlate() => plate['id'];

  double getLatitude() => coordinates.last;

  double getLongitude() => coordinates.first;

  double getCost() => costTimePair['cost'];

  Duration getDuration() {
    final int durationString = costTimePair['duration_ms'];
    return Duration(milliseconds: durationString);
  }

  DateTime getInitialDate() {
    final dateString = dtStart["date"];
    return DateTime.parse(dateString).toLocal();
  }

  DateTime getFinalDate() => getInitialDate().add(getDuration()).toLocal();

  Duration getTimeLeft() => getFinalDate().difference(DateTime.now());

  String getFormattedFinalDate() {
    final finalDate = getFinalDate();
    return '${finalDate.hour}:${finalDate.minute}';
  }
}
