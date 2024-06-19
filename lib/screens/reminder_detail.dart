import 'package:flutter/material.dart';

class ReminderDetail extends StatelessWidget {
  final Map Reminder;

  ReminderDetail({required this.Reminder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder Detail"),
      ),
      body: Column(
        children: [
          Container(
            child: Image.network(Reminder['reward']),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Reminder['smallest_move'],
                  style: TextStyle(fontSize: 22),
                ),
                Row(children: [Icon(Icons.edit), Icon(Icons.delete)])
              ],
            ),
          ),
          Text(Reminder['inspiration'])
        ],
      ),
    );
  }
}
