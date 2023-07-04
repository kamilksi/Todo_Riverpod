import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/model/task_model.dart';

import '../../home/viewmodel/home_model.dart';

class AddView extends HookConsumerWidget {
  const AddView({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    final titleEditingController = useTextEditingController();
    final descriptionEditingController = useTextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add todo"),
          backgroundColor: Colors.indigo[300],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: titleEditingController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionEditingController,
                minLines: 6,
                maxLines: 12,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              OutlinedButton(
                onPressed: () {
                  ref.read(todoProvider.notifier).add(
                        Task(
                          title: titleEditingController.text,
                          description: descriptionEditingController.text,
                          completed: 0,
                        ),
                      );
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.resolveWith(
                      (states) => const Size(350, 50)),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.indigo.shade300),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              )
            ],
          ),
        ));
  }
}
