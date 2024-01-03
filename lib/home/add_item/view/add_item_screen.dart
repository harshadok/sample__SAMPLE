// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:phone_book/home/add_item/model/address_model.dart';
import 'package:phone_book/home/add_item/model/country_model.dart';
import 'package:phone_book/home/add_item/model/phone_book_model.dart';
import 'package:phone_book/home/add_item/widgets/common_bottomSheet.dart';
import 'package:phone_book/home/add_item/widgets/common_textfrom.dart';
import 'package:phone_book/home/add_item/view_model/add_address_viewmodel.dart';
import 'package:phone_book/home/add_item/model/country_codes.dart';
import 'package:phone_book/home/web_view/src/webview_stack.dart';
import 'package:phone_book/home/web_view/webview.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum AddType { addAddress, addPhone }

class AddItemScreen extends StatefulWidget {
  const AddItemScreen(
      {super.key,
      required this.addType,
      this.addressItem,
      this.phoneBookModel});
  final AddType addType;
  final Address? addressItem;
  final PhoneBookModel? phoneBookModel;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final addressTypeController = TextEditingController();
  final selectedAddressController = TextEditingController();
  final AddressLine1Controller = TextEditingController();
  final AddressLine2Controller = TextEditingController();
  final postboxController = TextEditingController();
  final apartmentController = TextEditingController();
  final selectedAdressNameController = TextEditingController();
  final selectedAdressNoController = TextEditingController();
  final countrycodeController = TextEditingController();
  final stateController = TextEditingController();
  final countyController = TextEditingController();
  final cityController = TextEditingController();
  final zipcodeController = TextEditingController();
  final timezoneController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  late final WebViewController controller;
  bool changeContiner = false;
  String webViewText = '';

  //phone book controller are here--->
  final countrynamePhoneController = TextEditingController();
  final phonetypeController = TextEditingController();
  final areaCodeController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneExtensionController = TextEditingController();
  final commentsController = TextEditingController();

