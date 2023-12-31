import 'package:english_words/english_words.dart';
import 'package:random_avatar/random_avatar.dart';

String generateRandomUsername() {
  final WordPair randomWords = WordPair.random();
  return randomWords.asPascalCase; // Combine two random words
}

String generateRandomAvatar() {
  return RandomAvatarString('saytoonz', trBackground: true);
}