import 'package:flutter/material.dart';

import '../../Themes/Colors/Appcolors.dart';
import '../../Themes/Widgets/Appbar.dart';

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
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                labelText: 'Nombre de la tarea',
                                filled: true,
                                hintText: 'ej: Limpiar los platos',
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.list_alt)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 1000,
                            decoration: const InputDecoration(
                                labelText: 'Descripción',
                                filled: true,
                                hintText: 'ej: lavar los platos',
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.description)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: startDateController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onTap: () => _selectDate(context, true),
                            decoration: const InputDecoration(
                                labelText: 'Fecha de inicio',
                                filled: true,
                                hintText: 'Introduce una fecha',
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.calendar_month)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: finishDateController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onTap: () => _selectDate(context, false),
                            readOnly: true,
                            decoration: const InputDecoration(
                                labelText: 'Fecha final',
                                filled: true,
                                hintText: 'Introduce una fecha',
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.calendar_month)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/Login',
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
                                color: Colors.white),
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
    ));
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
