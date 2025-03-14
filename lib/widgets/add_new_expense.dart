import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key});

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();

}

class _AddNewExpenseState extends State<AddNewExpense>{
  final _controller = TextEditingController();
  var _enteredTitle = '';

  void _saveTitleInput(String inputValue){
    _enteredTitle = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Halo",
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            controller: _controller,
            onChanged: _saveTitleInput,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title')
            ),
          ),
          ElevatedButton(onPressed: (){
            print(_controller.text);
          }, child: Text("Save Expense"))
        ],
      ),
    );
  }
}