
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({
    required this.controller,
    super.key,
  });

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
          onPressed: () async {
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {}
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.replay,
            size: 18,
          ),
          onPressed: () {
            controller.reload();
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
          onPressed: () async {
            if (await controller.canGoForward()) {
              await controller.goForward();
            } else {
              return;
            }
          },
        ),
      ],
    );
  }
}
