import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    Key? key,
    this.name,
    this.date,
    this.done,
  }) : super(key: key);
  final String? name;
  final String? date;
  final bool? done;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.edit),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name ?? 'Nombre no definido',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(date ?? '')
            ],
          ),
          Spacer(),
          Icon(
            done == false ? Icons.cancel_outlined : Icons.check,
            color: done == false ? Colors.red : Colors.green,
          )
        ],
      ),
    );
  }
}
