import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'presentation/bloc/profile_cubit.dart';
import 'presentation/pages/profile_page.dart';

class AzeooProfileSdk {
  AzeooProfileSdk._();

  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    await configureDependencies();
    _isInitialized = true;
  }

  static bool get isInitialized => _isInitialized;

  static Widget getProfileWidget({required String userId}) {
    _ensureInitialized();

    return BlocProvider<ProfileCubit>(
      create: (_) => getIt<ProfileCubit>()..loadProfile(userId),
      child: const ProfilePage(),
    );
  }

  static Widget createProfileApp({required String userId}) {
    _ensureInitialized();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: getProfileWidget(userId: userId),
    );
  }

  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        "AzeooProfileSdk n'est pas initialisé. "
        "Appelez AzeooProfileSdk.initialize() avant d'utiliser le SDK.",
      );
    }
  }
}
