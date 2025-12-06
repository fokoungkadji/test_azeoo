import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'presentation/bloc/profile_cubit.dart';
import 'presentation/pages/profile_page.dart';

/// Classe principale du SDK AZEOO Profile
///
/// Fournit les méthodes pour initialiser le SDK et afficher
/// le profil d'un utilisateur.
class AzeooProfileSdk {
  AzeooProfileSdk._();

  static bool _isInitialized = false;

  /// Initialise le SDK
  ///
  /// Cette méthode doit être appelée avant d'utiliser le SDK,
  /// de préférence dans le main() de l'application.
  ///
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await AzeooProfileSdk.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> initialize() async {
    if (_isInitialized) return;

    await configureDependencies();
    _isInitialized = true;
  }

  /// Vérifie si le SDK est initialisé
  static bool get isInitialized => _isInitialized;

  /// Retourne le widget du profil utilisateur
  ///
  /// [userId] L'identifiant de l'utilisateur dont on veut afficher le profil
  ///
  /// ```dart
  /// AzeooProfileSdk.getProfileWidget(userId: '1')
  /// ```
  static Widget getProfileWidget({required String userId}) {
    _ensureInitialized();

    return BlocProvider<ProfileCubit>(
      create: (_) => getIt<ProfileCubit>()..loadProfile(userId),
      child: const ProfilePage(),
    );
  }

  /// Crée un MaterialApp contenant uniquement le profil
  ///
  /// Utile pour l'intégration via Flutter Module dans React Native
  ///
  /// [userId] L'identifiant de l'utilisateur dont on veut afficher le profil
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
