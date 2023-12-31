import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/core/models/assessment_model.dart';
import 'package:startup/feautures/assessment/data/data_source/assessment_data_source.dart';
import 'package:startup/feautures/assessment/data/repositories/assessment_repository_impl.dart';
import 'package:startup/feautures/assessment/domain/repository/assessment_repository.dart';

// Providers related to mental health assessment

final assessmentRepositoryProvider = Provider<AssessmentRepository>(
      (ref) => AssessmentRepositoryImpl(FirebaseUserDataSource()), // Pass your data source instance
);

// State provider for managing the first question's answer & logic for updating the provider
final firstQuestionAnswerProvider = StateProvider<int>((ref) => 0);
final updateFirstQuestionAnswerProvider = Provider<int>((ref) => ref.watch(firstQuestionAnswerProvider.notifier).state);

//similarly for the other 4 questions
final secondQuestionAnswerProvider = StateProvider<int>((ref) => 0);
final updateSecondQuestionAnswerProvider = Provider<int>((ref) => ref.watch(secondQuestionAnswerProvider.notifier).state);
final thirdQuestionAnswerProvider = StateProvider<int>((ref) => 0);
final updateThirdQuestionAnswerProvider = Provider<int>((ref) => ref.watch(thirdQuestionAnswerProvider.notifier).state);
final fourthQuestionAnswerProvider = StateProvider<int>((ref) => 0);
final updateFourthQuestionAnswerProvider = Provider<int>((ref) => ref.watch(fourthQuestionAnswerProvider.notifier).state);
final fifthQuestionAnswerProvider = StateProvider<int>((ref) => 0);
final updateFifthQuestionAnswerProvider = Provider<int>((ref) => ref.watch(fifthQuestionAnswerProvider.notifier).state);



final hasCompletedAssessmentProvider = FutureProvider<bool>((ref) async {
  final repository = ref.read(assessmentRepositoryProvider);
  final responses = await repository.getAssessmentResponses(); // Replace 'userId' with actual user ID
  return responses != null && responses.length == 5;
});

