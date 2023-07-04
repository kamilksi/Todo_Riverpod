import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/model/task_model.dart';
import 'package:todo_riverpod/presentation/home/viewmodel/home_model.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        centerTitle: true,
        backgroundColor: Colors.indigo[300],
      ),
      body: asyncTodos.when(
        data: (todos) => ListView(
          children: [
            for (final todo in todos)
              ListTile(
                title: Text(todo.title),
              )
          ],
        ),
        error: (err, stack) {
          print(err);
          return Text(
            "Error: $err",
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(todoProvider.notifier).add(
              Task(
                id: 12,
                title: "loading todo",
                description: "Hello",
                completed: 1,
              ),
            ),
      ),
    );
  }
}
