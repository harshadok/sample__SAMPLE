import 'package:flutter/material.dart';
import 'package:phone_book/home/web_view/html_editor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp(
      {super.key,
      required this.controller,
      required this.onSubmit,
      required this.webViewText});
  final WebViewController controller;
  final Function(String) onSubmit;
  final String webViewText;
  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late bool changeContiner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )),
        title: const Text(
          '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
               // margin: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                child: HtmlEditorExample(
                  ontapSubmit: (text) async {
                    await widget.onSubmit(text);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                  webViewText: widget.webViewText,
                  title: '',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
