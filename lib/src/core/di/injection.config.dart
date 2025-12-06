// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/user_local_datasource.dart' as _i15;
import '../../data/datasources/user_remote_datasource.dart' as _i1061;
import '../../data/repositories/user_repository_impl.dart' as _i790;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/usecases/get_user_profile.dart' as _i865;
import '../../presentation/bloc/profile_cubit.dart' as _i198;
import '../cache/cache_manager.dart' as _i326;
import '../network/api_client.dart' as _i557;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i326.CacheManager>(() => _i326.CacheManager());
    gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient());
    gh.lazySingleton<_i1061.UserRemoteDataSource>(
      () => _i1061.UserRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i15.UserLocalDataSource>(
      () => _i15.UserLocalDataSourceImpl(gh<_i326.CacheManager>()),
    );
    gh.lazySingleton<_i271.UserRepository>(
      () => _i790.UserRepositoryImpl(
        gh<_i1061.UserRemoteDataSource>(),
        gh<_i15.UserLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i865.GetUserProfile>(
      () => _i865.GetUserProfile(gh<_i271.UserRepository>()),
    );
    gh.factory<_i198.ProfileCubit>(
      () => _i198.ProfileCubit(gh<_i865.GetUserProfile>()),
    );
    return this;
  }
}
