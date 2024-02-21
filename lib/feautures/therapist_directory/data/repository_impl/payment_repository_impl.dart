import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:startup/feautures/therapist_directory/domain/repository/payment_repository.dart';

class RazorpayPaymentRepository implements PaymentRepository {
  final Razorpay _razorpay = Razorpay();

  @override
  Future<void> startPayment() async {
    try {
      final options = {
        'key': 'rzp_test_JF064IpLRmVimx',
        'amount': 10000, // Amount in paisa (e.g., ₹100)
        'name': 'Therapist Appointment',
        //'order_id': 'item_NUZEp2cNdExhvb',
        'description': 'Booking Appointment',
        'prefill': {'contact': 'USER_PHONE_NUMBER', 'email': 'USER_EMAIL'},
        'external': {
          'wallets': ['paytm'] // Example: Include Paytm wallet for external wallet payments
        }
      };
      print('before opening payment options');
      _razorpay.open(options);

      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    } on PlatformException catch (e) {
      // Handle platform exceptions
      print('Platform Exception: $e');
      throw Exception('Failed to start payment: $e');
    } catch (e) {
      // Handle other exceptions
      print('Exception: $e');
      throw Exception('Failed to start payment: $e');
    }
  }
}

void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  // Handle payment success
  print('Payment successful');
  try {
    await FirebaseFirestore.instance.collection('bookings').add({
      'userId': 'userId',
      'therapistId': 'therapistId',
      'bookingTime': 'bookingTime',
    });
    print('Booking added to Firestore successfully.');
  } catch (e) {
    print ('Error when storing booking in firestore : ' + e.toString());
  }
  print('Booking stored successfully');
  // Update Firestore with booking details, navigate to success screen, etc.
}

void _handlePaymentError(PaymentFailureResponse response) {
  // Handle payment error
  print('Payment error: ${response.code} - ${response.message}');

  // Handle error message display, retry payment, etc.
}

void _handleExternalWallet(ExternalWalletResponse response) {
  // Handle external wallet payment
  print('External wallet payment: ${response.walletName}');

  // Additional handling for external wallet payments
}
