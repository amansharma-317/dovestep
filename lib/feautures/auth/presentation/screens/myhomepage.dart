import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/feautures/auth/presentation/screens/dashboard.dart';
import 'package:startup/feautures/auth/presentation/screens/otp_screen.dart';
import '../../presentation/providers/auth_provider.dart';

class MyHomePage extends ConsumerWidget {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authStateNotifierProvider);
    if(isAuthenticated) {
      return Dashboard();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Riverpod Auth Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _phoneNumberController,
                  //keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number',
                  ),
                ),
              ),
              if (!isAuthenticated)
                ElevatedButton(
                  onPressed: () async {
                    // Trigger phone number verification
                    await ref.read(authStateNotifierProvider.notifier)
                        .verifyPhoneNumber(_phoneNumberController.text);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPScreen(),
                      ),
                    );

                  },
                  child: Text(isAuthenticated ? 'Get OTP' : 'Verify OTP'),
                ),
            ],
          ),
        ),
      );
    }
  }
}
