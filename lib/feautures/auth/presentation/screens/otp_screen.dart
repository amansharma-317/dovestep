import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/feautures/auth/presentation/providers/auth_provider.dart';

class OTPScreen extends ConsumerWidget {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement your logic to verify OTP
                await ref.read(authStateNotifierProvider.notifier).verifyOTP('+917617725789', _otpController.text);
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
