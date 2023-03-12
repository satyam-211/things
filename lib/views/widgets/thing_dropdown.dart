import 'package:flutter/material.dart';
import 'package:things/models/thing.dart';
import 'package:things/views/things/things_constants.dart';

class ThingDropdown extends StatelessWidget {
  const ThingDropdown({
    Key? key,
    required this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  final ThingType? selectedValue;

  final void Function(ThingType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ThingType>(
      items: ThingType.values
          .map(
            (type) => DropdownMenuItem<ThingType>(
              value: type,
              child: Text(type.name),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        hintText: ThingsConstants.kSelectType,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black54,
            ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      dropdownColor: Colors.blueAccent,
      iconEnabledColor: Colors.white,
      onChanged: onChanged,
      value: selectedValue,
    );
  }
}
