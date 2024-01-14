// ignore: file_names

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorExample extends StatefulWidget {
  const HtmlEditorExample({
    Key? key,
    required this.webViewText,
  }) : super(key: key);
  final String webViewText;
  @override
  HtmlEditorExampleState createState() => HtmlEditorExampleState();
}

class HtmlEditorExampleState extends State<HtmlEditorExample> {
  late HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var txt = await controller.getText();
          if (txt.isNotEmpty) {
            if (context.mounted) Navigator.of(context).pop(txt);
          }
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        backgroundColor: Colors.green[900],
        child: const Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, widget.webViewText);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 18,
            )),
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        children: [
          Expanded(
              child: HtmlEditor(
            controller: controller,
            htmlEditorOptions: HtmlEditorOptions(
              hint: 'Your text here...',
              autoAdjustHeight: true,
              initialText: widget.webViewText,
            ),
            htmlToolbarOptions: HtmlToolbarOptions(
              toolbarPosition: ToolbarPosition.aboveEditor,
              toolbarType: ToolbarType.nativeGrid,
              toolbarItemHeight: 30,
              onButtonPressed:
                  (ButtonType type, bool? status, Function? updateStatus) {
                return true;
              },
              onDropdownChanged: (DropdownType type, dynamic changed,
                  Function(dynamic)? updateSelectedItem) {
                return true;
              },
              mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                return true;
              },
              mediaUploadInterceptor:
                  (PlatformFile file, InsertFileType type) async {
                return true;
              },
            ),
            otherOptions: OtherOptions(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromARGB(255, 196, 194, 194)),
                  borderRadius: BorderRadius.circular(10)),
              height: 800,
            ),
          )),
        ],
      ),
    );
  }
}
