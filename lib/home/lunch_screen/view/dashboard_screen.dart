import 'package:flutter/material.dart';
import 'package:phone_book/home/add_item/view_model/add_address_viewmodel.dart';
import 'package:phone_book/home/email_composer/view/email_composer.dart';
import 'package:phone_book/home/lunch_screen/view/lunch_page.dart';
import 'package:provider/provider.dart';

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({super.key});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddaddressViewModel>(
      create: (context) => AddaddressViewModel(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: DashboardScreen()),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[900],
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "3",
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            backgroundColor: Colors.green[900],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmailComposer()
                ),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: "1",
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            backgroundColor: Colors.green[900],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LounchPage(
                    currentContactType: ContactType.phoneBook,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.phone,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: "2",
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            backgroundColor: Colors.green[900],
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LounchPage(
                    currentContactType: ContactType.addressBook,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: const SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("click to add your contact"),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
