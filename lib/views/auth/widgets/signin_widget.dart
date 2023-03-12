import 'package:flutter/material.dart';
import 'package:things/core/routes_constants.dart';
import 'package:things/core/text_field_model.dart';
import 'package:things/utils/utils.dart';
import 'package:things/viewmodels/auth_view_model.dart';
import 'package:things/views/auth/auth_constants.dart';
import 'package:things/views/widgets/thing_button.dart';
import 'package:things/views/widgets/thing_textfield.dart';
import 'package:provider/provider.dart';

import 'package:things/core/response_status.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final AuthViewModel _authViewModel;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authViewModel = context.read<AuthViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AuthViewModel, Status>(
      selector: (_, authVM) => authVM.responseStatus.status,
      builder: (context, status, _) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: FocusScope.of(context).unfocus,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ThingTextField(
                textFieldModel: TextFieldModel(
                  focusNode: FocusNode(),
                  textEditingController: _emailController,
                  placeHolder: AuthConstants.kEmail,
                  validator: null,
                ),
              ),
              ThingTextField(
                textFieldModel: TextFieldModel(
                  focusNode: FocusNode(),
                  textEditingController: _passwordController,
                  placeHolder: AuthConstants.kPassword,
                  validator: null,
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ThingButton(
                onPressed: _signIn,
                text: AuthConstants.kSignIn,
                status: status,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState?.validate() ?? false) {
      final userEmail = _emailController.text;
      final userPassword = _passwordController.text;
      _authViewModel.signIn(userEmail, userPassword).then((signedIn) {
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
  }
}
