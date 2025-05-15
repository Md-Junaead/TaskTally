import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/user.dart';
import '../services/database_service.dart';

class TaskController with ChangeNotifier {
  List<Task> _tasks = [];
  User? _user;
  final DatabaseService _dbService = DatabaseService();

  List<Task> get tasks => _tasks;
  User? get user => _user;

  TaskController() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await loadUser();
    await loadTasks();
    if (_user == null) {
      final defaultUser = User(
        name: "User",
        avatar: "avatar1.png",
        points: 0,
        level: 1,
      );
      await _dbService.insertUser(defaultUser);
      await loadUser();
    }
  }

  Future<void> loadUser() async {
    _user = await _dbService.getUser();
    notifyListeners();
  }

  Future<void> loadTasks() async {
    _tasks = await _dbService.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final task = Task(title: title, status: "Not Now", points: -5);
    await _dbService.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTaskStatus(Task task, String newStatus) async {
    int newPoints =
        newStatus == "Complete"
            ? 10
            : newStatus == "Incomplete"
            ? 3
            : -5;
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      status: newStatus,
      points: newPoints,
    );
    await _dbService.updateTask(updatedTask);
    await loadTasks();
    await updateUserPoints();
  }

  Future<void> deleteTask(int id) async {
    await _dbService.deleteTask(id);
    await loadTasks();
    await updateUserPoints();
  }

  Future<void> updateUserPoints() async {
    int totalPoints = _tasks.fold(0, (sum, task) => sum + task.points);
    int level = (totalPoints ~/ 300) + 1;
    if (_user != null) {
      final updatedUser = User(
        id: _user!.id,
        name: _user!.name,
        avatar: _user!.avatar,
        points: totalPoints,
        level: level,
      );
      await _dbService.updateUser(updatedUser);
      await loadUser();
    }
  }

  Future<void> updateUserProfile(String name, String avatar) async {
    if (_user != null) {
      final updatedUser = User(
        id: _user!.id,
        name: name,
        avatar: avatar,
        points: _user!.points,
        level: _user!.level,
      );
      await _dbService.updateUser(updatedUser);
      await loadUser();
    }
  }
}
