import 'package:flutter/material.dart';
import 'package:frontend/screens/dashboard_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:window_manager/window_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final loginFocus = FocusNode();

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/login"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({
          "username": usernameController.text,
          "password": passwordController.text,
        }),
      );
      final data = jsonDecode(response.body);

      if (data["success"]) {
        await windowManager.maximize();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: ((context) => const DashboardScreen())),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Connection error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Center(
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "TailorOS",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  const Text(
                    "Tailor Management System",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: usernameController,
                    focusNode: usernameFocus,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(loginFocus);
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          focusNode: loginFocus,
                          onPressed: () async {
                            await login();
                          },
                          child: const Text("login"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text("Exit"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
