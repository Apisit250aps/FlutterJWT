import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_jwt/widgets/forms/inputs/password_input.dart';
import 'package:flutter_jwt/widgets/forms/inputs/username_input.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('https://wallet-api-7m1z.onrender.com/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String token = responseData['token'];
      // Decode the JWT token
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      // Assuming the username is stored in the token payload
      final String username = decodedToken['username'];

      // Show a dialog with the greeting message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Boxicons.bxs_check_circle,
                    size: 64,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Login Success!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEA4C89),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(token),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Color(0xFFEA4C89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Accept"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      // Handle login failure here
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String error = responseData['error'];
      // Assuming the JWT token is returned under 'token'
      // Show a dialog with the greeting message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Boxicons.bxs_x_circle,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Login Fail!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEA4C89),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    error,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Color(0xFFEA4C89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Accept'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          UsernameInput(controller: _usernameController),
          PasswordInput(controller: _passwordController),
          const Divider(
            height: 25,
          ),
          SubmitButton(
            label: "LOGIN",
            onPressed: _login,
          )
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SubmitButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black45, width: 1.5),
          borderRadius: BorderRadius.circular(20.0),
          color: const Color.fromARGB(255, 24, 24, 24)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(22.25),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
