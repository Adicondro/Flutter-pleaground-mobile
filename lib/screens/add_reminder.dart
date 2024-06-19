import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pleaground_mobile/screens/reminder.dart';
import 'package:http/http.dart' as http;

class AddReminder extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _goalsController = TextEditingController();
  TextEditingController _inspirationController = TextEditingController();
  TextEditingController _smallest_moveController = TextEditingController();
  TextEditingController _rewardController = TextEditingController();

  Future saveReminder() async {
    final response = await http
        .post(Uri.parse("http://127.0.0.1:8000/api/reminders"), body: {
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
        title: Text("Add Reminder"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _goalsController,
              decoration: InputDecoration(labelText: "Goals"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Add your goals";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _inspirationController,
              decoration: InputDecoration(labelText: "Inspiration"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Who are you inspired by ?";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _smallest_moveController,
              decoration: InputDecoration(labelText: "Smallest Move"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "What Smallest Move You Can Do ?";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _rewardController,
              decoration: InputDecoration(labelText: "Image URL"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "What Reward you wanna get after completing the goals";
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
                    saveReminder().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReminderPage()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Reminder Added!"),
                      ));
                    });
                  }
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
