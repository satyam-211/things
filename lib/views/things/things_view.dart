import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:things/core/response_status.dart';
import 'package:things/core/routes_constants.dart';
import 'package:things/models/thing.dart';
import 'package:things/utils/utils.dart';
import 'package:things/viewmodels/auth_view_model.dart';
import 'package:things/viewmodels/things_view_model.dart';
import 'package:things/views/things/things_constants.dart';
import 'package:things/views/things/widgets/dismissable_thing_item.dart';
import 'package:things/views/things/widgets/number_of_things.dart';

class ThingsView extends StatefulWidget {
  const ThingsView({Key? key}) : super(key: key);

  @override
  State<ThingsView> createState() => _ThingsViewState();
}

class _ThingsViewState extends State<ThingsView> {
  late final AuthViewModel _authViewModel;
  late final ThingViewModel _thingViewModel;

  @override
  void initState() {
    super.initState();
    _authViewModel = context.read<AuthViewModel>();
    _thingViewModel = context.read<ThingViewModel>();
    _thingViewModel
      ..getThings()
      ..getThings(true);
  }

  @override
  Widget build(BuildContext context) {
    final authViewStatus = _authViewModel.responseStatus.status;
    final thingViewStatus = _thingViewModel.responseStatus.status;
    if (authViewStatus == Status.error) {
      Utils.showSnackbar(
        context,
        _authViewModel.responseStatus.error,
      );
    } else if (thingViewStatus == Status.error) {
      Utils.showSnackbar(
        context,
        _thingViewModel.responseStatus.error,
      );
    }
    return Scaffold(
      body: Selector<ThingViewModel, ResponseStatus>(
        selector: (_, tVM) => tVM.responseStatus,
        builder: (context, responseStatus, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      ThingsConstants.bgImagePath,
                      color: Colors.black54,
                      colorBlendMode: BlendMode.darken,
                    ),
                    Positioned.fill(
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ThingsConstants.kHeading,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                    Text(
                                      Utils.toReadableDate(
                                        DateTime.now(),
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        _authViewModel.signOut().then(
                                      (signedOut) {
                                        if (signedOut) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(kAuth);
                                        }
                                      },
                                    ),
                                    icon: const Tooltip(
                                      message: ThingsConstants.kLogout,
                                      child: Icon(
                                        Icons.logout,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  Row(
                                    children: [
                                      NumberOfThings(
                                        thingType: ThingsConstants.kPersonal,
                                        status: responseStatus.status,
                                        total:
                                            '${_thingViewModel.personalThings}',
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      NumberOfThings(
                                        thingType: ThingsConstants.kBusiness,
                                        status: responseStatus.status,
                                        total:
                                            '${_thingViewModel.businessThings}',
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${_thingViewModel.completedThings.length} Done',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ThingsConstants.kInbox,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _thingViewModel.incompleteThings.length,
                      itemBuilder: (context, index) {
                        final myThing = _thingViewModel.incompleteThings[index];
                        return InkWell(
                          onTap: () => navigateToAddThing(myThing),
                          child: DismissableThingItem(
                            myThing: myThing,
                          ),
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      ThingsConstants.kCompleted,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: responseStatus.status == Status.loading
                            ? const CircularProgressIndicator()
                            : Text(
                                _thingViewModel.completedThings.length
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _thingViewModel.completedThings.length,
                  itemBuilder: (context, index) {
                    final myThing = _thingViewModel.completedThings[index];
                    return ListTile(
                      leading: Icon(myThing.type?.icon),
                      title: Text(myThing.description ?? ''),
                      subtitle: Text(myThing.place ?? ''),
                      trailing: Text(
                        Utils.toReadableDate(
                          myThing.time ?? DateTime.now(),
                        ),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: navigateToAddThing,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  void navigateToAddThing([Thing? thing]) {
    Navigator.of(context).pushNamed(
      kAddThing,
      arguments: thing,
    );
  }
}
