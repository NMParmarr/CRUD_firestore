import 'package:crud_firestore/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();
  final _fnamectr = TextEditingController();
  final _lnamectr = TextEditingController();

  String fname = '';
  String lname = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.cyanAccent,
        ),
        height: 250,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Add Data",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _fnamectr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.all(5),
                  hintText: "First Name",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _lnamectr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.all(5),
                  hintText: "Last Name",
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<CRUD>(builder: (context, provider, _) {
                    return ElevatedButton(
                        onPressed: () {
                          fname = _fnamectr.text.toString().trim();
                          lname = _lnamectr.text.toString().trim();
                          provider.addData(fname, lname);
                          Navigator.pop(context);
                        },
                        child: Text("Add"));
                  }),
                  SizedBox(height: 6),
                  ElevatedButton(
                      onPressed: () => clear(), child: Text("Clear")),
                  SizedBox(height: 6),
                ],
              ),
            ],
          ),
        ));
  }

  void clear() {
    _fnamectr.clear();
    _lnamectr.clear();
  }
}
