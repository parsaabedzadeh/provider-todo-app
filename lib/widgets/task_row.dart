import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provoider_test1/models/task.dart';

import '../variables.dart';

class TaskRow extends StatelessWidget {
  Task task;
  TaskRow({required this.task});
  @override
  Widget build(BuildContext context) {
    var variables = Provider.of<Variables>(context);
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    task.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
              Checkbox(value: task.checked, onChanged: (value){
                variables.checkTask(task);
              }),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  variables.removeTask(task);
                },
                icon: const Icon(Icons.delete , color: Colors.red,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

