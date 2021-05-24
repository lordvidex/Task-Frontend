import 'package:flutter/material.dart';
import '../../domain/models/task.dart';

class TaskStatusDropdown extends StatelessWidget {
  final TaskStatus taskStatus;
  final Function(TaskStatus?)? onPressed;
  TaskStatusDropdown({
    this.taskStatus = TaskStatus.ALL,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButton(value: taskStatus, onChanged: onPressed, items: [
      DropdownMenuItem(
        child: Text(
          'Choose a task status',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        value: TaskStatus.ALL,
      ),
      ...TaskStatus.values
          .map((v) => DropdownMenuItem(
                child: Row(
                  children: [
                    if (v != TaskStatus.ALL) iconForStatus(v)!,
                    SizedBox(width: 20),
                    Text(v.getStringValue()),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                value: v,
              ))
          .toList()
            ..removeWhere((t) => t.value == TaskStatus.ALL)
    ]);
  }

  Icon? iconForStatus(TaskStatus status) {
    switch (status) {
      case TaskStatus.DONE:
        return Icon(Icons.done_all, color: Colors.green);
      case TaskStatus.IN_PROGRESS:
        return Icon(Icons.schedule, color: Colors.amber);
      case TaskStatus.OPEN:
        return Icon(Icons.pending_actions, color: Colors.red);
      default:
        return null;
    }
  }
}
