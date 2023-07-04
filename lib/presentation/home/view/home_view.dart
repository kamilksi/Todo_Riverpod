import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:todo_riverpod/model/task_model.dart';
import 'package:todo_riverpod/presentation/add/view/add_view.dart';
import 'package:todo_riverpod/presentation/home/viewmodel/home_model.dart';

class HomeView extends HookConsumerWidget {
  HomeView({super.key});

  var logger = Logger();
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
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              todos[index].title,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              todos[index].description,
            ),
            trailing: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.indigo[300],
              child: InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        error: (err, stack) {
          logger.e(err);
          return Center(
            child: Text(
              "Error: $err, \n\nstacktrace: $stack",
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddView(),
          ),
        ),
      ),
    );
  }
}
