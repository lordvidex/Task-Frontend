import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/styles.dart';
import '../bloc/task_bloc.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  // title
  late TextEditingController _titleController;

  // description
  late TextEditingController _descController;

  // form key
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    this._titleController = TextEditingController();
    this._descController = TextEditingController();
    this._formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  String? validateField(String? str) {
    if (str == null || str.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Create a new Task', style: TextStyle().headerText),
              TextFormField(
                  controller: _titleController,
                  validator: validateField,
                  decoration: InputDecoration(hintText: 'Task Title')),
              TextFormField(
                  controller: _descController,
                  validator: validateField,
                  decoration: InputDecoration(hintText: 'Task description')),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                    child: Text('Create Task'),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      context.read<TaskBloc>().add(CreateTaskEvent(
                          title: _titleController.text,
                          description: _descController.text));
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
