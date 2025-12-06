import 'package:flutter/material.dart';

import 'azeoo_profile_sdk.dart';

/// Point d'entrée pour le test standalone du SDK
///
/// Ce fichier n'est utilisé que pour le développement et les tests.
/// En production, le SDK est utilisé via [AzeooProfileSdk].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser le SDK
  await AzeooProfileSdk.initialize();

  runApp(const AzeooTestApp());
}

/// Application de test pour le SDK
class AzeooTestApp extends StatelessWidget {
  const AzeooTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AZEOO Profile SDK Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      // Afficher le profil de l'utilisateur 1 par défaut
      home: AzeooProfileSdk.getProfileWidget(userId: '1'),
    );
  }
}
