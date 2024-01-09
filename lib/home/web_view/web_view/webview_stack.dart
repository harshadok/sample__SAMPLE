// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:phone_book/home/web_view/web_view/web_view_full_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({
    super.key,
    required this.htmlString,
  });
  final ValueNotifier htmlString;
  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  bool? host;
  late final WebViewController controllerWebViewStack;
  var loadingPercentage = 0;

  htmlStringSizeToMobaile(webViewText) {
    return """<!doctype html>
     <html><head><meta name="viewport" content="width=device-width,
     initial-scale=1.0"></head> <body style='"margin: 0; padding: 0;
     '><div> $webViewText </div> </body> </html>""";
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      controllerWebViewStack = WebViewController()
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (request) {
              final host = Uri.parse(request.url).hasAbsolutePath;
              if (host) {
                debugPrint('allowing navigation to ${request.url}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewFullScreen(
                            webViewURL: request.url,
                          )),
                );
                return NavigationDecision.prevent;
              }
              debugPrint('not allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            // onNavigationRequest: (request) {
            //   final host = Uri.parse(request.url).hasAbsolutePath;
            //   if (host) {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => WebViewFullScreen(
            //                  webViewURL: request.url,
            //               )),
            //     );
            //   }
            //   return NavigationDecision.prevent;
            // },
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: widget.htmlString,
        builder: (context, value, child) {
          controllerWebViewStack
              .loadHtmlString(htmlStringSizeToMobaile(widget.htmlString.value));
          return WebViewWidget(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                Factory<VerticalDragGestureRecognizer>(
                  () {
                    return VerticalDragGestureRecognizer();
                  },
                ), // or null
              ),
            controller: controllerWebViewStack,
          );
        },
      ),
    );
  }
}
