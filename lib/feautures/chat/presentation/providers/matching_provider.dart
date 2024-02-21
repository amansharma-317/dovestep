import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/core/models/assessment_model.dart';
import 'package:startup/feautures/chat/data/matching_data_source.dart';
import 'package:startup/feautures/chat/data/matching_repository_impl.dart';
import 'package:startup/feautures/chat/domain/entities/match_user_result.dart';
import 'package:startup/feautures/chat/domain/matching_repository.dart';

// Provider for MatchingDataSource
final matchingDataSourceProvider = Provider<MatchingDataSource>((ref) {
  return MatchingDataSource();
});

// Provider for MatchingRepository
final matchingRepositoryProvider = Provider<MatchingRepository>((ref) {
  final dataSource = ref.read(matchingDataSourceProvider);
  return MatchingRepositoryImpl(dataSource);
});

// Provider for matchUser future
final matchUserProvider = FutureProvider.autoDispose.family<MatchUserResult, MentalHealthAssessment>((ref, currentUserAssessment) async {
  final matchingRepository = ref.read(matchingRepositoryProvider);
  return await matchingRepository.matchUser(currentUserAssessment);
});
