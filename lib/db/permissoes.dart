import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissoes {
  // ignore: missing_return
  static Future<bool> requestePermissionCell() async {
    PermissionStatus permission = await _getMicrofonePermission();
    if (permission != PermissionStatus.granted) {
      await Permission.microphone.request();
      PermissionStatus permissions = await Permission.microphone.status;
      if (permissions == PermissionStatus.granted) {
        return true;
      } else {
        _handleInvalidPermissions(permission);
        return false;
      }
    }
  }

  static Future<PermissionStatus> _getMicrofonePermission() async {
    PermissionStatus permission = await Permission.camera.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      var permissionStatus = await Permission.microphone.request();

      return permissionStatus ?? Permission.microphone ?? Permission.unknown;
    } else {
      return permission;
    }
  }

  static void _handleInvalidPermissions(
    PermissionStatus cameraPermissionStatus,
  ) {
    if (cameraPermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to camera and microphone denied",
          details: null);
    } else if (cameraPermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
}


/*try {
      PermissionStatus permission = await Permission.microphone.status;
      if (permission != PermissionStatus.granted) {
        await Permission.microphone.request();
        PermissionStatus permission = await Permission.microphone.status;
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {}*/