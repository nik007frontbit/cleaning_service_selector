import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key, required this.url, required this.title, this.isAppbarVisible = true})
      : super(key: key);
  final String url;
  final String title;
  final bool isAppbarVisible;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  bool isLoading = true;

  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    //if (Platform.isAndroid) WebView.platform = AndroidWebView();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          if (request.url.startsWith("https")) {
            return NavigationDecision.navigate;
          } else {
            _launchURL(Uri.parse(request.url));
            return NavigationDecision.prevent;
          }
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
      ));
    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppbarVisible
          ? AppBar(
              title: Text(widget.title),
            )
          : null,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  _launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {}
  }
}
