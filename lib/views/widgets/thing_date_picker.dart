import 'package:flutter/material.dart';
import 'package:things/utils/utils.dart';

class ThingDatePicker extends StatefulWidget {
  const ThingDatePicker({
    Key? key,
    required this.placeholderText,
    this.value,
    required this.onSelect,
  }) : super(key: key);

  final String placeholderText;

  final String? value;

  final void Function(DateTime) onSelect;

  @override
  State<ThingDatePicker> createState() => _ThingDatePickerState();
}

class _ThingDatePickerState extends State<ThingDatePicker> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value ?? widget.placeholderText;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedValue,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: selectedValue == widget.placeholderText
                          ? Colors.black54
                          : Colors.white,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (time) {
        if (time == null) {
          return;
        }
        final date = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, time.hour, time.minute);
        setState(() {
          selectedValue = Utils.toReadableDateAndTime(date);
        });
        widget.onSelect(date);
      },
    );
  }
}
