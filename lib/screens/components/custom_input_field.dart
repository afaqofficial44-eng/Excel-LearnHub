import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
 
  final bool isPassword;
  final IconData icon;

  const CustomInputField({
    super.key,
    required this.label,
  
    this.isPassword = false,
    required this.icon ,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          
          obscureText: widget.isPassword,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Color(0xFF6C6C6C)) ,
            labelText: widget.label,
            floatingLabelStyle: TextStyle(
              color:Color(0xFF6C6C6C),
              fontWeight: FontWeight.w600,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: Color(0xFFEFEFEF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Color(0xFF6C6C6C), width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Color(0xFF6C6C6C), width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Color(0xFF6C6C6C), width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}