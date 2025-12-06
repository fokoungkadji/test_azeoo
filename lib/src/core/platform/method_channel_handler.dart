import 'package:flutter/services.dart';

class MethodChannelHandler {
  MethodChannelHandler._();

  static const String _channelName = 'com.azeoo.profile_sdk/channel';
  static const MethodChannel _channel = MethodChannel(_channelName);

  static Function(String userId)? _onUserIdUpdated;

  static void initialize({Function(String userId)? onUserIdUpdated}) {
    _onUserIdUpdated = onUserIdUpdated;
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'updateUserId':
        final userId = call.arguments as String?;
        if (userId != null && _onUserIdUpdated != null) {
          _onUserIdUpdated!(userId);
        }
        return true;
      default:
        throw PlatformException(
          code: 'NOT_IMPLEMENTED',
          message: 'Method ${call.method} not implemented',
        );
    }
  }

  static Future<String?> getInitialUserId() async {
    try {
      final result = await _channel.invokeMethod<String>('getInitialUserId');
      return result;
    } on PlatformException {
      return null;
    }
  }

  static void dispose() {
    _onUserIdUpdated = null;
  }
}
