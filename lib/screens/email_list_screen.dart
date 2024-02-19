
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:phone_email/utils/app_constants.dart';

class EmailListScreen extends StatefulWidget {
  const EmailListScreen({super.key});

  @override
  State<EmailListScreen> createState() => _EmailListScreenState();
}

class _EmailListScreenState extends State<EmailListScreen> {
  InAppWebViewController? emailWebViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Email List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: BackButton(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 4, 201, 135),
      ),
      body: InAppWebView(
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          mediaPlaybackRequiresUserGesture: false,
          cacheEnabled: true,
          allowsInlineMediaPlayback: true,
        ),
        onWebViewCreated: (controller) async {
          /// set webview controller
          emailWebViewController = controller;
          emailWebViewController!.loadUrl(
              urlRequest: URLRequest(url: WebUri(AppConstants.EMAIL_LIST_URL)));
        },
      ),
    );
  }
}
