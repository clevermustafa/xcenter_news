

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcenter_news/presentation/feature/initialize_app/initialize_app_cubit.dart';
import 'package:xcenter_news/presentation/gui/pages/dashboard_page.dart';

class InitializationPage extends StatelessWidget {
  const InitializationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<InitializeAppCubit, InitializeAppState>(
      listener: (context, state) {
        if (state.status == InitializeAppStatus.loaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        log(state.status.toString());
        switch (state.status) {
          case InitializeAppStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case InitializeAppStatus.loaded:
          case InitializeAppStatus.error:
            return Center(
              child: Text(state.errorMessage ?? "error"),
            );
        }
      },
    ));
  }
}
