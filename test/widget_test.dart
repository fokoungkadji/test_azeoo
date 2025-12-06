import 'package:flutter_test/flutter_test.dart';

import 'package:azeoo_profile_sdk/azeoo_profile_sdk.dart';

void main() {
  group('AzeooProfileSdk', () {
    test('should not be initialized by default', () {
      expect(AzeooProfileSdk.isInitialized, isFalse);
    });
  });
}
