import 'package:flutter/material.dart';

class DonationDateSelector extends StatefulWidget {
  final void Function(String) onEditingComplete;

  const DonationDateSelector({
    required this.onEditingComplete,
    super.key,
  });

  @override
  State<DonationDateSelector> createState() => _DonationDateSelectorState();
}

class _DonationDateSelectorState extends State<DonationDateSelector> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });

      widget.onEditingComplete(_dateController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        controller: _dateController,
        readOnly: true,
        onTap: () => _selectDate(context),
        cursorColor: accentColor,
        style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          labelText: "Select Date",
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
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: accentColor,
          ),
        ),
      ),
    );
  }
}
