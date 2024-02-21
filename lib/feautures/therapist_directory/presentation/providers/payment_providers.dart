import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:startup/feautures/therapist_directory/data/repository_impl/payment_repository_impl.dart';
//provides instance of razorpay
final razorpayProvider = Provider.autoDispose((ref) => Razorpay());

//provides instance of payment repository
final razorpayPaymentRepositoryProvider = Provider.autoDispose((ref) => RazorpayPaymentRepository());

final razorpayPaymentProvider = Provider.autoDispose((ref) {
  final repository = ref.watch(razorpayPaymentRepositoryProvider);
  return repository;
});