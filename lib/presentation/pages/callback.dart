import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class CallbackPage extends StatefulWidget {
  const CallbackPage({super.key});

  @override
  State<CallbackPage> createState() => _CallbackPageState();
}

class _CallbackPageState extends State<CallbackPage> {
  @override
  void initState() {
    super.initState();
    _initUniLinks();
  }

  Future<void> _initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        handleLink(Uri.parse(initialLink));
      }
      // Handle the initial link if the app was opened from the callback URL

      // Listen for incoming links while the app is running
      linkStream.listen((link) {
        //Extracting data from callback URLs
        if (initialLink != null) {
          handleLink(Uri.parse(link!));
        }
      });
    } on FormatException {
      // Handle invalid URLs
    } on PlatformException {
      // Handle exception if UniLinks is not supported on the platform
    }
  }

  void handleLink(Uri uri) {
    // Extract information from the callback URL (e.g., authentication token)
    print(uri.queryParameters);

    // Handle the authentication token and update the UI as needed
    // context.goNamed(loginRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Center(
        child: Text("CallBack Page"),
      ),
    );
  }
}
