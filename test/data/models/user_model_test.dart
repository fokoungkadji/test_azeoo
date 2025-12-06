import 'package:azeoo_profile_sdk/src/data/models/user_model.dart';
import 'package:azeoo_profile_sdk/src/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('UserModel', () {
    group('fromJson', () {
      test('should create UserModel from valid JSON', () {
        // Act
        final result = UserModel.fromJson(TestData.testUserJson);

        // Assert
        expect(result.id, 1);
        expect(result.firstName, 'John');
        expect(result.lastName, 'Doe');
        expect(result.email, 'john.doe@example.com');
        expect(result.picture.length, 1);
        expect(result.picture.first.label, 'small');
      });

      test('should handle missing optional fields', () {
        // Arrange
        final json = {
          'id': 1,
          'first_name': 'John',
          'last_name': 'Doe',
        };

        // Act
        final result = UserModel.fromJson(json);

        // Assert
        expect(result.id, 1);
        expect(result.firstName, 'John');
        expect(result.lastName, 'Doe');
        expect(result.email, isNull);
        expect(result.picture, isEmpty);
      });

      test('should handle empty picture array', () {
        // Arrange
        final json = {
          'id': 1,
          'first_name': 'John',
          'last_name': 'Doe',
          'picture': <Map<String, dynamic>>[],
        };

        // Act
        final result = UserModel.fromJson(json);

        // Assert
        expect(result.picture, isEmpty);
        expect(result.avatarUrl, isNull);
      });
    });

    group('toJson', () {
      test('should convert UserModel to JSON', () {
        // Act
        final json = TestData.testUserModel.toJson();

        // Assert
        expect(json['id'], 1);
        expect(json['first_name'], 'John');
        expect(json['last_name'], 'Doe');
        expect(json['email'], 'john.doe@example.com');
      });
    });

    group('avatarUrl', () {
      test('should return small picture URL when available', () {
        // Arrange
        const model = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          picture: [
            PictureModel(url: 'https://example.com/large.jpg', label: 'large'),
            PictureModel(url: 'https://example.com/small.jpg', label: 'small'),
          ],
        );

        // Assert
        expect(model.avatarUrl, 'https://example.com/small.jpg');
      });

      test('should return thumbnail URL when small is not available', () {
        // Arrange
        const model = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          picture: [
            PictureModel(url: 'https://example.com/large.jpg', label: 'large'),
            PictureModel(url: 'https://example.com/thumb.jpg', label: 'thumbnail'),
          ],
        );

        // Assert
        expect(model.avatarUrl, 'https://example.com/thumb.jpg');
      });

      test('should return first picture URL as fallback', () {
        // Arrange
        const model = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          picture: [
            PictureModel(url: 'https://example.com/large.jpg', label: 'large'),
          ],
        );

        // Assert
        expect(model.avatarUrl, 'https://example.com/large.jpg');
      });

      test('should return null when no pictures', () {
        // Arrange
        const model = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
        );

        // Assert
        expect(model.avatarUrl, isNull);
      });
    });

    group('toEntity', () {
      test('should convert UserModel to User entity', () {
        // Act
        final user = TestData.testUserModel.toEntity();

        // Assert
        expect(user, isA<User>());
        expect(user.id, '1');
        expect(user.firstName, 'John');
        expect(user.lastName, 'Doe');
        expect(user.email, 'john.doe@example.com');
        expect(user.avatarUrl, 'https://example.com/avatar.jpg');
      });

      test('should convert id to string', () {
        // Arrange
        const model = UserModel(
          id: 123,
          firstName: 'Test',
          lastName: 'User',
        );

        // Act
        final user = model.toEntity();

        // Assert
        expect(user.id, '123');
      });
    });
  });

  group('PictureModel', () {
    test('should create from JSON', () {
      // Arrange
      final json = {
        'url': 'https://example.com/pic.jpg',
        'label': 'small',
      };

      // Act
      final result = PictureModel.fromJson(json);

      // Assert
      expect(result.url, 'https://example.com/pic.jpg');
      expect(result.label, 'small');
    });
  });

  group('User entity', () {
    test('should have correct fullName', () {
      expect(TestData.testUser.fullName, 'John Doe');
    });

    test('should have correct initials', () {
      expect(TestData.testUser.initials, 'JD');
    });

    test('should handle empty firstName for initials', () {
      const user = User(
        id: '1',
        firstName: '',
        lastName: 'Doe',
      );
      expect(user.initials, 'D');
    });

    test('should handle empty lastName for initials', () {
      const user = User(
        id: '1',
        firstName: 'John',
        lastName: '',
      );
      expect(user.initials, 'J');
    });
  });
}
