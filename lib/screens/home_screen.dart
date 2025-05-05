// screens/home_screen.dart
/*

// screens/home_screen.dart
import 'package:crud_func_app/helper/api_helper.dart';
import 'package:crud_func_app/helper/todo_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Todo>> todos;

  @override
  void initState() {
    super.initState();
    todos = fetchTodos();
  }

  void _showAddTodoDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Todo"),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Todo newTodo = Todo(
                  id: "",
                  title: titleController.text,
                  description: descriptionController.text,
                  status: false,
                );

                bool success = await addTodo(newTodo);
                if (success) {
                  setState(() {
                    todos = fetchTodos();
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateTodoDialog(Todo todo) {
    TextEditingController titleController = TextEditingController(text: todo.title);
    TextEditingController descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Todo"),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Todo updatedTodo = Todo(
                  id: todo.id,
                  title: titleController.text,
                  description: descriptionController.text,
                  status: todo.status,
                );

                bool success = await updateTodo(todo.id, updatedTodo);
                if (success) {
                  setState(() {
                    todos = fetchTodos();
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTodoDialog(Todo todo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Todo"),
          content: Text("Are you sure you want to delete this todo?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                bool success = await deleteTodo(todo.id);
                if (success) {
                  setState(() {
                    todos = fetchTodos();
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FastAPI Todos")),
      body: FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Todos Found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final todo = snapshot.data![index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: Checkbox(
                  value: todo.status,
                  onChanged: (val) {
                    setState(() {
                      todo.status = val ?? false; // If val is null, set to false
                    });
                    _showUpdateTodoDialog(todo); // Trigger update dialog after status change
                  },
                ),
                onLongPress: () => _showDeleteTodoDialog(todo),
                onTap: () => _showUpdateTodoDialog(todo),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

*/


import 'package:crud_func_app/helper/api_helper.dart';
import 'package:crud_func_app/helper/todo_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Todo>> todos;

  @override
  void initState() {
    super.initState();
    todos = fetchTodos();  // Fetch initial todos list
  }

  // Show Add Todo dialog
  void _showAddTodoDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Todo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                Todo newTodo = Todo(
                  id: "",  // New todo ID will be assigned by the backend
                  title: titleController.text,
                  description: descriptionController.text,
                  status: false,
                );

                bool success = await addTodo(newTodo);
                if (success) {
                  setState(() {
                    todos = fetchTodos();  // Refresh the list of todos
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Add Todo"),
            ),
          ],
        );
      },
    );
  }

  // Show Update Todo dialog
  void _showUpdateTodoDialog(Todo todo) {
    TextEditingController titleController = TextEditingController(text: todo.title);
    TextEditingController descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Todo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                Todo updatedTodo = Todo(
                  id: todo.id,
                  title: titleController.text,
                  description: descriptionController.text,
                  status: todo.status,
                );

                bool success = await updateTodo(todo.id, updatedTodo);
                if (success) {
                  setState(() {
                    todos = fetchTodos();  // Refresh the list of todos after update
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Update Todo"),
            ),
          ],
        );
      },
    );
  }

  // Show Delete Todo dialog
  void _showDeleteTodoDialog(Todo todo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Todo", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Are you sure you want to delete this todo?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                bool success = await deleteTodo(todo.id);
                if (success) {
                  setState(() {
                    todos = fetchTodos();  // Refresh the list of todos after deletion
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("FastAPI Todos", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Todos Found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final todo = snapshot.data![index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(todo.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text(todo.description, style: TextStyle(fontSize: 14)),
                  trailing: IconButton(
                    icon: Icon(todo.status ? Icons.check_circle : Icons.circle_outlined, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        todo.status = !todo.status; // Toggle the status
                      });
                      _showUpdateTodoDialog(todo); // Trigger update dialog after status change
                    },
                  ),
                  onLongPress: () => _showDeleteTodoDialog(todo), // Delete on long press
                  onTap: () => _showUpdateTodoDialog(todo), // Update on tap
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog, // Show add todo dialog on FAB press
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}
