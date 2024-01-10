import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HTMLeditoEmail extends StatefulWidget {
  const HTMLeditoEmail({
    Key? key,
    required this.disbled,
    required this.controller,
  }) : super(key: key);
  final bool disbled;
  final HtmlEditorController controller;
  @override
  HtmlEditorExampleState createState() => HtmlEditorExampleState();
}

class HtmlEditorExampleState extends State<HTMLeditoEmail> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540,
      child: Column(
        children: [
          Expanded(
              child: HtmlEditor(
            controller: widget.controller,
            htmlEditorOptions: HtmlEditorOptions(
              hint: 'Your text here...',
              disabled: widget.disbled,
              autoAdjustHeight: true,
              initialText: '',
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
            otherOptions: const OtherOptions(
              decoration: BoxDecoration(),
              height: 550,
            ),
          )),
        ],
      ),
    );
  }
}
