// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      title: json['title'] as String,
      description: json['description'] as String,
      completed: json['completed'] as int,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'completed': instance.completed,
    };
