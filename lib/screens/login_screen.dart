import 'package:flutter/material.dart';
import 'package:flutter_jwt/widgets/forms/forms/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's Sign your in.",
                    style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w600, height: 3),
                  ),
                  Text(
                    "Welcome back",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "You've been missed!",
                    style: TextStyle(
                        fontSize: 28, color: Colors.black54, height: 0),
                  )
                ],
              ),
            ),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
