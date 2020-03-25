import 'package:flutter/foundation.dart';
import 'task.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TaskData extends ChangeNotifier {
  static const String kFileName = 'tasks7.json';

  List<Task> _listOfTasks = [
    //Task(name: 'Buy milk'),
  ];

  bool _fileExists = false;
  File _filePath;

  // First initialization of _json (if there is no json in the file)
  Map<dynamic, dynamic> _json = {};
  String _jsonListString;

  // Initialization of List<_jsons>
  List<dynamic> _jsonList = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$kFileName');
  }

  void _writeJsonRecord(List<dynamic> _jsonInput) {
    // Initialize the local _filePath
    //final _filePath = await _localFile;

    // 0. Get the _json
    print('1.(_writeJsonRecord) _json: $_jsonInput');

    // 2. Convert _jsonList->_jsonListString
    _jsonListString = jsonEncode(_jsonInput);
    print('2.(_writeJsonRecord) _jsonListString: $_jsonListString \n \n -');

    // 3. Write _jsonListString into the file
    _filePath.writeAsString(_jsonListString);
  }

  void _updateJson(String key, dynamic value) {
    // Initialize the local _filePath
    // final _filePath = await _localFile;

    //1. Create _newJsonPair<Map> from input<TextField>
    Map<String, dynamic> _newJsonPair = {key: value};
    print('1.(_writeJson) _newJsonPair: $_newJsonPair');

    //2. Update _json by adding _newJsonPair<Map> -> _json<Map>
    print('2a.(_writeJson) _json(before being updated): $_json');
    _json.addAll(_newJsonPair);
    print('2b.(_writeJson) _json(updated): $_json \n\n -');
  }

  void _updateJsonList() {
    _jsonList.clear();
    for (Task task in _listOfTasks) {
      print('task: $task \t _listOfTasks: $_listOfTasks');
      _updateJson('name', task.name);
      _updateJson('isDone', task.isDone);
      _jsonList.add(_json);
      _json = {};
      print('_jsonList: $_jsonList');
    }
  }

  void readJson() async {
    print('Checkpoint 1');

    // Initialize _filePath
    _filePath = await _localFile;
    print('0. (readJson) _filepath: $_filePath');

    // 0. Check whether the _file exists
    _fileExists = await _filePath.exists();
    print('0. File exists? $_fileExists');

    //1. If the _file exists->read it: update initialized _json by what's in the _file
    if (_fileExists) {
      try {
        //1. Read _jsonListString<String> from the _file.
        _jsonListString = await _filePath.readAsString();
        print('1.(readJson) _jsonListString: $_jsonListString');

        //2. Update initialized _jsonList by converting _jsonListString<String>->_jsonList<Map>
        _jsonList = jsonDecode(_jsonListString);
        print('2.(readJson) _jsonList: $_jsonList');

        for (Map _json in _jsonList) {
          _listOfTasks.add(Task(name: _json['name'], isDone: _json['isDone']));
          print('_json.containsKey(\'name\'): ${_json['name']}');
        }
        print('3. (readJson) _listOfTasks: ${_listOfTasks.length}');
      } catch (e) {
        // Print exception errors
        print('Tried reading _file error: $e');
        // If encountering an error, return null
      }
    }
  }

  UnmodifiableListView<Task> get listOfTasks =>
      UnmodifiableListView(_listOfTasks);

  String getTaskName(int index) => _listOfTasks[index].name;
  bool getIsDone(int index) => _listOfTasks[index].isDone;

  void addTask(String newTaskName) async {
    _listOfTasks.add(Task(name: newTaskName));
    for (Task task in _listOfTasks)
      print('Task.name: ${task.name}\t Task.isDone: ${task.isDone}');
    print('\n');

    _updateJsonList();
    _writeJsonRecord(_jsonList);

    notifyListeners();
  }

  void updateTaskStatus(Task task) {
    task.toggleCheck();
    for (Task task in _listOfTasks)
      print('Task.name: ${task.name}\t Task.isDone: ${task.isDone}');
    print('\n');
    _updateJsonList();
    _writeJsonRecord(_jsonList);

    notifyListeners();
  }

  void removeTask(Task task) {
    _listOfTasks.remove(task);
    for (Task task in _listOfTasks)
      print('Task.name: ${task.name}\t Task.isDone: ${task.isDone}');
    print('\n');

    _updateJsonList();
    _writeJsonRecord(_jsonList);

    notifyListeners();
  }

  void refreshList() {
    List<Task> toBeRemoved = [];
    for (Task task in _listOfTasks) {
      if (task.isDone) {
        toBeRemoved.add(task);
      }
    }

    for (Task task in toBeRemoved) {
      print('Remove task 0');
      removeTask(task);
    }

    notifyListeners();
  }

  int get tasksLength => _listOfTasks.length;
}
