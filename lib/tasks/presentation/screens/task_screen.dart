import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../core/styles.dart';
import '../widgets/new_task.dart';
import '../widgets/task_list.dart';
import '../widgets/task_panel.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (ctx) => ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text('Create Task'), Icon(Icons.add)],
          ),
          onPressed: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  side: BorderSide(color: Colors.blue, width: 4)),
              builder: (_) => NewTask(),
              context: ctx),
        ),
      ),
      backgroundColor: CustomColors.backgroundGrey,
      appBar: AppBar(
        title: Text('Your Tasks'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
                onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text('Log Out', style: TextStyle(color: Colors.white))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [TaskPanel(), TaskList()],
        ),
      ),
    );
  }
}
