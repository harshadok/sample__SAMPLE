import 'package:flutter/material.dart';
import 'package:phone_book/home/web_view/web_view/naviagtion_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewFullScreen extends StatefulWidget {
  const WebViewFullScreen({
    super.key,
    required this.webViewURL,
  });
  final String webViewURL;
  @override
  State<WebViewFullScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WebViewFullScreen> {
  late final WebViewController controllerNew;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controllerNew = WebViewController()
      ..loadRequest(
        Uri.parse(widget.webViewURL),
      )
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          if (mounted) {
            setState(() {
              loadingPercentage = 0;
            });
          }
        },
        onProgress: (progress) {
          if (mounted) {
            setState(() {
              loadingPercentage = progress;
            });
          }
        },
        onPageFinished: (url) {
          if (mounted) {
            setState(() {
              loadingPercentage = 100;
            });
          }
        },
      ));
  }

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
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: WebViewWidget(
              controller: controllerNew,
            ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  color: Colors.green[100],
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: NavigationControls(
                    controller: controllerNew,
                  ),
                ),
                if (loadingPercentage < 100)
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end: loadingPercentage / 100.0,
                    ),
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      color: Colors.blue,
                      minHeight: 5,
                    ),
                  ),
                // LinearProgressIndicator(
                //   color: Colors.blue,
                //   minHeight: 10,
                //   value: loadingPercentage / 100.0,
                // ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
