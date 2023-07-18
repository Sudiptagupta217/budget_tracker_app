import 'package:budget_tracker/component/expense_summary.dart';
import 'package:budget_tracker/component/expense_tile.dart';
import 'package:budget_tracker/data/expense_data.dart';
import 'package:budget_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 //text conterollers
  final newExpenseNameController=TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen:false).prepareData();

  }

  //add new Expenses
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add new expenses"),

        content: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
          //expense name
          TextField(
            controller: newExpenseNameController,
            decoration: const InputDecoration(
              hintText: "Expense name"
            ),
          ),

          //expense amount
          TextField(
            controller: newExpenseAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Expense Ampunt"
            ),
          ),

         ]
        ),

        actions: [
          MaterialButton(
              onPressed:save,
            child: Text("Save"),
          ),

          MaterialButton(
            onPressed:cancel,
            child: Text("Cancel"),
          ),
        ],

      ),
    );
  }

  // delete expense
  void deleteExpenses(ExpenseItem expense){
    Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }

  //Save
  void save(){
  if(newExpenseNameController.text.isNotEmpty && newExpenseAmountController.text.isNotEmpty){
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now().toString(),
    );
    //add the expense
    Provider.of<ExpenseData>(context, listen:false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }
  }

  void cancel(){
    Navigator.pop(context);
    clear();
  }

  void clear(){
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) =>
       Scaffold(
      //  appBar: AppBar(title: Text("Expense Tracker")),
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: Icon(Icons.add),
          ),
        body: ListView(children: [
          //weekly summary
          ExpenseSummary(startOfWeek: value.startOfWeekDate()),
          //expense list
          SizedBox(height: 20,),
          ListView.builder(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: "\$ "+value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0 ) =>
                    deleteExpenses(value.getAllExpenseList()[index]),


          ),
          )
        ],
          )
       )
    );
  }
}
