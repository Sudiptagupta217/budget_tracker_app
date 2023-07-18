import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final String dateTime;
  void Function(BuildContext)? deleteTapped;

   ExpenseTile({
    super.key,
  required this.name,
  required this.amount,
  required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = DateTime.parse(dateTime); // Convert String to DateTime

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              onPressed: deleteTapped,
              icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(4),
          )
        ],
      ) ,
      child: ListTile(
        title: Text(name),
        subtitle: Text(parsedDateTime.day.toString() + '/' + parsedDateTime.month.toString() +'/' + parsedDateTime.year.toString(),),
        trailing: Text(amount,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),),
      ),
    );
  }
}
