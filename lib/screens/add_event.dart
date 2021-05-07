import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wsu_go/constants.dart';
import './calendar_routes.dart';
import './event_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEventPage extends StatefulWidget {
  // For passing selected date into add event
  final DateTime selectedDate;

  const AddEventPage({Key key, this.selectedDate}) : super (key: key);
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: shockerYellow,
        // X button to return
        leading: IconButton(
          icon: Icon(Icons.clear, color: shockerBlack,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                //save event
                bool validated = _formKey.currentState.validate();
                if(validated) {
                    _formKey.currentState.save();
                    final data = Map<String, dynamic>.from(_formKey.currentState.value);
                    data['date'] = (data['date'] as DateTime).millisecondsSinceEpoch;
                    await eventDBS.create(data);
                    Navigator.pop(context);
                }
              },
              child: Text("Save"),
              style: ElevatedButton.styleFrom(
              primary: shockerBlack,
              )
            )
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                    ]),
                    name: "title",
                    decoration: InputDecoration(
                      hintText: "Add Title",
                      //border: InputBorder.none,
                    ),
                  ),

                  FormBuilderTextField(
                    name: "description",
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                        //border: InputBorder.none,
                        hintText: "Add Details",
                      ),
                  ),

                  FormBuilderDateTimePicker(
                    validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                    name: "date",
                    initialValue: widget.selectedDate ??
                    DateTime.now(),
                    fieldHintText: "Add Date",
                    inputType: InputType.date,
                    format: DateFormat('EEEE, dd MMMM, yyyy'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.calendar_today_sharp),
                    ),

                  )
                ],
              ),
          ),
        ],
      ),
    );
  }
}