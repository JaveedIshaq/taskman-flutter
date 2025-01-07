import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/task_model.dart';
import 'package:http/http.dart' as http;

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  bool isLoading = false;
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tasks List'),
              ),
              if (isLoading) CircularProgressIndicator() else SizedBox(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index].title ?? ""),
                    subtitle: Text(tasks[index].description ?? ""),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTasks() async {
    setState(() {
      isLoading = true;
    });

    FlutterSecureStorage secureStorage = const FlutterSecureStorage();

    final url = Uri.parse('https://dev.farabicoders.com/tasks');
    final token = await secureStorage.read(key: 'token');

    print("the Token from secure storage is: $token");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print(data);

        tasks = (data['data'] as List).map((e) => Task.fromJson(e)).toList();
      } else {
        print('Login failed: ${response.body}');
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      // Handle network or other errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
