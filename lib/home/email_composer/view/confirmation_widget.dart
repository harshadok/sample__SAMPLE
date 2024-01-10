import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConfirmationWidget extends StatefulWidget {
  const ConfirmationWidget(
      {super.key,
      required this.from,
      required this.to,
      required this.subject,
      required this.htmlString});
  final String from;
  final String to;
  final String subject;
  final String htmlString;

  @override
  State<ConfirmationWidget> createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  late final WebViewController controllerNew;
  @override
  void initState() {
    super.initState();
    controllerNew = WebViewController()..loadHtmlString("""<!doctype html>
     <html><head><meta name="viewport" content="width=device-width,
     initial-scale=1.0"></head> <body style='"margin: 0; padding: 0;
     '><div> ${widget.htmlString} </div> </body> </html>""");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: 610,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          textFieldCoustome(text: 'From:', value: widget.from),
          textFieldCoustome(text: 'To:', value: widget.to),
          textFieldCoustome(text: 'Subject:', value: widget.subject),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebViewWidget(
                controller: controllerNew,
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const DashboardScreen()),
                // );
              },
              child: const Text(
                "Save",
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
        title: TextFormField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 10.0),
              hintText: value,
              hintStyle: const TextStyle(fontSize: 17, color: Colors.black),
              border: const UnderlineInputBorder()),
        ),
      ),
    );
  }
}
