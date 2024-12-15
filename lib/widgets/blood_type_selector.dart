import 'package:flutter/material.dart';

class BloodTypeSelector extends StatefulWidget {

  final void Function(String) onEditingComplete;

  const BloodTypeSelector({
    required this.onEditingComplete,
    super.key,
  });

  @override
  State<BloodTypeSelector> createState() => _BloodTypeSelectorState();
}

class _BloodTypeSelectorState extends State<BloodTypeSelector> {
  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  String? _selectedBloodType;

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InputDecorator(

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          labelText: _selectedBloodType == null ? null : "Blood Type",
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
            Icons.bloodtype,
            color: accentColor,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownMenuTheme(
            data: DropdownMenuThemeData(
              menuStyle: MenuStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                elevation: WidgetStateProperty.all(4),
                //backgroundColor: WidgetStateProperty.all(Colors.white),
              ),
            ),
            child: DropdownButton<String>(
              value: _selectedBloodType,
              isExpanded: true,

              hint: const Text(
                'Select Blood Type',
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
              style: const TextStyle(color: Colors.blueGrey, fontSize: 16),
              icon: const Icon(Icons.arrow_drop_down, color: accentColor),
              items: _bloodTypes.map((String bloodType) {
                return DropdownMenuItem<String>(
                  value: bloodType,
                  child: Text(bloodType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBloodType = newValue;
                  if(newValue != null) widget.onEditingComplete(newValue);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
