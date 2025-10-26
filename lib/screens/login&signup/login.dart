import 'package:excel_learn_hub/screens/components/custom_input_field.dart';
import 'package:excel_learn_hub/screens/components/primary_button.dart';
import 'package:excel_learn_hub/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful')),
      );

      Get.to(() => const ProfileScreen());
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        key: const ValueKey(0),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: const Color(0xFF6C6C6C), width: 0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome Back',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const SizedBox(height: 4.0),
            const Text('Login to continue your learning journey',
                style: TextStyle(fontSize: 14, color: Color(0xFF6C6C6C))),
            const SizedBox(height: 30.0),
            CustomInputField(
              icon: Icons.email,
              label: 'Email',
              controller: _emailController,
            ),
            const SizedBox(height: 20.0),
            CustomInputField(
              icon: Icons.lock,
              label: 'Password',
              controller: _passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?',
                    style: TextStyle(color: Color(0xFF6C6C6C), fontSize: 14)),
              ),
            ),
            const SizedBox(height: 20.0),
            PrimaryButton(
              text: 'Login',
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }
}
