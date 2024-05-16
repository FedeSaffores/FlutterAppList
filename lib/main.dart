import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TaskListPage(),
        '/add_task': (context) => AddTaskPage(),
      },
    );
  }
}

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
            child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Lista de Tareas',
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index]),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    }),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final newTask =
                  await Navigator.pushNamed(context, '/add_task') as String?;
              if (newTask != null) {
                setState(() {
                  tasks.add(newTask);
                });
              }
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.yellow,
          ),
        )),
      ),
    );
  }
}

class AddTaskPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Agregar Tarea',
        )),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Tarea',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _controller.text);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text('Agregar Tarea'))
              ],
            )));
  }
}
