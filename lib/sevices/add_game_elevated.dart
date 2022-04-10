import 'package:black_pearl/models/game_model.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/models/user_model.dart';
import 'package:black_pearl/sevices/globals.dart' as globals;
import 'package:black_pearl/sevices/show_dialog.dart';

class AddGameElevated extends StatefulWidget {
  @override
  _AddGameElevatedState createState() {
    return _AddGameElevatedState();
  }
}

class _AddGameElevatedState extends State<AddGameElevated> {
  final TextEditingController opponentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference gamesTable =
      FirebaseFirestore.instance.collection('games');

  String? _hour, _minute, _time;

  DateTime? gameDateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDateTime(BuildContext context) async {
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
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null)
      setState(() {
        selectedTime = pickedTime;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Selected: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}\n${selectedTime.hour}/${selectedTime.minute}'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        openDialog();
      },
      child: Icon(Icons.add),
    );
  }

  Future<Game?> openDialog() => showDialog<Game>(
        context: context,
        builder: (context) => Center(
          child: AlertDialog(
            title: Text(
              'Enter next game details',
              textAlign: TextAlign.center,
            ),
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: opponentController,
                    decoration: const InputDecoration(
                      hintText: 'Enter opponent team name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Opponent name missing';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDateTime(context),
                    child: Text('Select date'),
                  ),
                  ShowDialog(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: submit,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void submit() {
    Game game = Game(
      id: UniqueKey().toString(),
      opponentName: opponentController.text,
      gameDate: selectedDate.add(
          Duration(hours: selectedTime.hour, minutes: selectedTime.minute)),
    );
    gamesTable.add({
      'Game Date': game.gameDate,
      'id': game.id,
      'Opponent': game.opponentName,
      'Home?': globals.isChecked,
    });
    Navigator.of(context).pop(game);
  }
}
