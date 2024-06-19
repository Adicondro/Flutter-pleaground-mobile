import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pleaground_mobile/screens/reminder.dart';
import 'package:http/http.dart' as http;

class EditReminder extends StatelessWidget {
  final Map Reminder;

  EditReminder({required this.Reminder});
  final _formKey = GlobalKey<FormState>();

  TextEditingController _goalsController = TextEditingController();
  TextEditingController _inspirationController = TextEditingController();
  TextEditingController _smallest_moveController = TextEditingController();
  TextEditingController _rewardController = TextEditingController();

  Future updateReminder() async {
    final response = await http.post(
        Uri.parse(
            "http://127.0.0.1:8000/api/reminders/" + Reminder['id'].toString()),
        body: {
          "goals": _goalsController.text,
          "inspiration": _inspirationController.text,
          "smallest_move": _smallest_moveController.text,
          "reward": _rewardController.text
        });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Reminder"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _goalsController..text = Reminder['goals'],
              decoration: InputDecoration(labelText: "Goals"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Edit Your Goals";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _inspirationController
                ..text = Reminder['inspiration'],
              decoration: InputDecoration(labelText: "Inspiration"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Change Your Inspiration ?";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _smallest_moveController
                ..text = Reminder['smallest_move'],
              decoration: InputDecoration(labelText: "Smallest Move"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Update/Change Your Smallest Move";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _rewardController..text = Reminder['reward'],
              decoration: InputDecoration(labelText: "Reward"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Update Your Reward";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateReminder().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReminderPage()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Reminder Updated!"),
                      ));
                    });
                  }
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}
