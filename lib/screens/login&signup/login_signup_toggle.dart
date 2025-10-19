import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:flutter/material.dart';

class LoginSignupToggle extends StatefulWidget {
  // Callback function that the parent widget (ToggleScreen) can use
  // to react to the change in selection (index: 0=Login, 1=Signup).
  final ValueChanged<int> onSelectionChanged;

  const LoginSignupToggle({super.key, required this.onSelectionChanged});

  @override
  State<LoginSignupToggle> createState() => LoginSignupToggleState();
}

class LoginSignupToggleState extends State<LoginSignupToggle> {
  // 0 for Login, 1 for Sign Up.
  int selectedIndex = 0;

  void handleTap(int index) {
    if (selectedIndex != index) {
      setState(() {
        selectedIndex = index;
      });
      // Notify the parent widget of the change
      widget.onSelectionChanged(index);
    }
  }

  /// Builds a clickable text option for the toggle.
  Widget buildToggleOption(String text, int index, double width) {
    // Determine if the current option is active
    final bool isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () => handleTap(index),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 48,
        child: ShaderMask(
  shaderCallback: (Rect bounds) {
    return xcelerateGradient.createShader(bounds);
  },
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final double segmentWidth = totalWidth / 2;

        return Container(
          width: totalWidth,
          height: 48,
          decoration: BoxDecoration(
            color: Color(0xFFEFEFEF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              // 1. Sliding Indicator (AnimatedPositioned)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: selectedIndex * segmentWidth,
                top: 0,
                bottom: 0,
                child: Container(
                  width: segmentWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. The Text Options (Row)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildToggleOption('Login', 0, segmentWidth),
                  buildToggleOption('Sign Up', 1, segmentWidth),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}