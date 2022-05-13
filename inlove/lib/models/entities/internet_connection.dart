import 'dart:io';

class InternetConnection {
  late final bool status;
  late final String localHost;

  InternetConnection() {
    localHost = getPlatformLocalhost();
    checkForInternetConnection();
  }

  checkForInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = true;
      } else {
        status = false;
      }
    } on SocketException catch (_) {
      status = false;
    }
  }

  static String getPlatformLocalhost() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3001';
    } else {
      return 'http://localhost:3001';
    }
  }
}
