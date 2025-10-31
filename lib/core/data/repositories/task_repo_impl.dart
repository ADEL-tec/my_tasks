import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/repositories/task_repo.dart';
import '../../values/constants.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final FirebaseFirestore firestore;

  TaskRepositoryImpl({FirebaseFirestore? firestore})
    : firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _tasksRef =>
      firestore.collection(AppConstants.FIREBASE_COLLECTION_TASKS);

  @override
  Future<void> addTask(TaskEntity task) async {
    try {
      final model = TaskModel(
        title: task.title,
        description: task.description,
        isDone: task.isDone,
        userId: task.userId,
        createdAt: task.createdAt,
        dueDate: task.dueDate,
      );

      await _tasksRef.add(model.toMap());
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    try {
      if (task.id == null) throw Exception("Task ID is null");
      final model = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        isDone: task.isDone,
        userId: task.userId,
        createdAt: task.createdAt,
        dueDate: task.dueDate,
        completeDate: task.completeDate,
      );

      // When updating we should not overwrite createdAt with server timestamp.
      // If createdAt is present, we keep it; otherwise we leave it unchanged.
      final map = model.toMap(editing: true);
      // Remove createdAt if null so update() won't set it to null.
      if (map['createdAt'] == null) map.remove('createdAt');

      await _tasksRef.doc(task.id).update(map);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksRef.doc(taskId).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  @override
  Stream<List<TaskEntity>> getTasks(String userId) {
    try {
      return _tasksRef
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) => TaskModel.fromDoc(doc)).toList();
          });
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  @override
  Future<int> getTodayTaskCount(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final querySnapshot = await _tasksRef
        .where('userId', isEqualTo: userId)
        .where('dueDate', isGreaterThanOrEqualTo: startOfDay)
        .where('dueDate', isLessThanOrEqualTo: endOfDay)
        .get();

    return querySnapshot.docs.length;
  }
}
