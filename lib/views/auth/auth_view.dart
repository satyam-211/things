import 'package:flutter/material.dart';
import 'package:things/views/auth/auth_constants.dart';
import 'package:things/views/auth/widgets/signin_widget.dart';
import 'package:things/views/auth/widgets/signup_widget.dart';

class AuthView extends StatelessWidget {
  static const _totalTabs = 2;
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _totalTabs,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AuthConstants.kThings,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: AuthConstants.kSignIn,
              ),
              Tab(
                text: AuthConstants.kSignUp,
              ),
            ],
          ),
          backgroundColor: Colors.blueAccent,
        ),
        backgroundColor: Colors.blueAccent,
        body: const TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SignInWidget(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SignUpWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
