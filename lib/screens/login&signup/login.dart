import 'package:excel_learn_hub/screens/components/custom_input_field.dart';
import 'package:excel_learn_hub/screens/components/primary_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        key: const ValueKey(0), // Key for AnimatedSwitcher
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white, // White background
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Color(0xFF6C6C6C),width:0.2 ), // Subtle border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 4.0),
            const Text(
              'Login to continue your learning journey',
              style: TextStyle(fontSize: 14, color: Color(0xFF6C6C6C)),
            ),
            const SizedBox(height: 30.0),
            const CustomInputField(
              icon: Icons.email,
              label: 'Email',
            ),
            const SizedBox(height: 20.0),
            const CustomInputField(
              icon: Icons.lock,
              label: 'Password',
              
              isPassword: true,
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Forgot Password logic
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Color(0xFF6C6C6C), fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            PrimaryButton(
              text: 'Login',
              onPressed: () {
                // Handle Login
              },
            ),
          ],
        ),
      ),
    );
  }
}