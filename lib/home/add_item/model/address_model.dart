class Address {
  String? addressType;
  String? selectedAdress;
  String? addressLine2;
  String? addressLine1;
  String? postbox;
  String? apartmentNo;
  String? streetAddressNo;
  String? streetName;
  String? countryCode;
  String? county;
  String city;
  String state;
  String postalCode;
  String country;
  String? zipCode;
  String? timeZone;
  String? fromDate;
  String? toDate;
  int id;

  Address(
      {required this.addressType,
      required this.city,
      required this.addressLine1,
      required this.state,
      required this.postalCode,
      required this.country,
      required this.id,
      this.selectedAdress,
      this.addressLine2,
      this.postbox,
      this.apartmentNo,
      this.streetAddressNo,
      this.streetName,
      this.countryCode,
      this.county,
      this.zipCode,
      this.fromDate,
      this.toDate,
      this.timeZone});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        addressLine1: json["addressLine1"],
        addressType: json["addressType"],
        selectedAdress: json['selectedAdress'],
        addressLine2: json['addressLine2'],
        postbox: json['postbox'],
        apartmentNo: json['apartmentNo'],
        streetAddressNo: json['streetAddressNo'],
        streetName: json['streetName'],
        countryCode: json['countryCode'],
        county: json['county'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country'],
        id: json['id'],
        zipCode: json["zipCode"],
        timeZone: json["timeZone"],
        fromDate:json['fromDate'],
        toDate:json['toDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'addressType': addressType,
      'addressLine1': addressLine1,
      'selectedAdress': selectedAdress,
      'addressLine2': addressLine2,
      'postbox': postbox,
      'apartmentNo': apartmentNo,
      'streetAddressNo': streetAddressNo,
      'streetName': streetName,
      'countryCode': countryCode,
      'county': county,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'id': id,
      'zipCode': zipCode,
      'timeZone': timeZone,
      'fromDate': fromDate,
      'toDate':toDate
    };
  }
}
