import 'package:flutter/services.dart';

/// Gestionnaire du Method Channel pour la communication avec React Native
///
/// Permet de recevoir les mises à jour d'userId depuis l'application
/// React Native et de les transmettre au SDK.
class MethodChannelHandler {
  MethodChannelHandler._();

  static const String _channelName = 'com.azeoo.profile_sdk/channel';
  static const MethodChannel _channel = MethodChannel(_channelName);

  static Function(String userId)? _onUserIdUpdated;

  /// Initialise le handler du Method Channel
  ///
  /// [onUserIdUpdated] Callback appelé quand l'userId est mis à jour
  static void initialize({Function(String userId)? onUserIdUpdated}) {
    _onUserIdUpdated = onUserIdUpdated;
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  /// Gère les appels de méthode depuis le natif
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

  /// Récupère l'userId initial depuis le natif
  static Future<String?> getInitialUserId() async {
    try {
      final result = await _channel.invokeMethod<String>('getInitialUserId');
      return result;
    } on PlatformException {
      return null;
    }
  }

  /// Dispose le handler
  static void dispose() {
    _onUserIdUpdated = null;
  }
}
