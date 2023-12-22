import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
/*
class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneNumberProvider);
    final sendVerificationCode = ref.watch(sendVerificationCodeProvider);
    final verifyCode = ref.watch(verifyCodeProvider);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('enter phone no'),
              SizedBox(height: 16,),
              TextField(
                controller: phoneController,
              ),
              SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () => context.read<sendVerificationCodeProvider>().call(phoneNumber),
                child: Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/