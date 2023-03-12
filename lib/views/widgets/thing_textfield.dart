import 'package:flutter/material.dart';
import 'package:things/core/text_field_model.dart';

class ThingTextField extends StatelessWidget {
  const ThingTextField({
    Key? key,
    required this.textFieldModel,
  }) : super(key: key);

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: textFieldModel.textEditingController,
                focusNode: textFieldModel.focusNode,
                initialValue: textFieldModel.initialValue,
                validator: textFieldModel.validator,
                onChanged: textFieldModel.validator,
                obscureText: textFieldModel.obscureText,
                cursorColor: Colors.white,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: textFieldModel.placeHolder,
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                ),
              ),
            ),
            IconButton(
              onPressed: textFieldModel.textEditingController.clear,
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
