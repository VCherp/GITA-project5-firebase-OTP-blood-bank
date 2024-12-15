import 'package:flutter/material.dart';

class BloodBankButton extends StatelessWidget {
  final String title;
  final void Function() onPress;

  const BloodBankButton(
      {required this.title, required this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          //side: BorderSide(style: BorderStyle.solid),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
