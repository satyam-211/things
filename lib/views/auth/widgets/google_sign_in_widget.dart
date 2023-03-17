import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:things/core/response_status.dart';
import 'package:things/core/routes_constants.dart';
import 'package:things/utils/utils.dart';
import 'package:things/viewmodels/auth_view_model.dart';
import 'package:things/views/auth/auth_constants.dart';

class GoogleSignInWidget extends StatefulWidget {
  const GoogleSignInWidget({Key? key}) : super(key: key);

  @override
  State<GoogleSignInWidget> createState() => _GoogleSignInWidgetState();
}

class _GoogleSignInWidgetState extends State<GoogleSignInWidget> {
  late final AuthViewModel _authViewModel;

  @override
  void initState() {
    super.initState();
    _authViewModel = context.read<AuthViewModel>();
  }

  void _signInWithGoogle() {
    _authViewModel.googleSignIn().then((signedIn) {
      if (signedIn) {
        Navigator.of(context).pushReplacementNamed(kThings);
      } else {
        if (_authViewModel.responseStatus.status == Status.error) {
          Utils.showSnackbar(
            context,
            _authViewModel.responseStatus.error,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _signInWithGoogle,
      child: Material(
        elevation: 4,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Selector<AuthViewModel, ResponseStatus>(
                selector: (_, aVM) => aVM.responseStatus,
                builder: (context, responseStatus, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      AuthConstants.kGoogleSignIn,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    if (responseStatus.status == Status.loading)
                      const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
