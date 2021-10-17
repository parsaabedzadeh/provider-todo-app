import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provoider_test1/models/task.dart';
import 'package:provoider_test1/widgets/task_row.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../variables.dart';

class HomePage extends StatelessWidget {
  var variables;

  @override
  Widget build(BuildContext context) {
    variables = Provider.of<Variables>(context);
    if (!variables.localJson['isUpdated']) {
      variables.getTasks();
      variables.changeVariable("isUpdated", true);
    }
    TextEditingController _TaskName = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          variables.localJson['appBarText'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "TO DO APP",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Colors.white,
              ),
              child: variables.tasks.length > 0
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: variables.tasks.length,
                      itemBuilder: (context, index) {
                        return TaskRow(task: variables.tasks[index]);
                      },
                    )
                  : Center(
                      child: Image.asset("assets/notFound.png"),
                    ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Center(
                    child: Text(
                      "Add new Task",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _TaskName,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "Name"),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          if (_TaskName.text.isNotEmpty) {
                            variables.addTask(
                                Task(name: _TaskName.text, checked: false));
                            Navigator.of(context).pop();
                          } else {
                            return;
                          }
                        },
                        child: const Text("ADD"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
