import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: DatePickExample()));
}

class DatePickExample extends StatefulWidget {
  DatePickExample({super.key});

  @override
  State<DatePickExample> createState() => _DatePickExampleState();
}

class _DatePickExampleState extends State<DatePickExample> {
  // var DateController = TextEditingController();

  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DATE PICKER"),
      ),
      body: Center(
        child: TextField(
          controller: TextEditingController(
            //to local means for local time depends on place
            //split is to split between year ,month and day
              text: "${currentDate.toLocal()}".split(" ")[0]),
          onTap: () => selectDate(context),
          //when click we have to show the datepicker

          // DateTime? pickedDate = await showDatePicker(
          //      context: context,
          //      initialDate: DateTime.now(), //get today's date
          //      firstDate: DateTime(
          //          2000), //DateTime.now() - not to allow to choose before today.
          //      lastDate: DateTime(2030));
          //  if (pickedDate != null) {
          //    print(
          //        pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
          //  }
          //  setState(() {
          //    DateController.text=pickedDate as String;
          //  });
          readOnly: true, // when true user cannot edit text
          decoration: const InputDecoration(
            labelText: "enter date",
            icon: Icon(Icons.calendar_month), //icon of text field
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2030));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;//if pickeddate is current date then no need to change or else it has to change and set to picked date
      });
    }
  }
}
