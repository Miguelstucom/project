import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/task.dart';
import '../../data/provider/user_provider.dart';

class TaskContainer extends StatefulWidget {
  const TaskContainer({Key? key, this.task, this.subtask}) : super(key: key);

  final Task? task;
  final Task? subtask;

  @override
  _TaskContainerState createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  late bool _done;

  @override
  void initState() {
    super.initState();
    _done = widget.task!.state!;
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      if (_done != true) {
        _done = value!;
      } else{
        _done = false;
      }
    });
  }

  Color giveColor(int prio) {
    switch (prio) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.green;
      case 5:
        return Colors.purple;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: giveColor(widget.task!.prio!),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: giveColor(widget.task!.prio!),
            ),
            child: Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                return Colors.white;
              }),
              checkColor: Colors.black,
              value: _done,
              onChanged: (bool? value) async {
                if (value != null) {
                  _toggleCheckbox(value);
                  await Future.delayed(Duration(milliseconds: 400));
                  await context.read<UserProvider>().removeTask(widget.task!);
                  _toggleCheckbox(value);
                  await context.read<UserProvider>().loadUser();
                }
              },
            ),
          ),
          Expanded(
            child: Container(
              child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        barrierColor: Colors.black.withOpacity(0.9),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: giveColor(widget.task!.prio!), width: 5.0), // Aquí defines el color y el grosor del borde
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.task!.name ?? 'Nombre no definido',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.task!.description ??
                                        'Nombre no definido',
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.task!.creationDate ??
                                        'Nombre no definido',
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.task!.dueDate ??
                                        'Nombre no definido',
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Subtareas",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  for (int i = 0;
                                      i < widget.task!.tasks!.length;
                                      i++) ...[
                                    TaskContainer(
                                      task: widget.task!.tasks![i],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                  GestureDetector(
                                    onTap: () async {
                                      final subtask = await showDialog<Task>(
                                        context: context,
                                        builder: (context) => SubTaskDialog(),
                                      );

                                      if (subtask != null) {
                                        await context
                                            .read<UserProvider>()
                                            .saveSubTask(widget.task!, subtask);
                                        await context
                                            .read<UserProvider>()
                                            .loadUser();
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Añadir subtareas",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.add)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task!.name ?? 'Nombre no definido',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.task!.description ?? '',
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class SubTaskDialog extends StatefulWidget {
  @override
  _SubTaskDialogState createState() => _SubTaskDialogState();
}

class _SubTaskDialogState extends State<SubTaskDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _creationDateController = TextEditingController();
  bool _state = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Añadir Subtask'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _dueDateController,
              decoration: InputDecoration(labelText: 'Fecha de Vencimiento'),
            ),
            TextField(
              controller: _creationDateController,
              decoration: InputDecoration(labelText: 'Fecha de Creación'),
            ),
            CheckboxListTile(
              title: Text('Estado'),
              value: _state,
              onChanged: (bool? value) {
                setState(() {
                  _state = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final subtask = Task(
              name: _nameController.text,
              description: _descriptionController.text,
              dueDate: _dueDateController.text,
              creationDate: _creationDateController.text,
              state: _state,
              prio: 2,
              tasks: [],
            );
            Navigator.of(context).pop(subtask);
          },
          child: Text('Añadir'),
        ),
      ],
    );
  }
}
