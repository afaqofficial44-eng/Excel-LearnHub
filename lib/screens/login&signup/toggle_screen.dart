import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:excel_learn_hub/screens/login&signup/login.dart';
import 'package:excel_learn_hub/screens/login&signup/login_signup_toggle.dart';
import 'package:excel_learn_hub/screens/login&signup/signup.dart';
import 'package:flutter/material.dart';

class ToggleScreen extends StatefulWidget {
  const ToggleScreen({super.key});

  @override
  State<ToggleScreen> createState() => ToggleScreenState();
}

class ToggleScreenState extends State<ToggleScreen> {
  // 0 for Login, 1 for Sign Up.
  int selectedIndex = 0;

  void _updateSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine which form to show
    final Widget currentForm = selectedIndex == 0
        ? const LoginForm()
        : const SignUpForm();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 380,
              ), // Max width for a clean mobile-like interface
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Logo/Title Area
  ShaderMask(
    shaderCallback: (Rect bounds) {
      return xcelerateGradient.createShader(bounds);
    },
    child: const Icon(
      Icons.menu_book,
      size: 50,
      color: Colors.white,
    ),
  ),
  ShaderMask(
    shaderCallback: (Rect bounds) {
      return xcelerateGradient.createShader(bounds);
    },
    child: const Text(
      'Excel LearnHub',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
                  const Text(
                    'Your Journey to Programming Excellence',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6C6C6C)),
                  ),
                  const SizedBox(height: 40),

                  // Segmented Toggle Control
                  LoginSignupToggle(onSelectionChanged: _updateSelection),
                  const SizedBox(height: 40),

                  // AnimatedSwitcher for smooth form transition
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: currentForm,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
