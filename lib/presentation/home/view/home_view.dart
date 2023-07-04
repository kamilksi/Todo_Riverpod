import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_riverpod/presentation/add/view/add_view.dart';
import 'package:todo_riverpod/presentation/edit/view/edit_view.dart';
import 'package:todo_riverpod/presentation/home/viewmodel/home_model.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(todoProvider);
    final notifierTodos = ref.read(todoProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        centerTitle: true,
        backgroundColor: Colors.indigo[300],
      ),
      body: asyncTodos.when(
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) => Slidable(
            startActionPane: todos[index].completed == 0
                ? ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (BuildContext ctx) => Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: ((context) => EditView(
                                  todos[index].title,
                                  todos[index].description,
                                  todos[index].id!)))),
                      backgroundColor: Colors.indigo.shade300,
                      icon: CupertinoIcons.pen,
                    ),
                  ])
                : null,
            endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () => notifierTodos.delete(todos[index].id!),
                ),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext ctx) =>
                        notifierTodos.delete(todos[index].id!),
                    backgroundColor: Colors.red,
                    icon: CupertinoIcons.trash,
                  ),
                ]),
            key: const ValueKey(0),
            child: ListTile(
              title: Text(
                todos[index].title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: todos[index].completed == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough),
              ),
              subtitle: Text(
                todos[index].description,
                style: TextStyle(
                    decoration: todos[index].completed == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough),
              ),
              trailing: todos[index].completed == 0
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.indigo[300],
                      child: InkWell(
                        onTap: todos[index].completed == 0
                            ? () => ref
                                .read(todoProvider.notifier)
                                .toggle(todos[index].id!)
                            : null,
                        child: const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
        error: (err, stack) {
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
        backgroundColor: Colors.indigo.shade300,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddView(),
          ),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