  @override
  void initState() {
    if (widget.addType == AddType.addAddress) {
      controller = WebViewController();
    }
    if (widget.addressItem != null) {
      addressTypeController.text = widget.addressItem!.addressType!;
      cityController.text = widget.addressItem!.city;
      AddressLine1Controller.text = widget.addressItem!.addressLine1!;
      apartmentController.text = widget.addressItem!.apartmentNo!;
      AddressLine2Controller.text = widget.addressItem!.addressLine2!;
      selectedAdressNoController.text = widget.addressItem!.streetAddressNo!;
      selectedAdressNameController.text = widget.addressItem!.streetName!;
      stateController.text = widget.addressItem!.state;
      countyController.text = widget.addressItem!.country;
      countrycodeController.text = widget.addressItem!.countryCode!;
      zipcodeController.text = widget.addressItem!.zipCode!;
      timezoneController.text = widget.addressItem!.timeZone!;
      postboxController.text = widget.addressItem!.postbox!;
      selectedAddressController.text = widget.addressItem!.selectedAdress!;
      fromDateController.text = widget.addressItem!.fromDate!;
      toDateController.text = widget.addressItem!.toDate!;
    }
    if (widget.phoneBookModel != null) {
      phonetypeController.text = widget.phoneBookModel!.phoneType!;
      countrynamePhoneController.text =
          widget.phoneBookModel!.countryName ?? "";
      areaCodeController.text = widget.phoneBookModel!.areaCode!;
      phoneController.text = widget.phoneBookModel!.phoneNumber!;
      phoneExtensionController.text = widget.phoneBookModel!.phoneExtension!;
      commentsController.text = widget.phoneBookModel!.comments!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addadressViewmodel = context.watch<AddaddressViewModel>();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 229, 242, 251),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[900],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Text(
            widget.addType == AddType.addAddress ? "Address" : "Phone",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: widget.addType == AddType.addAddress
                ? addAddressListview(
                    context: context,
                    addadressViewmodel: addadressViewmodel,
                  )
                : addPhoneBookListview(context, addadressViewmodel)));
  }

  ///************************************* */ PHONE BOOK LIST VIEW=======***********************************
  addPhoneBookListview(
      BuildContext context, AddaddressViewModel addadressViewmodel) {
    return ListView(
      children: [
        const SizedBox(
          height: 10,
        ),
        customeTextField(context,
            hintext: "Phone Type",
            Controller: phonetypeController,
            enabled: false,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 25,
                color: Colors.black,
              ),
            ), onPresstextFieldContiner: () {
          customeBottomSheet(
              addtypeMethod: AddType.addPhone,
              context: context,
              listileOntap1: () {
                phonetypeController.text =
                    "mobile phone type alterhone mobile phone typealterhone";
              },
              listileOntap2: () {
                phonetypeController.text = "Primary phone";
              },
              listileOntap3: () {
                phonetypeController.text = "Secondary phone";
              });
        },
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                ))),
        customeTextField(context,
            hintext: "Country Code",
            Controller: countrynamePhoneController,
            enabled: false,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 25,
                color: Colors.black,
              ),
            ), onPresstextFieldContiner: () {
          commoneBottomSheet(
              context: context,
              itemlist: countriesList,
              selectedCountry: (Country item) {
                countrynamePhoneController.text = item.name.toString();
                addadressViewmodel.selectedCountryTypePhoneBook(
                    item.name, item, countrynamePhoneController);
              },
              onPressed: (item) {},
              titile: "Country Code");
        },
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                ))),
        customeTextField(context,
            hintext: "Area Code",
            Controller: areaCodeController,
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  size: 17,
                  weight: 2,
                )),
            onPresstextFieldContiner: () {},
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                ))),
        customeTextField(context,
            hintext: "Phone Number",
            Controller: phoneController,
            suffixIcon: IconButton(
                onPressed: () {
                  addadressViewmodel.clearTextFormFild(phoneController);
                },
                icon: const Icon(
                  Icons.close,
                  size: 17,
                  weight: 2,
                )),
            onPresstextFieldContiner: () {},
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                ))),
        customeTextField(context,
            hintext: "Phone Extension",
            Controller: phoneExtensionController,
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  size: 17,
                  weight: 2,
                )),
            onPresstextFieldContiner: () {},
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                ))),
        customeTextField(context,
            hintext: "Comments",
            Controller: commentsController,
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  size: 17,
                  weight: 2,
                )),
            onPresstextFieldContiner: () {},
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                ))),
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(10, 40)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 108, 170, 222)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ))),
                onPressed: () {
                  addadressViewmodel.editValuePhone == true
                      ? addadressViewmodel.editItemToPhoneBook(
                          countryName: countrynamePhoneController.text,
                          areaCode: areaCodeController.text,
                          comments: commentsController.text,
                          countryCode: countrycodeController.text,
                          ctx: context,
                          phoneExtension: phoneExtensionController.text,
                          phoneNumber: phoneController.text,
                          phoneType: phonetypeController.text)
                      : addadressViewmodel.additemToPhoneBook(
                          areaCode: areaCodeController.text,
                          comments: commentsController.text,
                          countryCode: countrycodeController.text,
                          ctx: context,
                          phoneExtension: phoneExtensionController.text,
                          phoneNumber: phoneController.text,
                          phoneType: phonetypeController.text);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                )))
      ],
    );
  }

  ///************************************* */ ADDRESS BOOK LIST VIEW=======***********************************

  ListView addAddressListview({
    required BuildContext context,
    required AddaddressViewModel addadressViewmodel,
  }) {
    return ListView(
      children: [
        customeTextField(context,
            Controller: addressTypeController,
            hintext: "Address Type",
            enabled: false,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 30,
                color: Colors.black,
              ),
            ), onPresstextFieldContiner: () {
          customeBottomSheet(
              addtypeMethod: AddType.addAddress,
              context: context,
              listileOntap2: () {
                addressTypeController.text = "Secondary Address";
              },
              listileOntap1: () {
                addressTypeController.text = "Primary Address";
              });
        },
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                ))),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 10,
            top: 10,
          ),
          child: const Text(
            "Location Coordinates",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        addadressViewmodel.changeAddressFeild == true
            ? Container(
                height: 60,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 10,
                ),
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 184, 207, 230),
                    border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(255, 93, 156, 97)),
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  selectedAddressController.text,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              )
            : customeTextField(context,
                continreHight: 35,
                enabled: false,
                hintext: "Click here to pick your location",
                onPresstextFieldContiner: () async {
                await addadressViewmodel.determinePosition().then((_) {
                  selectedAddressController.text =
                      addadressViewmodel.unserLocation!;
                });
              },
                prefixIcon: const Icon(
                  Icons.my_location_rounded,
                  color: Colors.black,
                )),
        customeTextField(context,
            hintext: "Address Line 1",
            suffixIcon: IconButton(
                onPressed: () {
                  addadressViewmodel.clearTextFormFild(AddressLine1Controller);
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  weight: 2,
                )),
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                )),
            Controller: AddressLine1Controller),
        customeTextField(context,
            hintext: "Address Line 2",
            suffixIcon: IconButton(
                onPressed: () {
                  addadressViewmodel.clearTextFormFild(AddressLine2Controller);
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  weight: 2,
                )),
            Controller: AddressLine2Controller),
        customeTextField(context,
            hintext: "postbox",
            suffixIcon: IconButton(
                onPressed: () {
                  addadressViewmodel.clearTextFormFild(postboxController);
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  weight: 2,
                )),
            Controller: postboxController),
        customeTextField(context,
            hintext: "Apartment No",
            suffixIcon: IconButton(
                onPressed: () {
                  addadressViewmodel.clearTextFormFild(apartmentController);
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  weight: 2,
                )),
            Controller: apartmentController),
        customeTextField(context,
            hintext: "Street No",
            suffixIcon: IconButton(
                onPressed: () {
                  addadressViewmodel
                      .clearTextFormFild(selectedAdressNoController);
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  weight: 2,
                )),
            trailingIcon: SizedBox(
                height: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  iconSize: 25,
                  color: Colors.green[900],
                )),
            Controller: selectedAdressNoController),
        customeTextField(
          context,
          hintext: "Street Name",
          suffixIcon: IconButton(
              onPressed: () {
                addadressViewmodel
                    .clearTextFormFild(selectedAdressNameController);
              },
              icon: const Icon(
                Icons.close,
                size: 20,
                weight: 2,
              )),
          Controller: selectedAdressNameController,
          trailingIcon: SizedBox(
              height: 55,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.info),
                iconSize: 25,
                color: Colors.green[900],
              )),
        ),
        //here selecting country code
        customeTextField(
          context,
          Controller: countrycodeController,
          enabled: false,
          hintext: "Country Code",
          onPresstextFieldContiner: () {
            commoneBottomSheet(
                selectedCountry: (_) {},
                onPressed: (item) {
                  countrycodeController.text = item;
                  stateController.clear();
                  countyController.clear();
                  addadressViewmodel.getstatelist(item);
                },
                context: context,
                titile: "Countrycode",
                itemlist: addadressViewmodel.countries);
          },
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        //here are the state code
        customeTextField(
          context,
          Controller: stateController,
          enabled: false,
          hintext: "State",
          onPresstextFieldContiner: () {
            commoneBottomSheet(
                selectedCountry: (_) {},
                onPressed: (item) {
                  stateController.text = item;
                  countyController.clear();
                },
                context: context,
                titile: "State",
                itemlist: addadressViewmodel.currentStateList);
          },
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        //here are the state code
        customeTextField(
          context,
          Controller: countyController,
          enabled: false,
          hintext: "County",
          onPresstextFieldContiner: () {
            commoneBottomSheet(
                selectedCountry: (_) {},
                onPressed: (item) {
                  countyController.text = item;
                },
                context: context,
                titile: "County",
                itemlist: addadressViewmodel.currentCountyList);
          },
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        customeTextField(context,
            hintext: "City",
            suffixIcon: IconButton(
                onPressed: () {
                  addadressViewmodel.clearTextFormFild(cityController);
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  weight: 2,
                )),
            Controller: cityController),
        customeTextField(
          context,
          Controller: zipcodeController,
          hintext: "ZipCode",
          suffixIcon: IconButton(
              onPressed: () {
                addadressViewmodel.clearTextFormFild(zipcodeController);
              },
              icon: const Icon(
                Icons.close,
                size: 20,
                weight: 2,
              )),
        ),
        customeTextField(
          context,
          enabled: false,
          hintext: "Time Zone",
          Controller: timezoneController,
          onPresstextFieldContiner: () {
            commoneBottomSheet(
                selectedCountry: (_) {},
                context: context,
                titile: "Time Zone",
                onPressed: (index) {
                  timezoneController.text = index;
                },
                itemlist: addadressViewmodel.specificTimeZones);
          },
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        customeTextField(context,
            enabled: false,
            hintext: "From Date",
            Controller: fromDateController, onPresstextFieldContiner: () {
          dateBottomSheet(context: context, titile: "From Date");
          addadressViewmodel.updateFromDatecontroller(fromDateController);
        }),
        customeTextField(context,
            enabled: false,
            hintext: "To Date",
            Controller: toDateController, onPresstextFieldContiner: () {
          dateBottomSheet(context: context, titile: 'To Date');
          addadressViewmodel.updateFromDatecontroller(toDateController);
        }),
        SizedBox(
          height: 31,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewApp(
                                  controller: controller,
                                  onSubmit: (text) async {
                                    var contentbase64 = """<!doctype html>
                                         <html><head><meta name="viewport" content="width=device-width,
                                          initial-scale=1.0"></head> <body style='"margin: 0; padding: 0;
                                          '><div> $text </div> </body> </html>""";
                                    await controller
                                        .loadHtmlString(contentbase64)
                                        .then((e) {
                                      setState(() {
                                        webViewText = text;
                                      });
                                    });
                                  },
                                  webViewText:
                                      webViewText == "" ? '' : webViewText,
                                )));
                  },
                  child: Text(webViewText == "" ? 'Add' : "Edit")),
            ],
          ),
        ),
        webViewText != ''
            ? Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 10,
                ),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 184, 207, 230),
                    border: Border.all(
                        width: 3,
                        color: const Color.fromARGB(255, 93, 156, 97)),
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  children: [
                    WebViewStack(
                      controller: controller,
                    ),
                  ],
                ))
            : Container(
                height: 80,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 10,
                ),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 184, 207, 230),
                    border: Border.all(
                        width: 3,
                        color: const Color.fromARGB(255, 93, 156, 97)),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("")),
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(10, 40)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 108, 170, 222)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ))),
                onPressed: () {
                  addadressViewmodel.editValue == true
                      ? addadressViewmodel.edititemAddressBook(
                          ctx: context,
                          addressLine1: AddressLine1Controller.text,
                          addressType: addressTypeController.text,
                          city: cityController.text,
                          country: countrycodeController.text,
                          postalCode: postboxController.text,
                          selectedAdress: selectedAddressController.text,
                          addressLine2: AddressLine2Controller.text,
                          apartmentNo: apartmentController.text,
                          postbox: postboxController.text,
                          streetName: selectedAdressNameController.text,
                          streetAddressNo: selectedAdressNoController.text,
                          countryCode: countrycodeController.text,
                          county: countyController.text,
                          zipCode: zipcodeController.text,
                          timeZone: timezoneController.text,
                          fromDate: fromDateController.text,
                          toDate: toDateController.text,
                          state: stateController.text)
                      : addadressViewmodel.additemToAddressBook(
                          ctx: context,
                          addressLine1: AddressLine1Controller.text,
                          addressType: addressTypeController.text,
                          city: cityController.text,
                          country: countrycodeController.text,
                          postalCode: postboxController.text,
                          selectedAdress: selectedAddressController.text,
                          addressLine2: AddressLine2Controller.text,
                          apartmentNo: apartmentController.text,
                          postbox: postboxController.text,
                          streetName: selectedAdressNameController.text,
                          streetAddressNo: selectedAdressNoController.text,
                          countryCode: countrycodeController.text,
                          county: countyController.text,
                          zipCode: zipcodeController.text,
                          timeZone: timezoneController.text,
                          fromDate: fromDateController.text,
                          toDate: toDateController.text,
                          state: stateController.text);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                )))
      ],
    );
  }

  Future<dynamic> customeBottomSheet(
      {required BuildContext context,
      Function? listileOntap1,
      required AddType addtypeMethod,
      Function? listileOntap2,
      Function? listileOntap3}) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 217, 228, 237)),
            child: Column(
              children: [
                Container(
                  color: Colors.green[900],
                  child: ListTile(
                    textColor: Colors.white,
                    title: Center(
                      child: Text(
                        addtypeMethod == AddType.addAddress
                            ? "Address Type"
                            : "Phone Type",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    onTap: () {
                      listileOntap1!();
                      Navigator.pop(context);
                    },
                    title: Center(
                      child: Text(addtypeMethod == AddType.addAddress
                          ? "Primary Address"
                          : "mobile phone typealterhone mobile phone typealterhone"),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 40,
                  child: ListTile(
                    dense: true,
                    onTap: () {
                      listileOntap2!();
                      Navigator.pop(context);
                    },
                    title: Center(
                      child: Text(addtypeMethod == AddType.addAddress
                          ? "Secondary Address"
                          : "Primary phone"),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                addtypeMethod == AddType.addPhone
                    ? SizedBox(
                        height: 40,
                        child: ListTile(
                          dense: true,
                          onTap: () {
                            listileOntap3!();
                            Navigator.pop(context);
                          },
                          title: const Center(child: Text("Secondary phone")),
                        ),
                      )
                    : const SizedBox(),
                addtypeMethod == AddType.addPhone
                    ? const Divider(
                        thickness: 1,
                      )
                    : const SizedBox()
              ],
            ),
          );
        });
  }
}
