import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class CustomBuilderText extends StatelessWidget {
  final String formTextName;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  const CustomBuilderText({
    super.key,
    required this.formTextName,
    this.labelText,
    this.validator,
    this.obscureText = false,
    this.autovalidateMode,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      name: formTextName,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
    );
  }
}

class CustomBuilderDateOfBirth extends StatelessWidget {
  final String formFieldName;
  final String? labelText;
  final DateTime? initialValue;
  final FormFieldValidator<DateTime>? validator;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffixIcon;
  const CustomBuilderDateOfBirth({
    Key? key,
    required this.formFieldName,
    this.labelText,
    this.initialValue,
    this.validator,
    this.autovalidateMode,
    this.suffixIcon,
  }) : super(key: key);

  String? _ageValidator(DateTime? value) {
    if (value == null) {
      return 'Date of birth is required';
    }

    final now = DateTime.now();
    var age = now.year - value.year;

    if (now.month < value.month ||
        (now.month == value.month && now.day < value.day)) {
      age--;
    }

    if (age >= 18) {
      return null;
    } else {
      return 'Age must be greater than 18';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: formFieldName,
      initialValue: initialValue,
      inputType: InputType.date, // Set the input type to date
      format: DateFormat('yyyy-MM-dd'), // Specify the date format
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      validator: (value) {
        final ageError = _ageValidator(value);
        if (validator != null) {
          final otherError = validator!(value);
          return otherError ?? ageError;
        }
        return ageError;
      },
      autovalidateMode: autovalidateMode,
    );
  }
}

class GenderDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: "gender",
      decoration: const InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      // List of gender options
      items: const [
        DropdownMenuItem(
          value: 'male',
          child: Text('Male'),
        ),
        DropdownMenuItem(
          value: 'female',
          child: Text('Female'),
        ),
      ],
      // Optional validator
      validator: FormBuilderValidators.required(),
    );
  }
}
