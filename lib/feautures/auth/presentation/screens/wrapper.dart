import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/core/bottom_bar.dart';
import 'package:startup/core/providers/firebaseauth_provider.dart';
import 'package:startup/feautures/assessment/presentation/providers/assessment_providers.dart';
import 'package:startup/feautures/assessment/presentation/screens/question1.dart';
import 'package:startup/feautures/auth/presentation/providers/auth_provider.dart';
import 'package:startup/feautures/auth/presentation/screens/dashboard.dart';
import 'package:startup/feautures/auth/presentation/screens/dashboard_debug.dart';
import 'package:startup/feautures/auth/presentation/screens/myhomepage.dart';
import 'package:startup/feautures/auth/presentation/screens/welcome_screen.dart';
import 'package:startup/feautures/chat/presentation/screens/chat_screen.dart';
import 'package:startup/feautures/chat/presentation/screens/my_chats.dart';
import 'package:startup/feautures/resources/presentation/screens/resources_screen.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    final hasCompletedAssessment = ref.watch(hasCompletedAssessmentProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return WelcomeScreen(); // User not authenticated
        } else {
          return hasCompletedAssessment.when(
            data: (hasCompleted) => hasCompleted ? BottomBar() : Question1(),
            loading: () => Scaffold(
                backgroundColor: Color(0xffEEEEEE),
                body: const Center(child: CircularProgressIndicator())
            ),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          );
        }
      },
      loading: () => Scaffold(
        backgroundColor: Color(0xffEEEEEE),
          body: const Center(child: CircularProgressIndicator())
      ),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}