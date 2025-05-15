import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controllers/task_controller.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context, listen: false);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text('Status: ${task.status} | Points: ${task.points}'),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) async {
            if (value == 'Delete') {
              bool? confirm = await showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text(
                        'Are you sure you want to delete this task?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
              );
              if (confirm == true) {
                await taskController.deleteTask(task.id!);
              }
            } else {
              await taskController.updateTaskStatus(task, value);
            }
          },
          itemBuilder:
              (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Complete',
                  child: Text('Complete'),
                ),
                const PopupMenuItem<String>(
                  value: 'Incomplete',
                  child: Text('Incomplete'),
                ),
                const PopupMenuItem<String>(
                  value: 'Not Now',
                  child: Text('Not Now'),
                ),
                const PopupMenuItem<String>(
                  value: 'Delete',
                  child: Text('Delete'),
                ),
              ],
        ),
      ),
    );
  }
}
