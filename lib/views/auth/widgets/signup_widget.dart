import 'package:flutter/material.dart';
import 'package:things/core/response_status.dart';
import 'package:things/core/routes_constants.dart';
import 'package:things/core/text_field_model.dart';
import 'package:things/utils/utils.dart';
import 'package:things/viewmodels/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:things/views/auth/auth_constants.dart';
import 'package:things/views/widgets/thing_button.dart';
import 'package:things/views/widgets/thing_textfield.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final AuthViewModel _authViewModel;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
        onTap: FocusScope.of(context).unfocus,
        behavior: HitTestBehavior.translucent,
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
              ThingTextField(
                textFieldModel: TextFieldModel(
                  focusNode: FocusNode(),
                  textEditingController: _confirmPasswordController,
                  placeHolder: AuthConstants.kConfirmPassword,
                  validator: null,
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ThingButton(
                onPressed: _signUp,
                text: AuthConstants.kSignUp,
                status: status,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      final userEmail = _emailController.text;
      final userPassword = _passwordController.text;
      final confirmedPassword = _confirmPasswordController.text;
      if (userPassword != confirmedPassword) {
        return;
      }
      _authViewModel.signUp(userEmail, userPassword).then((signedUp) {
        if (signedUp) {
          Navigator.of(context).pushReplacementNamed(kThings);
        } else if (_authViewModel.responseStatus.status == Status.error) {
          Utils.showSnackbar(
            context,
            _authViewModel.responseStatus.error,
          );
        }
      });
    }
  }
}
