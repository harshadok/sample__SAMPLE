// ignore: file_names
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorExample extends StatefulWidget {
  const HtmlEditorExample(
      {Key? key,
      required this.title,
      required this.ontapSubmit,
      required this.webViewText})
      : super(key: key);

  final String title;
  final Function(String) ontapSubmit;
  final String webViewText;

  @override
  HtmlEditorExampleState createState() => HtmlEditorExampleState();
}

class HtmlEditorExampleState extends State<HtmlEditorExample> {
  String result = '';
  late HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    child: HtmlEditor(  
                  controller: controller,
                  htmlEditorOptions: const HtmlEditorOptions(
                    hint: 'Your text here...',
                    autoAdjustHeight: true,

                  ),
                  htmlToolbarOptions: HtmlToolbarOptions(
                    toolbarPosition: ToolbarPosition.aboveEditor,
                    toolbarType: ToolbarType.nativeGrid,
                    toolbarItemHeight: 40,
                    onButtonPressed: (ButtonType type, bool? status,
                        Function? updateStatus) {
                      return true;
                    },
                    onDropdownChanged: (DropdownType type, dynamic changed,
                        Function(dynamic)? updateSelectedItem) {
                      return true;
                    },
                    mediaLinkInsertInterceptor:
                        (String url, InsertFileType type) {
                      return true;
                    },
                    mediaUploadInterceptor:
                        (PlatformFile file, InsertFileType type) async {
                      return true;
                    },
                  ),
                  otherOptions: OtherOptions(
                      height: MediaQuery.of(context).size.height * 7.3 / 10),
                  callbacks: Callbacks(
                     onInit: () {
                      if (widget.webViewText != '') {
                        controller.insertHtml(widget.webViewText);
                      }
                    },
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(10, 40)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 108, 170, 222)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ))),
                        onPressed: () {
                          controller.undo();
                        },
                        child: const Text('Undo',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(10, 40)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 108, 170, 222)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ))),
                        onPressed: () {
                          controller.clear();
                        },
                        child: const Text('Reset',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(10, 40)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 108, 170, 222)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ))),
                        onPressed: () async {
                          var txt = await controller.getText();
                          if (txt.isNotEmpty) {
                            await widget.ontapSubmit(txt);
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(10, 40)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 108, 170, 222)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ))),
                        onPressed: () {
                          controller.redo();
                        },
                        child: const Text(
                          'Redo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(result),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
