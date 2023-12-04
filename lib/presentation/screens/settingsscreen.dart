import '../../presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../routes/route_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () =>
                    context.pushNamed(RouteConstants.userAccountRoute),
                child: const Text('Account')),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
                  context.pushNamed(RouteConstants.homeRoute);
                },
                child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
