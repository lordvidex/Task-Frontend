import 'package:flutter/material.dart';
import 'package:taskmanagement_frontend/tasks/presentation/bloc/task_bloc.dart';
import 'package:taskmanagement_frontend/tasks/presentation/widgets/task_status_dropdown.dart';
import '../../domain/models/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                          widget.task.id, widget.task.status));
                    })
              ]))
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
    );
  }
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
