import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/task.dart';

class Variables extends ChangeNotifier{
  List<Task> tasks = [];
  Map localJson = {
    "appBarText" : "Main",
    "isChoosing" : false,
    "isUpdated"  : false
  };

  Variables(){
  }

  void changeVariable(varname , value){
    localJson[varname] = value;
    notifyListeners();
  }

  void addTask(Task task){
    tasks.add(task);
    save();
    notifyListeners();
  }
  void checkTask(Task task){
    int index = tasks.indexOf(task);
    tasks[index].checked = !tasks[index].checked;
    save();
    notifyListeners();
  }

  void removeTask(Task task){
    int index = tasks.indexOf(task);
    tasks.removeAt(index);
    save();
    notifyListeners();
  }

  getTasks() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String? TaskListString = _sharedPreferences.getString("tasks");
    if(TaskListString != null){
      List Tasks = json.decode(TaskListString);
      print(Tasks);
      Tasks.forEach((value){
        tasks.add(Task(name: value['name'], checked: value['checked']));
      });
    }else{
      return [];
    }
    notifyListeners();
  }

  save() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var TaskList = [];
    tasks.forEach((element) {
      var item = {};
      item["name"] = element.name;
      item["checked"] = element.checked;
      TaskList.add(item);
    });
    _sharedPreferences.setString("tasks", json.encode(TaskList));
  }

}