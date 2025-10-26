import 'package:excel_learn_hub/screens/components/custom_input_field.dart';
import 'package:excel_learn_hub/screens/components/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../profile/profile.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (!email.contains('@')) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Enter a valid email.')));
        return;
      }
      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password must be at least 6 characters.')));
        return;
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
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
        key: const ValueKey(1),
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
            const Text('Create Account',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const SizedBox(height: 4.0),
            const Text('Sign up to start learning today',
                style: TextStyle(fontSize: 14, color: Color(0xFF6C6C6C))),
            const SizedBox(height: 30.0),
            CustomInputField(
              icon: Icons.person,
              label: 'Full Name',
              controller: _nameController,
            ),
            const SizedBox(height: 20.0),
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
            const SizedBox(height: 30.0),
            PrimaryButton(
              text: 'Sign Up',
              onPressed: _signUp,
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? ',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6C6C6C))),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text('Login',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C6C6C))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
