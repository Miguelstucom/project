import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const NameField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          hintText: hint,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.list_alt),
        ),
      ),
    );
  }
}

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLength;

  const DescriptionField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          hintText: hint,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.description),
        ),
      ),
    );
  }
}

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Function() onTap;

  const DateField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          hintText: hint,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.calendar_month),
        ),
      ),
    );
  }
}
