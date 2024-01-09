import 'package:flutter/material.dart';
import 'package:phone_book/home/add_item/model/address_model.dart';
import 'package:phone_book/home/add_item/model/phone_book_model.dart';
import 'package:phone_book/home/add_item/view/add_item_screen.dart';
import 'package:phone_book/home/add_item/view_model/add_address_viewmodel.dart';
import 'package:provider/provider.dart';

enum ContactType {
  addressBook,
  phoneBook,
}

class LounchPage extends StatefulWidget {
  const LounchPage({super.key, required this.currentContactType});
  final ContactType currentContactType;
  @override
  State<LounchPage> createState() => _LounchPageState();
}

class _LounchPageState extends State<LounchPage> {
  @override
  Widget build(BuildContext context) {
    final addadressViewmodel = context.watch<AddaddressViewModel>();
    return Scaffold(
      backgroundColor: Colors.blue[50],
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        backgroundColor: Colors.green[900],
        onPressed: () {
          widget.currentContactType == ContactType.addressBook
              ? addadressViewmodel.clearAddress()
              : addadressViewmodel.clearPhoneBook();
          widget.currentContactType == ContactType.addressBook
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const AddItemScreen(
                      addType: AddType.addAddress,
                    ),
                  ),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const AddItemScreen(
                      addType: AddType.addPhone,
                    ),
                  ),
                );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
          ),
        ),
        title: Text(
          widget.currentContactType == ContactType.addressBook
              ? "Address Book"
              : "Phone Book",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 8 / 10,
              child: widget.currentContactType == ContactType.addressBook &&
                      addadressViewmodel.addressBook.isEmpty
                  ? const Center(
                      child: Text("No address found"),
                    )
                  : widget.currentContactType == ContactType.phoneBook &&
                          addadressViewmodel.phoneBook.isEmpty
                      ? const Center(
                          child: Text("No number found"),
                        )
                      : ListView.builder(
                          itemCount: widget.currentContactType ==
                                  ContactType.addressBook
                              ? addadressViewmodel.addressBook.length
                              : addadressViewmodel.phoneBook.length,
                          itemBuilder: (BuildContext ctx, index) {
                            late final PhoneBookModel? phoneitem;
                            late final Address? addressitem;
                            if (widget.currentContactType ==
                                ContactType.addressBook) {
                              addressitem =
                                  addadressViewmodel.addressBook[index];
                            } else {
                              phoneitem = addadressViewmodel.phoneBook[index];
                            }
                            return widget.currentContactType ==
                                    ContactType.addressBook
                                ? AddressBuilder(
                                    item: addressitem!,
                                    ontapDelete: () {
                                      addadressViewmodel
                                          .removeitemFromList(index);
                                    },
                                    onPressed: () {
                                      addadressViewmodel
                                          .assignValuetoToAddressEditFeild(
                                              item: addressitem!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddItemScreen(
                                            addType: AddType.addAddress,
                                            addressItem: addressitem,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : PhoneBuilder(
                                    item: phoneitem!,
                                    onpressDelete: () {
                                      addadressViewmodel
                                          .removeitemFromPhoneBookList(index);
                                    },
                                    setasPreffredFunction: () {
                                      addadressViewmodel.removepreffred();
                                      addadressViewmodel
                                          .selectedSetAsPrefferd(phoneitem!);
                                    },
                                    onpressEdit: () {
                                      addadressViewmodel
                                          .assignValuePhoneEditFeild(
                                              item: phoneitem!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddItemScreen(
                                            addType: AddType.addPhone,
                                            phoneBookModel: phoneitem,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}

class PhoneBuilder extends StatelessWidget {
  const PhoneBuilder(
      {super.key,
      required this.item,
      required this.onpressEdit,
      required this.setasPreffredFunction,
      required this.onpressDelete});

  final PhoneBookModel item;
  final Function onpressEdit;
  final Function onpressDelete;
  final Function setasPreffredFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: Colors.blue[50],
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 160,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Card(
                        shape: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 101, 147, 103),
                          ),
                        ),
                        color: const Color.fromARGB(255, 101, 147, 103),
                        child: Text(
                          " ${item.phoneType} ",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                item.setAsPreffred != null
                    ? item.setAsPreffred == true
                        ? const SizedBox(
                            width: 80,
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.star_outlined,
                                  size: 15,
                                )),
                          )
                        : const SizedBox()
                    : const SizedBox(),
                // const SizedBox(
                //   width: 120,
                //   child: Align(
                //       alignment: Alignment.topRight,
                //       child: Icon(
                //         Icons.highlight_remove_sharp,
                //         size: 15,
                //         color: Colors.red,
                //       )),
                // ),
                const SizedBox(
                  width: 110,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Text(
                            " Not Verified ",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(
                            Icons.highlight_remove_sharp,
                            size: 15,
                            color: Colors.red,
                          )
                        ],
                      )),
                ),
                SizedBox(
                  width: 30,
                  child: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            setasPreffredFunction();
                            final snackBar = SnackBar(
                              backgroundColor: Colors.white,
                              content: RichText(
                                text: TextSpan(
                                    text: '${item.phoneNumber}',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: const [
                                      TextSpan(
                                          text: " set as preferred",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ]),
                              ),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          value: '/preferred',
                          child: const Text("Set As Preferred"),
                        ),
                        PopupMenuItem(
                          value: '/edit',
                          onTap: () {
                            onpressEdit();
                          },
                          child: const Text("Edit"),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            onpressDelete();
                          },
                          value: '/delete',
                          child: const Text("Delete"),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                // const number = '09656234154';
                //await launch('tel:${8888888888}')
                   // .then((value) => print(value)); //set the number here
              },
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    Image.network(errorBuilder: (
                      context,
                      object,
                      _,
                    ) {
                      return const SizedBox();
                    }, "https://flagcdn.com/48x36/${item.flagCode!.toLowerCase()}.png"),
                    Text(
                      " ${item.countryCode} ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      item.phoneNumber!,
                      style: TextStyle(color: Colors.blue[900], fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressBuilder extends StatelessWidget {
  const AddressBuilder(
      {super.key,
      required this.item,
      required this.ontapDelete,
      required this.onPressed});
  final Function() onPressed;
  final Function() ontapDelete;
  final Address item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        color: Colors.blue[50],
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Card(
                        shape: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 101, 147, 103),
                          ),
                        ),
                        color: const Color.fromARGB(255, 101, 147, 103),
                        child: Text(
                          " ${item.addressType} ",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton(
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          value: '/edit',
                          onTap: () {
                            onPressed();
                          },
                          child: const Text("Edit"),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Confirmation'),
                                content: const Text(
                                    'Are you sure you want to delete?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'OK');
                                      ontapDelete();
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          value: '/delete',
                          child: const Text("Delete"),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 93 / 10,
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: Text(
                  "${item.addressLine1}, ${item.addressLine2}, ${item.postbox}, ${item.apartmentNo}, ${item.streetAddressNo}, ${item.streetName}, ${item.state}, ${item.county}, ${item.city}, ${item.country}, ${item.zipCode}"),
            ),
          ],
        ),
      ),
    );
  }
}
