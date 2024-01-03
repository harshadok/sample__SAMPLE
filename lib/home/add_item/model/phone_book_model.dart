class PhoneBookModel {
  String? flagCode;
  String? phoneType;
  String? countryCode;
  String? areaCode;
  String? phoneNumber;
  String? phoneExtension;
  String? comments;
  int id;
  String? countryName;
  bool? setAsPreffred;

  PhoneBookModel({
    this.phoneType,
    this.countryCode,
    this.areaCode,
    this.phoneNumber,
    this.phoneExtension,
    this.comments,
    this.flagCode,
   this. countryName,
   this.setAsPreffred,
    required this.id
  });

  factory PhoneBookModel.fromJson(Map<String, dynamic> json) {
    return PhoneBookModel(
      phoneType: json['phoneType'],
      countryCode: json['countryCode'],
      areaCode: json['areaCode'],
      phoneNumber: json['phoneNumber'],
      phoneExtension: json['phoneExtension'],
      comments: json['comments'],
      flagCode: json['flagCode'],
      countryName: json["countryName"],
      id:json["id"],
      setAsPreffred:json['setAsPreffred']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneType': phoneType,
      'countryCode': countryCode,
      'areaCode': areaCode,
      'phoneNumber': phoneNumber,
      'phoneExtension': phoneExtension,
      'comments': comments,
      'flagCode':flagCode,
      'countryName':'countryName',
      'id':id,
      'setAsPreffred':setAsPreffred
    };
  }
}
