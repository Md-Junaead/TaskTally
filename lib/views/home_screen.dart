import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_card.dart';
import 'task_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskTally'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (taskController.user != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/${taskController.user!.avatar}',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, ${taskController.user!.name}!',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Level: ${taskController.user!.level} | Points: ${taskController.user!.points}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      LinearProgressIndicator(
                        value: (taskController.user!.points % 300) / 300.0,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child:
                taskController.tasks.isEmpty
                    ? const Center(child: Text('No tasks yet. Add one!'))
                    : ListView.builder(
                      itemCount: taskController.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskController.tasks[index];
                        return TaskCard(task: task);
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
