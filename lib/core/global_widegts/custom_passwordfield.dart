import 'package:flutter/material.dart';
import 'package:guven_a/core/style/global_text_style.dart';

class CustomPasswordField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color textColor;
  final Color hintColor;

  CustomPasswordField({
    required this.title,
    required this.controller,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.textColor = Colors.black,
    this.hintColor = Colors.black54,
  });

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 3),
              Text(
                "*",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          TextField(
            controller: widget.controller,
            obscureText:
                _obscureText, // toggle between obscure and visible text
            style: TextStyle(color: widget.textColor),
            decoration: InputDecoration(
              hintText: 'Enter ${widget.title}',
              hintStyle: TextStyle(color: widget.hintColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.focusedBorderColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: widget.focusedBorderColor,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPasswordField2 extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color textColor;
  final Color hintColor;

  CustomPasswordField2({
    required this.title,
    this.hintText = "",
    required this.controller,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.textColor = Colors.black,
    this.hintColor = Colors.black54,
  });

  @override
  _CustomPasswordFieldState2 createState() => _CustomPasswordFieldState2();
}

class _CustomPasswordFieldState2 extends State<CustomPasswordField2> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: globalTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        TextField(
          controller: widget.controller,
          obscureText: _obscureText, // toggle between obscure and visible text
          style: TextStyle(color: widget.textColor),
          decoration: InputDecoration(
            hintText: '${widget.hintText}',
            hintStyle: TextStyle(color: widget.hintColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.focusedBorderColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: widget.focusedBorderColor,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
