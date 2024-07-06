import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Themes/Widgets/Appbar.dart';
import '../../Themes/Widgets/TaskContainer.dart';
import '../../data/model/task.dart';
import '../../data/model/user.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  int selectedIndex = DateTime.now().day - 1;
  DateTime selectedMonth = DateTime.now();
  late DateTime lastDayOfMonth;
  late String currentMonth;
  final ScrollController _scrollController = ScrollController();
  String selectedFilter = "Todas";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _updateMonthData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
    });
  }

  void _updateMonthData() {
    lastDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    currentMonth = toBeginningOfSentenceCase(
        DateFormat('MMMM yyyy', 'es_ES').format(selectedMonth))!;
  }

  void _selectDate(int index) {
    setState(() {
      selectedIndex = index;
      selectedDate = DateTime(selectedMonth.year, selectedMonth.month, index + 1);
    });
  }

  Future<void> _selectMonth() async {
    final List<String> months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    int? selectedYear = selectedMonth.year;
    int? selectedMonthIndex = selectedMonth.month - 1;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccione Mes y Año'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: selectedMonthIndex,
                items: List.generate(12, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text(months[index]),
                  );
                }),
                onChanged: (value) {
                  selectedMonthIndex = value;
                },
              ),
              DropdownButton<int>(
                value: selectedYear,
                items: List.generate(101, (index) {
                  int year = DateTime.now().year - 50 + index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  );
                }),
                onChanged: (value) {
                  selectedYear = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (selectedMonthIndex != null && selectedYear != null) {
                  setState(() {
                    selectedMonth = DateTime(selectedYear!, selectedMonthIndex! + 1, 1);
                    selectedIndex = selectedMonth.month == DateTime.now().month &&
                        selectedMonth.year == DateTime.now().year
                        ? DateTime.now().day - 1
                        : 0;
                    selectedDate = DateTime(selectedMonth.year, selectedMonth.month, selectedIndex + 1);
                    _updateMonthData();
                    _scrollToSelectedIndex();
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _scrollToSelectedIndex() {
    double offset = selectedIndex * 58.0;
    _scrollController.animateTo(offset,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  DateTime _parseDate(String date) {
    return DateFormat('yyyy-MM-dd').parse(date);
  }

  List<Task> _filterTasks(List<Task> tasks) {
    List<Task> filteredTasks = tasks.where((task) {
      DateTime creationDate = _parseDate(task.creationDate);
      DateTime dueDate = _parseDate(task.dueDate);
      return creationDate.isBefore(selectedDate) && dueDate.isAfter(selectedDate) ||
          creationDate.isAtSameMomentAs(selectedDate) ||
          dueDate.isAtSameMomentAs(selectedDate);
    }).toList();

    if (selectedFilter == "Completas") {
      return filteredTasks.where((task) => task.state == true).toList();
    } else if (selectedFilter == "No completas") {
      return filteredTasks.where((task) => task.state == false).toList();
    }
    return filteredTasks;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;
    List<String> texts = ["Todas", "Completas", "No completas"];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Appbar(),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: _selectMonth,
              child: Text(
                currentMonth,
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                children: List.generate(
                  lastDayOfMonth.day,
                      (index) {
                    final currentDate = DateTime(selectedMonth.year, selectedMonth.month, index + 1);
                    final dayName = DateFormat('E', 'es_ES').format(currentDate);
                    final dayNameCapitalized = toBeginningOfSentenceCase(dayName)!;
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0.0, right: 16.0),
                      child: GestureDetector(
                        onTap: () => _selectDate(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 42.0,
                              width: 42.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedIndex == index ? Colors.orange : Colors.transparent,
                                borderRadius: BorderRadius.circular(44.0),
                              ),
                              child: Text(
                                dayNameCapitalized.substring(0, 1),
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: selectedIndex == index ? Colors.white : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "${index + 1}",
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              height: 2.0,
                              width: 28.0,
                              color: selectedIndex == index ? Colors.orange : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: texts.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = texts[i];
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        surfaceTintColor: Colors.white,
                        color: selectedFilter == texts[i] ? Colors.orange : Colors.white,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            texts[i],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(
                    children: [
                      for (int i = 0; i < _filterTasks(user?.tasks ?? []).length; i++) ...[
                        TaskContainer(
                          task: user!.tasks![i],
                        ),
                        const SizedBox(height: 15),
                      ]
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
