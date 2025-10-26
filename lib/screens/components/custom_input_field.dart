import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final IconData icon;
  final TextEditingController? controller; // ✅ added controller

  const CustomInputField({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.icon,
    this.controller, // ✅ optional
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // ✅ connected controller
      obscureText: widget.isPassword ? _obscure : false,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: ShaderMask(
          shaderCallback: (Rect bounds) {
            return xcelerateGradient.createShader(bounds);
          },
          child: Icon(widget.icon, color: Colors.white),
        ),
        labelText: widget.label,
        floatingLabelStyle: const TextStyle(
          color: Color(0xFF6C6C6C),
          fontWeight: FontWeight.w600,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        filled: true,
        fillColor: const Color(0xFFEFEFEF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Color(0xFFFF5200), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Color(0xFFFF5200), width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Color(0xFFFF5200), width: 2.0),
        ),
        // ✅ Add eye icon toggle for password fields
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF6C6C6C),
                ),
                onPressed: () {
                  setState(() => _obscure = !_obscure);
                },
              )
            : null,
      ),
    );
  }
}
