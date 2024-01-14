import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget(
      {super.key,
      required this.from,
      required this.to,
      required this.subject,
      required this.htmlController});
  final String from;
  final String to;
  final String subject;
  final WebViewController htmlController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: 610,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          textFieldCoustome(text: 'From:', value: from),
          textFieldCoustome(text: 'To:', value: to),
          textFieldCoustome(text: 'Subject:', value: subject),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebViewWidget(
               
                controller: htmlController,
              ),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(10, 40)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 108, 170, 222)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Close",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15),
              )),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  SizedBox textFieldCoustome({required String text, required String value}) {
    return SizedBox(
      height: 40,
      child: ListTile(
        leading: SizedBox(
          width: 70,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        title: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}
