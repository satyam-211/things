import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:things/core/response_status.dart';
import 'package:things/core/text_field_model.dart';
import 'package:things/models/thing.dart';
import 'package:things/utils/utils.dart';
import 'package:things/viewmodels/things_view_model.dart';
import 'package:things/views/things/things_constants.dart';
import 'package:things/views/widgets/thing_button.dart';
import 'package:things/views/widgets/thing_date_picker.dart';
import 'package:things/views/widgets/thing_dropdown.dart';
import 'package:things/views/widgets/thing_textfield.dart';

class AddThingView extends StatefulWidget {
  const AddThingView({
    Key? key,
    this.thing,
  }) : super(key: key);

  final Thing? thing;

  @override
  State<AddThingView> createState() => _AddThingViewState();
}

class _AddThingViewState extends State<AddThingView> {
  late Thing thing;

  late ThingViewModel _thingViewModel;

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool editMode = false;

  final _descriptionController = TextEditingController();
  final _placeController = TextEditingController();

  ThingType? thingType;
  DateTime? time;
  DateTime? notification;

  @override
  void initState() {
    super.initState();
    editMode = widget.thing != null;
    thing = widget.thing ?? const Thing();
    _descriptionController.text = thing.description ?? '';
    _placeController.text = thing.place ?? '';
    thingType = thing.type;
    time = thing.time;
    notification = thing.notification;
    _thingViewModel = context.read<ThingViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editMode
              ? ThingsConstants.kEditYourThing
              : ThingsConstants.kAddNewThing,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.list_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ThingDropdown(
                  onChanged: (thingTypeSelected) =>
                      thingType = thingTypeSelected,
                  selectedValue: thing.type,
                ),
                ThingTextField(
                  textFieldModel: TextFieldModel(
                    placeHolder: ThingsConstants.kDescription,
                    textEditingController: _descriptionController,
                    focusNode: FocusNode(),
                    validator: null,
                  ),
                ),
                ThingTextField(
                  textFieldModel: TextFieldModel(
                    placeHolder: ThingsConstants.kPlace,
                    textEditingController: _placeController,
                    focusNode: FocusNode(),
                    validator: null,
                  ),
                ),
                ThingDatePicker(
                  placeholderText: ThingsConstants.kTime,
                  value: editMode
                      ? Utils.toReadableDateAndTime(thing.time!)
                      : null,
                  onSelect: (dateSelected) => time = dateSelected,
                ),
                ThingDatePicker(
                  placeholderText: ThingsConstants.kNotification,
                  value: editMode
                      ? Utils.toReadableDateAndTime(thing.notification!)
                      : null,
                  onSelect: (dateSelected) => notification = dateSelected,
                ),
                const SizedBox(
                  height: 20,
                ),
                ThingButton(
                  onPressed: _addThing,
                  text: editMode
                      ? ThingsConstants.kEditYourThing
                      : ThingsConstants.kAddNewThing,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addThing() {
    if (_formKey.currentState?.validate() ?? false) {
      final newThing = Thing(
        id: editMode ? thing.id : Utils.getRandomId(),
        type: thingType,
        time: time,
        notification: notification,
        place: _placeController.text,
        description: _descriptionController.text,
      );
      if (editMode) {
        _thingViewModel.updateThing(thing.id!, newThing).then(
          (_) {
            if (_thingViewModel.responseStatus.status == Status.error) {
              Utils.showSnackbar(
                context,
                _thingViewModel.responseStatus.error,
              );
            }
          },
        );
      } else {
        _thingViewModel.addThing(newThing).then(
          (_) {
            if (_thingViewModel.responseStatus.status == Status.error) {
              Utils.showSnackbar(
                context,
                _thingViewModel.responseStatus.error,
              );
            }
          },
        );
      }
      Navigator.of(context).pop();
    }
  }
}
