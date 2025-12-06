import 'package:azeoo_profile_sdk/src/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failures', () {
    group('ServerFailure', () {
      test('should have correct message', () {
        const failure = ServerFailure(message: 'Server error', statusCode: 500);
        expect(failure.message, 'Server error');
        expect(failure.statusCode, 500);
      });

      test('should return default message on toString when message is null', () {
        const failure = ServerFailure();
        expect(failure.toString(), contains('erreur serveur'));
      });

      test('should return custom message on toString', () {
        const failure = ServerFailure(message: 'Custom error');
        expect(failure.toString(), 'Custom error');
      });

      test('should be equatable', () {
        const failure1 = ServerFailure(message: 'Error', statusCode: 500);
        const failure2 = ServerFailure(message: 'Error', statusCode: 500);
        expect(failure1, equals(failure2));
      });
    });

    group('NetworkFailure', () {
      test('should have correct message', () {
        const failure = NetworkFailure(message: 'No connection');
        expect(failure.message, 'No connection');
      });

      test('should return default message on toString when message is null', () {
        const failure = NetworkFailure();
        expect(failure.toString(), contains('connexion'));
      });
    });

    group('UnauthorizedFailure', () {
      test('should have correct message', () {
        const failure = UnauthorizedFailure(message: 'Unauthorized');
        expect(failure.message, 'Unauthorized');
      });

      test('should return default message on toString when message is null', () {
        const failure = UnauthorizedFailure();
        expect(failure.toString(), contains('Session'));
      });
    });

    group('NotFoundFailure', () {
      test('should have correct message', () {
        const failure = NotFoundFailure(message: 'User not found');
        expect(failure.message, 'User not found');
      });

      test('should return default message on toString when message is null', () {
        const failure = NotFoundFailure();
        expect(failure.toString(), contains('non trouvé'));
      });
    });

    group('CacheFailure', () {
      test('should have correct message', () {
        const failure = CacheFailure(message: 'Cache error');
        expect(failure.message, 'Cache error');
      });

      test('should return default message on toString when message is null', () {
        const failure = CacheFailure();
        expect(failure.toString(), contains('cache'));
      });
    });

    group('UnexpectedFailure', () {
      test('should have correct message', () {
        const failure = UnexpectedFailure(message: 'Unexpected error');
        expect(failure.message, 'Unexpected error');
      });

      test('should return default message on toString when message is null', () {
        const failure = UnexpectedFailure();
        expect(failure.toString(), contains('inattendue'));
      });
    });
  });
}
