import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todoList;

  const Task(
      {required this.title,
      required this.icon,
      required this.color,
      this.todoList});

  Task copywith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todoList,
  }) =>
      Task(
          title: title ?? this.title,
          icon: icon ?? this.icon,
          color: color ?? this.color,
          todoList: todoList ?? this.todoList);

  // Encode From Json
  factory Task.fromJson(Map<String, dynamic> json) => Task(
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      todoList: json['todoList']);

  // Decode To Json
  Map<String, dynamic> toJson() =>
      {'title': title, 'icon': icon, 'color': color, 'todoList': todoList};

  @override
  // TODO: implement props
  List<Object?> get props => [title, icon, color];
}
