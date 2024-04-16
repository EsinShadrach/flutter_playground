import "dart:async";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_playground/extensions.dart";

class JayDatePicker extends StatefulWidget {
  const JayDatePicker({super.key});

  @override
  State<JayDatePicker> createState() => _JayDatePickerState();
}

class _JayDatePickerState extends State<JayDatePicker> {
  late final TextEditingController _controller;
  late final Timer _debouncer;

  @override
  void initState() {
    _controller = TextEditingController();
    _debouncer = Timer(const Duration(milliseconds: 500), () {});
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  void _handleDateChange(DateTime date) async {
    if (_debouncer.isActive) {
      _debouncer.cancel();
    }

    _debouncer = Timer(Durations.long2, () async {
      await Future.delayed(Durations.long4);
      _controller.text = formatDate(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 300,
                          decoration: ShapeDecoration(
                            color: context.colorScheme.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            maximumYear: DateTime.now().year + 3,
                            minimumYear: DateTime.now().year,
                            onDateTimeChanged: _handleDateChange,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  hintText: "Enter a date",
                ),
                controller: _controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatDate(DateTime date) {
  List<String> months = [
    "January", // -> 0
    "February", // -> 1
    "March", // -> 2
    "April", // -> 3
    "May", // -> 4
    "June", // -> 5
    "July", // -> 6
    "August", // -> 7
    "September", // -> 8
    "October", // -> 9
    "November", // -> 10
    "December" // -> 11
  ];

  String monthName = months[date.month - 1];

  String day = date.day.toString();
  String ordinalIndicator;

  if (day.endsWith("1") && !day.endsWith("11")) {
    ordinalIndicator = "st";
  } else if (day.endsWith("2") && !day.endsWith("12")) {
    ordinalIndicator = "nd";
  } else if (day.endsWith("3") && !day.endsWith("13")) {
    ordinalIndicator = "rd";
  } else {
    ordinalIndicator = "th";
  }

  String year = date.year.toString();

  return "$monthName $day$ordinalIndicator, $year";
}
