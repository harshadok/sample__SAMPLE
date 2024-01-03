// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:phone_book/home/add_item/model/address_model.dart';
import 'package:phone_book/home/add_item/model/country_model.dart';
import 'package:phone_book/home/add_item/model/phone_book_model.dart';
import 'package:phone_book/home/add_item/model/state_model.dart';
import 'package:phone_book/home/add_item/model/country_codes.dart';

class AddaddressViewModel extends ChangeNotifier {
  bool? serviceEnabled;
  bool editValue = false;
  bool editValuePhone = false;
  bool? changeAddressFeild;
  List<Address> addressBook = [];
  List<PhoneBookModel> phoneBook = [];
  List<String> currentStateList = [];
  List<String> currentCountyList = ['other'];
  List<Placemark>? placemarks;
  LocationPermission? permission;
  Country? selectedCountry;
  Position? position;
  String? unserLocation;
  Address? currentEditItemAddress;
  PhoneBookModel? currentEditItemPhoneBook;
  String DateSelected = "";
 TextEditingController  fromDateController = TextEditingController();

  List<String> specificTimeZones = [
    'UTC',
    'America/New_York',
    'Europe/London',
  ];

  selectedSetAsPrefferd(PhoneBookModel item) {
    for (int i = 0; i < phoneBook.length; i++) {
      if (phoneBook[i].id == item.id) {
        phoneBook[i].setAsPreffred = true;
      }
    }
    notifyListeners();
  }

  updateDateFrom(date) {
    DateSelected = DateFormat('MMM d, yyyy').format(date).toString();
  fromDateController.text = DateSelected;
    notifyListeners();
  }

  updateFromDatecontroller (TextEditingController controller) {
    fromDateController = controller;
  }

  removepreffred() {
    for (int i = 0; i < phoneBook.length; i++) {
      if (phoneBook[i].setAsPreffred == true) {
        phoneBook[i].setAsPreffred = false;
      }
    }
    notifyListeners();
  }

  changeBool(value) {
    value = true;
    notifyListeners();
  }

  getstatelist(String currentCountryName) {
    currentStateList.clear();
    for (var element in countriesList) {
      if (element.name == currentCountryName) {
        String curentcode = element.code;
        for (var stateElement in stateListModel) {
          if (stateElement["countryCode"] == curentcode) {
            currentStateList.add(stateElement['name']);
          }
        }
      }
    }
    notifyListeners();
  }

  assignValuetoToAddressEditFeild({required Address item}) {
    editValue = true;
    changeAddressFeild = true;
    currentEditItemAddress = item;
    notifyListeners();
  }

  assignValuePhoneEditFeild({required PhoneBookModel item}) {
    editValuePhone = true;
    currentEditItemPhoneBook = item;
    notifyListeners();
  }

  selectedCountryType(controller, code) {
    controller.text = code;
    notifyListeners();
  }

