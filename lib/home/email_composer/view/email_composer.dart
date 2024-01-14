import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:phone_book/home/email_composer/view/confirmation_widget.dart';
import 'package:phone_book/home/email_composer/view/html_editor_email.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailComposer extends StatefulWidget {
  const EmailComposer({super.key});

  @override
  State<EmailComposer> createState() => _EmailComposserState();
}

class _EmailComposserState extends State<EmailComposer> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final subjectController = TextEditingController();
  late HtmlEditorController htmlEditorController = HtmlEditorController();
  late final WebViewController webViewController;
  bool? changeEditor;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    changeEditor = false;
    webViewController = WebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                      minimumSize:
                          MaterialStateProperty.all(const Size(10, 40)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green[900]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ))),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var txt = await htmlEditorController.getText();
                      if (txt.isNotEmpty) {
                        webViewController.loadHtmlString("""<!doctype html>
                        <html><head><meta name="viewport" content="width=device-width,
                        initial-scale=1.0"></head> <body style='"margin: 0; padding: 0;
                       '><div> $txt </div> </body> </html>""");
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              scrollable: true,
                              contentPadding: EdgeInsets.zero,
                              insetPadding: const EdgeInsets.all(10),
                              content: ConfirmationWidget(
                                from: fromController.text,
                                subject: subjectController.text,
                                to: toController.text,
                                htmlController: webViewController,
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Sent",
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
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "";
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return '';
                      }
                      return null;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      errorStyle:
                          TextStyle(height: 0, color: Colors.transparent),
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
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "";
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return '';
                      }
                      return null;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      errorStyle:
                          TextStyle(height: 0, color: Colors.transparent),
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
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "";
                      }
                      return null;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      errorStyle:
                          TextStyle(height: 0, color: Colors.transparent),
                      contentPadding: EdgeInsets.only(left: 10.0),
                      hintText: "",
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      border: UnderlineInputBorder()),
                  controller: subjectController,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            // ListTile(
            //     onTap: () {
            //       setState(() {
            //         changeEditor = !changeEditor!;
            //       });
            //     },
            //     titleAlignment: ListTileTitleAlignment.center,
            //     trailing: ElevatedButton.icon(
            //       style: ButtonStyle(
            //           minimumSize:
            //               MaterialStateProperty.all(const Size(10, 40)),
            //           backgroundColor: MaterialStateProperty.all(
            //               const Color.fromARGB(255, 108, 170, 222)),
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(7.0),
            //           ))),
            //       onPressed: null,
            //       label: Text(
            //         !changeEditor! ? 'Hide Toolbar' : 'Show Toolbar',
            //         style: const TextStyle(
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //             fontSize: 15),
            //       ),
            //       icon: Icon(
            //         changeEditor! ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            //         color: Colors.white,
            //       ),
            //     )),
            HTMLeditoEmail(
              controller: htmlEditorController,
              type: changeEditor == false
                  ? ToolbarType.nativeGrid
                  : ToolbarType.hideToolBar,
            )
          ],
        )),
      ),
    );
  }
}
