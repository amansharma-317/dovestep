import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/core/bottom_bar.dart';
import 'package:startup/feautures/assessment/presentation/providers/assessment_providers.dart';
import 'package:startup/feautures/assessment/presentation/screens/question1.dart';
import 'package:startup/feautures/auth/presentation/providers/auth_provider.dart';
import 'package:startup/feautures/auth/presentation/screens/dashboard.dart';
import 'package:startup/feautures/auth/presentation/screens/myhomepage.dart';
import 'package:startup/feautures/chat/presentation/screens/chat_screen.dart';
import 'package:startup/feautures/chat/presentation/screens/my_chats.dart';
import 'package:startup/feautures/community/presentation/screens/community_screens.dart';
import 'package:startup/feautures/resources/presentation/screens/resources_screen.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authStateNotifierProvider.notifier).init();
    final isAuthenticated = ref.watch(authStateNotifierProvider);
    final hasCompletedAssessment = ref.watch(hasCompletedAssessmentProvider);

    return hasCompletedAssessment.when(
      data: (hasCompleted) => isAuthenticated
          ? hasCompleted ? BottomBar() : Question1()
          : MyHomePage(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}