import 'package:flutter/material.dart';

class DonationTextField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final void Function(String) onEditingComplete;
  final TextInputType? keyboardType;
  final bool obscureText;

  const DonationTextField({
    required this.labelText,
    required this.icon,
    required this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    super.key,
  });

  @override
  State<DonationTextField> createState() => DonationTextFieldState();
}

class DonationTextFieldState extends State<DonationTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void clear() {
    _controller.clear();
  }

  void fillData(String text) {
    _controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Colors.red;
    //Theme.of(context).primaryColor.withOpacity(1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        obscureText: widget.obscureText,
        onChanged: widget.onEditingComplete,
        onSubmitted: (value) {
          widget.onEditingComplete(_controller.text);
          FocusScope.of(context).unfocus();
        },
        controller: _controller,
        keyboardType: widget.keyboardType,
        cursorColor: accentColor,
        style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Colors.blueGrey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blueGrey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: accentColor),
            borderRadius: BorderRadius.circular(30),
          ),
          focusColor: accentColor,
          suffixIcon: Icon(
            widget.icon,
            color: accentColor,
          ),
        ),
      ),
    );
  }
}
