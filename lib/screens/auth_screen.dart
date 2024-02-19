import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:phone_email/utils/app_constants.dart';
import 'package:phone_email/utils/app_services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey webViewKey = GlobalKey();

  /// InAppWebView Controller
  InAppWebViewController? webViewController;

  /// Initial Authentication URL
  late String authenticationUrl;

  /// Unique device token
  String? deviceId;

  @override
  void initState() {
    super.initState();
  }

  Future<void> inAppWebViewConfiguration(
      InAppWebViewController controller) async {
    /// Get Unique device token
    deviceId = await AppService.getDeviceId();

    /// Build authentication url with registered details
    authenticationUrl = "https://auth.phone.email/sign-in?" +
        "countrycode=${AppConstants.PHONE_COUNTRY}" +
        "&phone_no=${AppConstants.PHONE_NUMBER}" +
        "&auth_type=${AppConstants.AUTH_TYPE}" +
        "&device=$deviceId";

    print('Authentication URL: $authenticationUrl');

    /// Load authentication url in WebView
    webViewController!.loadUrl(
      urlRequest: URLRequest(url: WebUri(authenticationUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign in with phone',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: BackButton(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 4, 201, 135),
      ),
      body: InAppWebView(
        key: webViewKey,
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          mediaPlaybackRequiresUserGesture: false,
          cacheEnabled: true,
          allowsInlineMediaPlayback: true,
        ),
        onWebViewCreated: (controller) async {
          /// set webview controller
          webViewController = controller;

          /*
          * Call configuration method and build auth URL
          * */
          inAppWebViewConfiguration(controller);
        },
        onLoadStart: (controller, url) {
          /// callback method for listen response
          webViewController!.addJavaScriptHandler(
            handlerName: 'jwtHandler',
            callback: (arguments) {
              /// Get JWT token from JS and pop back to main screen
              Navigator.pop(context,{
                'jwtToken': arguments.first,
              },);
            },
          );
        },
        onReceivedError: (controller, request, error) {
          print("Error ============>>>>>${error.description}");
        },
      ),
    );
  }
}
