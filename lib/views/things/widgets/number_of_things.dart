import 'package:flutter/material.dart';
import 'package:things/core/response_status.dart';

class NumberOfThings extends StatelessWidget {
  const NumberOfThings({
    Key? key,
    required this.total,
    required this.thingType,
    this.status = Status.none,
  }) : super(key: key);

  final String total;
  final String thingType;
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        status == Status.loading
            ? const CircularProgressIndicator()
            : Text(
                total,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
        Text(
          thingType,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
