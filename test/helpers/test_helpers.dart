import 'package:azeoo_profile_sdk/src/core/cache/cache_manager.dart';
import 'package:azeoo_profile_sdk/src/data/datasources/user_local_datasource.dart';
import 'package:azeoo_profile_sdk/src/data/datasources/user_remote_datasource.dart';
import 'package:azeoo_profile_sdk/src/data/models/user_model.dart';
import 'package:azeoo_profile_sdk/src/domain/entities/user.dart';
import 'package:azeoo_profile_sdk/src/domain/repositories/user_repository.dart';
import 'package:azeoo_profile_sdk/src/domain/usecases/get_user_profile.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockUserRepository extends Mock implements UserRepository {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockCacheManager extends Mock implements CacheManager {}

class MockGetUserProfile extends Mock implements GetUserProfile {}

// Test Data
class TestData {
  static const String testUserId = '1';
  static const String testUserId2 = '3';

  static const User testUser = User(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    avatarUrl: 'https://example.com/avatar.jpg',
    email: 'john.doe@example.com',
  );

  static const User testUser2 = User(
    id: '3',
    firstName: 'Jane',
    lastName: 'Smith',
    avatarUrl: 'https://example.com/jane.jpg',
    email: 'jane.smith@example.com',
  );

  static const UserModel testUserModel = UserModel(
    id: 1,
    firstName: 'John',
    lastName: 'Doe',
    picture: [
      PictureModel(url: 'https://example.com/avatar.jpg', label: 'small'),
    ],
    email: 'john.doe@example.com',
  );

  static const UserModel testUserModel2 = UserModel(
    id: 3,
    firstName: 'Jane',
    lastName: 'Smith',
    picture: [
      PictureModel(url: 'https://example.com/jane.jpg', label: 'small'),
    ],
    email: 'jane.smith@example.com',
  );

  static Map<String, dynamic> get testUserJson => {
        'id': 1,
        'first_name': 'John',
        'last_name': 'Doe',
        'picture': [
          {'url': 'https://example.com/avatar.jpg', 'label': 'small'},
        ],
        'email': 'john.doe@example.com',
      };
}
