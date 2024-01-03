import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key});

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller;
      // ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..addJavaScriptChannel(
      //   'SnackBar',
      //   onMessageReceived: (message) {
      //     ScaffoldMessenger.of(context)
      //         .showSnackBar(SnackBar(content: Text(message.message)));
      //   },
      // );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Center(
        child: WebViewWidget(
          controller: widget.controller,
        ),
      ),
    );
  }
}
