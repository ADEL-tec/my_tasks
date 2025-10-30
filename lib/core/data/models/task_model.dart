import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    super.id,
    required super.title,
    super.description,
    super.isDone = false,
    required super.userId,
    required super.createdAt,
    required super.dueDate,
    super.completeDate,
  });

  Map<String, dynamic> toMap({bool editing = false}) {
    final map = {
      'title': title,
      'description': description,
      'isDone': isDone,
      'userId': userId,
      'createdAt': !editing ? FieldValue.serverTimestamp() : createdAt,
      'dueDate': dueDate,
      'completeDate': completeDate,
    };

    return map;
  }

  factory TaskModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    final createdField = data['createdAt'];
    final dueFieldField = data['dueDate'];
    final completedField = data['completeDate'];

    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'],
      isDone: data['isDone'] ?? false,
      userId: data['userId'] ?? '',
      createdAt: createdField?.toDate(),
      dueDate: dueFieldField?.toDate(),
      completeDate: completedField?.toDate(),
    );
  }
}