  selectedCountryTypePhoneBook(
      String code, Country item, TextEditingController controller) {
    selectedCountry = item;
    controller.text = item.name;
    notifyListeners();
  }

  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition().then((value) async {
      placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      return null;
    });
    if (placemarks != null) {
      print(placemarks![0].toString());
      unserLocation =
          "${placemarks![0].name.toString()}, ${placemarks![0].subLocality.toString()}, ${placemarks![0].subAdministrativeArea.toString()}, ${placemarks![0].locality.toString()}, ${placemarks![0].administrativeArea.toString()}, ${placemarks![0].postalCode.toString()} ";
    } else {
      unserLocation = "No Location";
    }
    changeAddressFeild = true;
    notifyListeners();
  }

  additemToAddressBook({
    required BuildContext ctx,
    required String addressType,
    required String addressLine1,
    required String selectedAdress,
    required String city,
    required String state,
    required String country,
    required String postalCode,
    required String addressLine2,
    required String apartmentNo,
    required String countryCode,
    required String county,
    required String postbox,
    required String streetName,
    required String zipCode,
    required String timeZone,
    required String streetAddressNo,
    required String fromDate,
    required String toDate,
  }) {
    int id = DateTime.now().microsecondsSinceEpoch;
    final Address address = Address(
        addressType: addressType,
        addressLine1: addressLine1,
        selectedAdress: selectedAdress,
        city: city,
        state: state,
        postalCode: postalCode,
        id: id,
        addressLine2: addressLine2,
        apartmentNo: apartmentNo,
        countryCode: countryCode,
        county: county,
        country: country,
        streetName: streetName,
        streetAddressNo: streetAddressNo,
        zipCode: zipCode,
        timeZone: timeZone,
        postbox: postbox,
        fromDate: fromDate,
        toDate: toDate);
    if (selectedAdress.isNotEmpty) {
      addressBook.add(address);
      clearAddress();
      Navigator.pop(ctx);
    }
    notifyListeners();
  }

  edititemAddressBook(
      {required BuildContext ctx,
      required String addressType,
      required String addressLine1,
      required String selectedAdress,
      required String city,
      required String state,
      required String country,
      required String postalCode,
      required String addressLine2,
      required String apartmentNo,
      required String countryCode,
      required String county,
      required String postbox,
      required String streetName,
      required String zipCode,
      required String timeZone,
      required String streetAddressNo,
      required String fromDate,
      required String toDate}) {
    currentEditItemAddress!.addressType = addressType;
    currentEditItemAddress!.addressLine1 = addressLine1;
    currentEditItemAddress!.addressLine2 = addressLine2;
    currentEditItemAddress!.selectedAdress = selectedAdress;
    currentEditItemAddress!.city = city;
    currentEditItemAddress!.state = state;
    currentEditItemAddress!.postalCode = postalCode;
    currentEditItemAddress!.apartmentNo = apartmentNo;
    currentEditItemAddress!.countryCode = countryCode;
    currentEditItemAddress!.county = county;
    currentEditItemAddress!.country = country;
    currentEditItemAddress!.streetName = streetName;
    currentEditItemAddress!.streetAddressNo = streetAddressNo;
    currentEditItemAddress!.zipCode = zipCode;
    currentEditItemAddress!.timeZone = timeZone;
    currentEditItemAddress!.postbox = postbox;
    currentEditItemAddress!.fromDate = fromDate;
    currentEditItemAddress!.toDate = toDate;
    clearAddress();
    Navigator.pop(ctx);
    notifyListeners();
  }

  additemToPhoneBook(
      {required BuildContext ctx,
      required String phoneNumber,
      required String areaCode,
      required String countryCode,
      required String phoneExtension,
      required String comments,
      required String phoneType}) {
    if (selectedCountry != null) {
      int id = DateTime.now().microsecondsSinceEpoch;
      final PhoneBookModel model = PhoneBookModel(
          phoneNumber: phoneNumber,
          areaCode: areaCode,
          comments: comments,
          countryCode: selectedCountry!.phoneCode,
          phoneExtension: phoneExtension,
          phoneType: phoneType,
          countryName: selectedCountry!.name,
          flagCode: selectedCountry!.code,
          setAsPreffred: false,
          id: id);
      phoneBook.add(model);
      clearPhoneBook();
      Navigator.pop(ctx);
    }
    notifyListeners();
  }

  editItemToPhoneBook(
      {required BuildContext ctx,
      required String phoneNumber,
      required String areaCode,
      required String countryCode,
      required String phoneExtension,
      required String comments,
      required String countryName,
      required String phoneType}) {
    currentEditItemPhoneBook!.flagCode =
        countryName == currentEditItemPhoneBook!.countryName!
            ? currentEditItemPhoneBook!.flagCode
            : selectedCountry!.code;
    currentEditItemPhoneBook!.areaCode = areaCode;
    currentEditItemPhoneBook!.phoneNumber = phoneNumber;
    currentEditItemPhoneBook!.comments = comments;
    currentEditItemPhoneBook!.countryCode =
        countryName == currentEditItemPhoneBook!.countryName!
            ? currentEditItemPhoneBook!.countryCode
            : selectedCountry!.phoneCode;
    currentEditItemPhoneBook!.countryName =
        countryName == currentEditItemPhoneBook!.countryName!
            ? currentEditItemPhoneBook!.countryName
            : selectedCountry!.name;
    currentEditItemPhoneBook!.phoneType = phoneType;
    currentEditItemPhoneBook!.phoneExtension = phoneExtension;
    clearPhoneBook();
    Navigator.pop(ctx);
    notifyListeners();
  }

  removeitemFromList(index) {
    addressBook.removeAt(index);
    notifyListeners();
  }

  removeitemFromPhoneBookList(index) {
    phoneBook.removeAt(index);
    notifyListeners();
  }

  clearTextFormFild(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  clearAddress() {
    changeAddressFeild = false;
    placemarks = null;
    editValue = false;
    currentEditItemAddress = null;
    currentStateList.clear();
    notifyListeners();
  }

  clearPhoneBook() {
    selectedCountry = null;
    editValuePhone = false;
  }

  List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czechia',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Timor-Leste',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea (North)',
    'Korea (South)',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macedonia',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Swaziland',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican city',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
  ];
}
