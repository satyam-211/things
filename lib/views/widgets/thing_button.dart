import 'package:flutter/material.dart';
import 'package:things/core/response_status.dart';

class ThingButton extends StatelessWidget {
  const ThingButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.status = Status.none,
  }) : super(key: key);

  final void Function() onPressed;

  final String text;

  final Status status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
        ),
        child: status == Status.loading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
      ),
    );
  }
}
