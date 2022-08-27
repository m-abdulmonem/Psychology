import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PredictionBody extends StatefulWidget {
  const PredictionBody({Key? key}) : super(key: key);

  @override
  State<PredictionBody> createState() => _PredictionBodyState();
}

class _PredictionBodyState extends State<PredictionBody> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return  WebView(
      initialUrl: 'https://colab.research.google.com/drive/1TpRv5VeJWaLyq48tWTRizr8LibH0CiYa?usp=sharing',
      zoomEnabled: true,
      debuggingEnabled: true,
      gestureNavigationEnabled: true,
      allowsInlineMediaPlayback: true,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (String a){
        print(a);
      },
      onProgress: (int i) {
        print(i);
        },
    );
  }
}
