import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';

abstract class DynamioLinkProvider {
  Future<void> initUniLinks(BuildContext context);
}

class DynamioLinkProviderImpl implements DynamioLinkProvider {
  final String url = "https://com.crypto.portfolio.crypto_portfolio_test";
  final String domain = "crypto://cryptoportfoliotest";

  DynamioLinkProviderImpl();

  void handleLink(String link) {
    // final uri = Uri.parse(link);
    // final callbackData = uri.queryParameters['data'];
    //
    // setState(() {
    //   _callbackData = callbackData!;
    // });
    //
    // // Perform necessary actions or update the app's state based on the extracted data
    // // Example: Trigger a function or update UI elements
    // processCallbackData(callbackData!);
  }


  @override
  Future<void> initUniLinks(BuildContext context) async {
    try {
      final initialLink = await getInitialLink();
      handleLink(initialLink!);
      // Handle the initial link if the app was opened from the callback URL

      // Listen for incoming links while the app is running
      linkStream.listen((link) {
        //Extracting data from callback URLs
      });
    } on PlatformException {
      // Handle exception if UniLinks is not supported on the platform
    }
  }
}