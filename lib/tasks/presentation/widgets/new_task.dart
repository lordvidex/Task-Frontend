import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  // title
  TextEditingController? _titleController;

  // description
  TextEditingController? _descController;

  @override
  void initState() {
    this._titleController = TextEditingController();
    this._descController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Create a new Task'),
        TextField(
          controller: _titleController,
        ),
        TextField(
          controller: _descController,
        ),
        ElevatedButton(
            child: Text('Create Task'),
            onPressed: () {
              context.read<TaskBloc>().add(CreateTaskEvent(
                  title: _titleController!.text,
                  description: _descController!.text));
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
