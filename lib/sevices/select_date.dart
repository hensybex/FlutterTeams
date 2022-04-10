import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  @override
  _SelectDateState createState() {
    return _SelectDateState();
  }
}

class _SelectDateState extends State<SelectDate> {
  String? _hour, _minute, _time;

  DateTime? gameDateTime;

  DateTime selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: submit,
      child: Text('Select date'),
    );
  }

  void submit() {
    _selectDate(context);
    Navigator.of(context).pop(selectedDate);
  }
}
