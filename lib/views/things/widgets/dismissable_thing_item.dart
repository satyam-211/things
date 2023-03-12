import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:things/models/thing.dart';
import 'package:things/utils/utils.dart';
import 'package:things/viewmodels/things_view_model.dart';
import 'package:things/views/things/things_constants.dart';

class DismissableThingItem extends StatefulWidget {
  const DismissableThingItem({
    super.key,
    required this.myThing,
  });

  final Thing myThing;

  @override
  State<DismissableThingItem> createState() => _DismissableThingItemState();
}

class _DismissableThingItemState extends State<DismissableThingItem> {
  late final ThingViewModel _thingViewModel;

  @override
  void initState() {
    super.initState();
    _thingViewModel = context.read<ThingViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.myThing.id),
      onDismissed: (direction) {
        switch (direction) {
          case DismissDirection.startToEnd:
            _thingViewModel.updateIsDone(widget.myThing);
            return;
          case DismissDirection.endToStart:
            _thingViewModel.deleteThing(widget.myThing.id!);
            return;
          default:
            return;
        }
      },
      background: ColoredBox(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              ThingsConstants.kCompleted,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Icon(
              Icons.arrow_right_alt,
              color: Colors.blueAccent,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
      secondaryBackground: ColoredBox(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              ThingsConstants.kDelete,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Icon(
              Icons.delete,
              color: Colors.blueAccent,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
      child: ListTile(
        leading: Icon(widget.myThing.type?.icon),
        title: Text(widget.myThing.description ?? ''),
        subtitle: Text(widget.myThing.place ?? ''),
        trailing: Text(
          Utils.toReadableTime(
            widget.myThing.time ?? DateTime.now(),
          ),
        ),
      ),
    );
  }
}

extension IconForThingType on ThingType {
  IconData get icon {
    switch (this) {
      case ThingType.personal:
        return Icons.person;
      case ThingType.business:
        return Icons.business;
    }
  }
}
