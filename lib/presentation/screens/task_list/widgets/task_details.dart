import 'package:flutter/material.dart';
import '../../../../domain/entities/task_entity.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(this.task, {super.key});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.title),
              title: Text('Title'),
              subtitle: Text(task.title),
            ),
            if (task.description != null && task.description!.isNotEmpty)
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Description'),
                subtitle: Text(task.description!),
              ),
            ListTile(
              leading: Icon(task.isDone ? Icons.check_circle : Icons.pending),
              title: Text('Status'),
              subtitle: Text(task.isDone ? 'Done' : 'Not Done'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Created At'),
              subtitle: Text(
                task.createdAt != null ? task.createdAt.toString() : '-',
              ),
            ),
            if (task.dueDate != null)
              ListTile(
                leading: Icon(Icons.event),
                title: Text('Due Date'),
                subtitle: Text(task.dueDate.toString()),
              ),
          ],
        ),
      ),
    );
  }
}
