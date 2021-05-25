import 'package:flutter/material.dart';
import 'package:taskmanagement_frontend/tasks/presentation/bloc/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/task.dart';
import 'task_status_dropdown.dart';

class TaskPanel extends StatefulWidget {
  @override
  _TaskPanelState createState() => _TaskPanelState();
}

class _TaskPanelState extends State<TaskPanel> {
  late TextEditingController _searchController;
  TaskStatus? statusQuery;

  @override
  initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  InputBorder border({bool isFocused = false}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: isFocused ? BorderSide(color: Colors.blue) : BorderSide());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(children: [
                Icon(Icons.filter_list),
                Text('Filter'),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          border: border(isFocused: true),
                          enabledBorder: border(isFocused: true),
                          hintText: 'Search within tasks...',
                          labelText: 'Search')),
                  width: 300,
                ),
                TaskStatusDropdown(
                  taskStatus: statusQuery ?? TaskStatus.ALL,
                  onPressed: (t) => setState(() => statusQuery = t),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      child: Text('Search'),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(130, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () => context.read<TaskBloc>().add(
                          FetchTasksEvent(
                              searchTerm: _searchController.text,
                              taskStatus: statusQuery?.getStringValue())),
                    )))
          ],
        ));
  }
}
