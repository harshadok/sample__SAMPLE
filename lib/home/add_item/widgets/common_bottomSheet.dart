import 'package:flutter/material.dart';
import 'package:phone_book/home/add_item/model/country_model.dart';
import 'package:phone_book/home/add_item/widgets/custome_date_picker.dart';

Future<dynamic> commoneBottomSheet({
  required BuildContext context,
  required List itemlist,
  List? flagList,
  String? titile,
  required Function(String) onPressed,
  required Function(Country) selectedCountry,
}) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.green[900],
              child: ListTile(
                textColor: Colors.white,
                title: Center(
                    child: Text(
                  "$titile",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                )),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 217, 228, 237),
                child: ListView.separated(
                    separatorBuilder: (context, intex) {
                      return const Divider(
                        thickness: 2,
                      );
                    },
                    itemCount: itemlist.length,
                    itemBuilder: (context, intex) {
                      late final Country item;
                      if (titile == "Country Code") {
                        item = itemlist[intex];
                      }
                      return ListTile(
                        leading: titile == "Country Code"
                            ? Image.network(errorBuilder: (
                                context,
                                object,
                                _,
                              ) {
                                return const SizedBox();
                              },
                                "https://flagcdn.com/48x36/${item.code.toLowerCase()}.png")
                            : null,
                        dense: true,
                        onTap: () {
                          if ((titile != "Country Code")) {
                            onPressed(itemlist[intex]);
                          } else {
                            selectedCountry(item);
                          }
                          Navigator.pop(context);
                        },
                        title: titile == "Country Code"
                            ? Text(
                                "${item.name}(${item.phoneCode})",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )
                            : Center(
                                child: Text(
                                itemlist[intex].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                      );
                    }),
              ),
            ),
          ],
        );
      });
}

dateBottomSheet({
  required BuildContext context,
  String? titile,
}) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 800,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: const Color(0xFFE5F2FB),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFF1B5E20),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 4 / 10),
                      child: Center(
                        child: Text(
                          "$titile",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Scroll view",
                        style: TextStyle(
                            color: Color.fromRGBO(33, 150, 243, 1),
                            fontSize: 15),
                      )),
                ),
              ),
              Expanded(child: MyCalendar())
            ],
          ),
        );
      });
}
