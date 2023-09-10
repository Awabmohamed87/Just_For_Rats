import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String title;
  final String label;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const CustomFormField(
      {super.key,
      required this.title,
      required this.label,
      required this.validator,
      required this.controller,
      this.onFieldSubmitted,
      this.keyboardType = TextInputType.phone});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(widget.title, style: const TextStyle(fontSize: 18)),
          SizedBox(width: MediaQuery.of(context).size.width * 0.139),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              cursorHeight: 20,
              validator: widget.validator,
              onFieldSubmitted: widget.onFieldSubmitted,
              style: const TextStyle(fontSize: 18),
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle:
                      const TextStyle(color: Colors.white, fontSize: 12),
                  border: const OutlineInputBorder()),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }
}
