import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TaskListScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Map<String, String>> tasks = [
    {'title': 'Yoga class', 'description': 'bring towel, water bottle'},
    {'title': 'Blog post', 'description': 'Flutter'},
    {'title': 'Go swim!', 'description': '10 laps and more'},
    {'title': 'Buy food', 'description': 'chocolate, eggs'},
  ];

  void _addTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditTaskScreen()),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
  }

  void _editTask(int index) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTaskScreen(task: tasks[index]),
      ),
    );

    if (updatedTask != null) {
      setState(() {
        tasks[index] = updatedTask;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              height: 150,
              color: Colors.blue[800],
              padding: EdgeInsets.only(top: 40, left: 16, right: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/avatar.jpg"),
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lumei Digital',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Good software like wine, takes time',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'My Tasks',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: InkWell(
                          onTap: _addTask,
                          child: Card(
                            color: Colors.blue[800],
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              tasks[index]['title']!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(tasks[index]['description']!),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.grey),
                                  onPressed: () => _editTask(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      tasks.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddEditTaskScreen extends StatefulWidget {
  final Map<String, String>? task;

  AddEditTaskScreen({this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!['title']!;
      _descriptionController.text = widget.task!['description']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTask = {
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                };
                Navigator.pop(context, newTask);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
