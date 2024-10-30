import 'package:flutter/material.dart';

import '../todo.dart';
import '../colors.dart';
import '../todo_items.dart';

class Home extends StatefulWidget {
Home({Key? key}) : super(key: key);

@override
State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
final todosList = ToDo.todoList();
List<ToDo> _foundToDo = [];
final _todoController = TextEditingController();

@override
void initState() {
_foundToDo = todosList;
super.initState();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color.fromARGB(255, 80, 118, 135),
appBar: _buildAppBar(),
body: Stack(
children: [
Container(
padding: EdgeInsets.symmetric(
horizontal: 20,
vertical: 15,
),
child: Column(
children: [
searchBox(),
Expanded(
child: ListView(
children: [
Container(
margin: EdgeInsets.only(
top: 30,
bottom: 20,
),
child: Text(
'All ToDos',
style: TextStyle(
fontSize: 30,
fontWeight: FontWeight.w500,
),
),
),
for (ToDo todoo in _foundToDo.reversed)
ToDoItem(
todo: todoo,
onToDoChanged: _handleToDoChange,
onDeleteItem: _deleteToDoItem, onTap: () {
},
),
],
),
),
// Container with TextField and Button in the bottom-right
Align(
alignment: Alignment.bottomCenter,
child: Row(
children: [
Expanded(
child: Container(
margin: EdgeInsets.only(
bottom: 20,
right: 20,
left: 20,
),
padding: EdgeInsets.symmetric(
horizontal: 20,
vertical: 5,
),
decoration: BoxDecoration(
color: Color.fromARGB(255, 255, 255, 255),
boxShadow: const [
BoxShadow(
color: Colors.black26,
offset: Offset(0.0, 0.0),
blurRadius: 10.0,
spreadRadius: 0.0,
),
],
borderRadius: BorderRadius.circular(10),
),
child: TextField(
controller: _todoController,
decoration: InputDecoration(
hintText: 'Add a new todo item',
border: InputBorder.none,
),
),
),
),
Container(
margin: EdgeInsets.only(
bottom: 20,
right: 20,
),
child: ElevatedButton(
onPressed: () {
_addToDoItem(_todoController.text);
},
style: ElevatedButton.styleFrom(
backgroundColor: Color.fromARGB(255, 56,
75, 112),
minimumSize: Size(20,20),
elevation: 10,
),
child: Text(
'+',
style: TextStyle(
fontSize: 40,
color: Colors.white,
),
),
),
),
],
),
),
],
),
),
],
),
);
}

void _handleToDoChange(ToDo todo) {
setState(() {
todo.isDone = !todo.isDone;
});
}

void _deleteToDoItem(String id) {
setState(() {
todosList.removeWhere((item) => item.id == id);
});
}

void _addToDoItem(String toDo) {
setState(() {
todosList.add(ToDo(
id: DateTime.now().millisecondsSinceEpoch.toString(),
todoText: toDo,
));
});
_todoController.clear();
}
void _runFilter(String enteredKeyword) {
List<ToDo> results = [];
if (enteredKeyword.isEmpty) {
results = todosList;
} else {
results = todosList
.where((item) => item.todoText!
.toLowerCase()
.contains(enteredKeyword.toLowerCase()))
.toList();
}

setState(() {
_foundToDo = results;
});
}

Widget searchBox() {
return Container(
padding: EdgeInsets.symmetric(horizontal: 15),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
),
child: TextField(
onChanged: (value) => _runFilter(value),
decoration: InputDecoration(
contentPadding: EdgeInsets.all(0),
prefixIcon: Icon(
Icons.search,
color: tdBlack,
size: 20,
),
prefixIconConstraints: BoxConstraints(
maxHeight: 20,
minWidth: 25,
),
border: InputBorder.none,
hintText: 'Search',
hintStyle: TextStyle(color: tdGrey),
),
),

);
}

AppBar _buildAppBar() {
return AppBar(
centerTitle: true,
backgroundColor: Color.fromARGB(255, 56, 75, 112),
elevation: 0,
leading: Icon(
Icons.menu,
color: Color.fromARGB(255, 8, 2, 2),
size: 30,
),
title: Text(
'TO DO LIST',
style: TextStyle(
color: const Color.fromARGB(255, 0, 0, 0),
fontWeight: FontWeight.bold,
),
),
);
}
}
