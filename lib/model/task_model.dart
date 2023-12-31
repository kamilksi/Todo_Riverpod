// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class Task with _$Task {
  factory Task({
    int? id,
    required String title,
    required String description,
    required int completed,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
