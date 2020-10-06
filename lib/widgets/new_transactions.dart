import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTrans;

  NewTransaction(this.addNewTrans);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTrans(enteredTitle, enteredAmount,
        _selectedDate); //Here helps us to access data from parent widget of this state class

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  50 //viewInsets will show the text which are hidden by the soft keyboard
              ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (value) {
                  //   titleInput = value;
                  // },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      _submitData(), //'_' suggests that this will get args, but not needed
                  // onChanged: (value) {
                  //   amountInput = value;
                  // }
                ),
                Container(
                  height: 70,
                  child: Row(children: <Widget>[
                    Text(_selectedDate == null
                        ? 'No dates chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Choose Date!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: _presentDatePicker),
                  ]),
                ),
                RaisedButton(
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitData,
                ),
              ]),
        ),
      ),
    );
  }
}
