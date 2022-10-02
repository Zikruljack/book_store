import 'package:book_store/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestingWidgetJson extends StatefulWidget {
  const TestingWidgetJson({super.key});

  @override
  State<TestingWidgetJson> createState() => _TestingWidgetJsonState();
}

class _TestingWidgetJsonState extends State<TestingWidgetJson> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Center(
        child: Text(user.toJson()),
      ),
    );
  }
}
