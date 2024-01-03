class Country {
  late String _name;

  late String _countryCode;

  late String _phoneCode;

  Country(
      {required String name,
      required String countryCode,
      required String phoneCode}) {
    _name = name;
    _countryCode = countryCode;
    _phoneCode = phoneCode;
  }
  
  String get name => _name;

  String get code => _countryCode;

  String get phoneCode => _phoneCode;
}


class StateList {
    String name;
    String isoCode;
    String countryCode;
    String latitude;
    String longitude;

    StateList({
        required this.name,
        required this.isoCode,
        required this.countryCode,
        required this.latitude,
        required this.longitude,
    });

    factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        name: json["name"],
        isoCode: json["isoCode"],
        countryCode: json["countryCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "isoCode": isoCode,
        "countryCode": countryCode,
        "latitude": latitude,
        "longitude": longitude,
    };
}