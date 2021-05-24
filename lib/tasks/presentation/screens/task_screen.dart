import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../core/styles.dart';
import '../../../injection_container.dart';
import '../bloc/task_bloc.dart';
import '../widgets/new_task.dart';
import '../widgets/task_list.dart';
import '../widgets/task_panel.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => I.get<TaskBloc>(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              useRootNavigator: true,
              builder: (_) => NewTask(),
              context: context),
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
                  label:
                      Text('Log Out', style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            children: [TaskPanel(), TaskList()],
          ),
        ),
      ),
    );
  }
}
