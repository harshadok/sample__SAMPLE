import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:phone_book/home/email_composer/view/confirmation_widget.dart';
import 'package:phone_book/home/email_composer/view/html_editor_email.dart';

class EmailComposer extends StatefulWidget {
  const EmailComposer({super.key});

  @override
  State<EmailComposer> createState() => _EmailComposserState();
}

class _EmailComposserState extends State<EmailComposer> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final subjectController = TextEditingController();
  late HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(10, 40)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green[900]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ))),
                onPressed: () async {
                  var txt = await controller.getText();
                  if (txt.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.all(10),
                          content: ConfirmationWidget(
                            from: fromController.text,
                            subject: subjectController.text,
                            to: toController.text,
                            htmlString: txt,
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                )),
          )
        ],
        title: const Text(
          "Email Composer",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: 40,
            child: ListTile(
              leading: const SizedBox(
                width: 70,
                child: Text(
                  "From:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              title: TextFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    hintText: "",
                    hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    border: UnderlineInputBorder()),
                controller: fromController,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.only(top: 10),
                width: 70,
                child: const Text(
                  "To:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              title: TextFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    hintText: "",
                    hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    border: UnderlineInputBorder()),
                controller: toController,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.only(top: 10),
                width: 70,
                child: const Text(
                  "Subject:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              title: TextFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    hintText: "",
                    hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    border: UnderlineInputBorder()),
                controller: subjectController,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          HTMLeditoEmail(
            disbled: false,
            controller: controller,
          )
        ],
      )),
    );
  }
}
