import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Entité représentant un utilisateur
///
/// Cette classe est immuable grâce à Freezed et représente
/// les données métier d'un utilisateur, indépendamment de
/// leur source (API, cache, etc.).
@freezed
class User with _$User {
  const factory User({
    /// Identifiant unique de l'utilisateur
    required String id,

    /// Prénom de l'utilisateur
    required String firstName,

    /// Nom de famille de l'utilisateur
    required String lastName,

    /// URL de l'avatar de l'utilisateur (peut être null)
    String? avatarUrl,

    /// Email de l'utilisateur (optionnel)
    String? email,
  }) = _User;

  const User._();

  /// Retourne le nom complet de l'utilisateur
  String get fullName => '$firstName $lastName';

  /// Retourne les initiales de l'utilisateur (pour l'avatar par défaut)
  String get initials {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }
}
