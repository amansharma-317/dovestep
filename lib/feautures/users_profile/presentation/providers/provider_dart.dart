import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:startup/feautures/community/domain/entities/post_entity.dart';
import 'package:startup/feautures/users_profile/data/datasources/myPosts_remote_data_source.dart';
import 'package:startup/feautures/users_profile/data/repository/myPosts_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseFirestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final firestorePostsRemoteDataSourceProvider = Provider((ref) => FirestorePostsRemoteDataSource(ref.watch(firebaseFirestoreProvider)));
final postsRepositoryProvider = Provider((ref) => PostsRepositoryImpl(ref.watch(firestorePostsRemoteDataSourceProvider)));
final postsForUserProvider = FutureProvider.autoDispose.family<List<PostEntity>, String>((ref, userId) async {
  final postsRepository = ref.read(postsRepositoryProvider);
  return postsRepository.getPostsByUserId(userId);
});
