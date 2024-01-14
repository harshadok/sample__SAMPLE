import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HTMLeditoEmail extends StatelessWidget {
  const HTMLeditoEmail({Key? key, required this.controller, required this.type})
      : super(key: key);
  final HtmlEditorController controller;
  final ToolbarType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: HtmlEditor(
        controller: controller,
        htmlEditorOptions: const HtmlEditorOptions(
          autoAdjustHeight: true,
        ),
        htmlToolbarOptions: HtmlToolbarOptions(
          toolbarPosition: ToolbarPosition.aboveEditor,
          toolbarType: type,
          toolbarItemHeight: 30,
        ),
        otherOptions: OtherOptions(
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
          height: 800,
        ),
      ),
    );
  }
}
