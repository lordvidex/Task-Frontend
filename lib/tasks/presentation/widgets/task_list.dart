import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import 'task_item.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
        listener: (ctx, state) {
          if (state is TaskFailureState ||
              state is TaskDeletedState ||
              state is TaskCreatedState ||
              state is TaskStatusUpdatedState) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text((state as dynamic).message)));
          }
        },
        buildWhen: (_, to) => to is TaskLoading || to is TaskLoaded,
        builder: (ctx, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return Center(
                  child: Column(
                children: [
                  Image.asset(
                    'assets/empty.png',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  Text('Your task list is Empty,',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey))
                ],
              ));
            }
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
