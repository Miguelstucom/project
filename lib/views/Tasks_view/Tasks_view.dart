import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/task.dart';
import '../../data/provider/user_provider.dart';
import '../../Themes/Colors/Appcolors.dart';
import '../../Themes/Widgets/Appbar.dart';
import '../../Themes/Widgets/CustomTextField.dart';

class TasksWriter extends StatefulWidget {
  const TasksWriter({super.key});

  @override
  State<TasksWriter> createState() => _TasksWriterState();
}

TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController startDateController = TextEditingController();
TextEditingController finishDateController = TextEditingController();

class _TasksWriterState extends State<TasksWriter> {
  DateTime? _startDate;
  DateTime? _finishDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime now = DateTime.now();
    DateTime initialDate = now;
    DateTime firstDate = now;
    DateTime lastDate = DateTime(2101);

    if (isStartDate) {
      initialDate = _startDate ?? now;
    } else {
      firstDate = _startDate ?? now;
      initialDate = _finishDate ?? firstDate;
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(surfaceTint: Colors.white),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          startDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
          if (_finishDate != null && _finishDate!.isBefore(pickedDate)) {
            _finishDate = null;
            finishDateController.text = '';
          }
        } else {
          _finishDate = pickedDate;
          finishDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.fill,
            height: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Appbar(
                  titulo: "Crear tarea",
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          NameField(
                            controller: nameController,
                            label: 'Nombre de la tarea',
                            hint: 'ej: Limpiar los platos',
                          ),
                          SizedBox(height: 20),
                          DescriptionField(
                            controller: descriptionController,
                            label: 'Descripción',
                            hint: 'ej: lavar los platos',
                            maxLength: 1000,
                          ),
                          SizedBox(height: 20),
                          DateField(
                            controller: startDateController,
                            label: 'Fecha de inicio',
                            hint: 'Introduce una fecha',
                            onTap: () => _selectDate(context, true),
                          ),
                          SizedBox(height: 20),
                          DateField(
                            controller: finishDateController,
                            label: 'Fecha final',
                            hint: 'Introduce una fecha',
                            onTap: () => _selectDate(context, false),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              final task = Task(
                                name: nameController.text,
                                description: descriptionController.text,
                                creationDate: startDateController.text,
                                state: false,
                                dueDate: finishDateController.text,
                              );
                              await context.read<UserProvider>().saveTask(task);
                              await context.read<UserProvider>().loadUser();
                              Navigator.pushNamed(
                                context,
                                '/Home',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.elevatedButton,
                              minimumSize: const Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Crear tarea',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    finishDateController.dispose();
    startDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    finishDateController = TextEditingController();
    startDateController = TextEditingController();
    super.initState();
  }
}
