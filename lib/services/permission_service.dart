import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestPhonePermissions() async {
    await [
      Permission.phone,
      Permission.microphone,
    ].request();
  }
}
