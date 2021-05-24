import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import 'task_item.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(listener: (ctx, state) {
      if (state is TaskFailureState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    }, builder: (ctx, state) {
      if (state is TaskLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is TaskLoaded) {
        return Expanded(
            child: ListView.builder(
          itemBuilder: (ctx, index) => TaskItem(state.tasks[index]),
          itemCount: state.tasks.length,
        ));
      }
      return Container();
    });
  }
}
