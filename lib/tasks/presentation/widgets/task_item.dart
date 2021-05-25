import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/task.dart';
import '../bloc/task_bloc.dart';
import 'task_status_dropdown.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  TaskItem(this.task);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          TaskDecorator(widget.task.status),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(widget.task.title),
                Text(widget.task.description),
                TaskStatusDropdown(
                    taskStatus: widget.task.status,
                    onPressed: (status) {
                      setState(() => widget.task.status = status!);
                      context.read<TaskBloc>().add(EditTaskStatusEvent(
                          widget.task.id,
                          widget.task.status,
                          widget.task.title));
                    })
              ])),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => showDeleteDialog(),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
    );
  }

  void showDeleteDialog() => showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
                'Deleting task "${widget.task.title}" is an irreversible action. Are you sure you want to go ahead?'),
            actions: [
              TextButton(
                child: Text('Dismiss',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              TextButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(DeleteTaskEvent(
                          widget.task.id,
                          widget.task.title,
                        ));
                    Navigator.of(ctx).pop();
                  },
                  style: TextButton.styleFrom(primary: Colors.red),
                  child: Text('Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )))
            ],
          ));
}

class TaskDecorator extends StatelessWidget {
  final TaskStatus status;
  TaskDecorator(this.status);
  Color mapStatusToColor() {
    switch (status) {
      case TaskStatus.OPEN:
        return Colors.red;
      case TaskStatus.IN_PROGRESS:
        return Colors.amber;
      case TaskStatus.DONE:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 100,
      // height: double.infinity,
      color: mapStatusToColor(),
    );
  }
}
