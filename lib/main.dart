import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/di/injection.dart';
import 'src/core/platform/method_channel_handler.dart';
import 'src/presentation/bloc/profile_cubit.dart';
import 'src/presentation/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const AzeooProfileApp());
}

class AzeooProfileApp extends StatefulWidget {
  const AzeooProfileApp({super.key});

  @override
  State<AzeooProfileApp> createState() => _AzeooProfileAppState();
}

class _AzeooProfileAppState extends State<AzeooProfileApp> {
  late final ProfileCubit _profileCubit;
  String _currentUserId = '1';
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _profileCubit = getIt<ProfileCubit>();
    _initializeMethodChannel();
  }

  Future<void> _initializeMethodChannel() async {
    MethodChannelHandler.initialize(
      onUserIdUpdated: _onUserIdUpdated,
    );

    final initialUserId = await MethodChannelHandler.getInitialUserId();

    setState(() {
      _currentUserId = initialUserId ?? '1';
      _isInitialized = true;
    });

    _profileCubit.loadProfile(_currentUserId);
  }

  void _onUserIdUpdated(String userId) {
    debugPrint('Flutter: Received userId update: $userId');
    if (userId != _currentUserId) {
      setState(() {
        _currentUserId = userId;
      });
      _profileCubit.updateUserId(userId);
    }
  }

  @override
  void dispose() {
    MethodChannelHandler.dispose();
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AZEOO Profile SDK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: _isInitialized
          ? BlocProvider<ProfileCubit>.value(
              value: _profileCubit,
              child: const ProfilePage(),
            )
          : const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
