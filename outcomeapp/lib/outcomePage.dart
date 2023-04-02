import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:outcomeapp/them.dart';
import 'Reports.dart';

void main() {
  runApp(MaterialApp(
    home: OutcomeForm(),
  ));
}

class OutcomeForm extends StatefulWidget {
  @override
  _StateForm createState() => _StateForm();
}

TextEditingController Toppic_outcome = TextEditingController();
TextEditingController Amonta_outcome = TextEditingController();

TextEditingController Toppic_income = TextEditingController();
TextEditingController Amonta_income = TextEditingController();

class _StateForm extends State<OutcomeForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'บันทึกข้อมูล รายรับ-รายจ่าย',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Form(
          child: Column(children: [
            Container(
              padding: EdgeInsetsDirectional.all(10.0),
              margin: EdgeInsets.only(bottom: 4.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.list),
                  hintText: 'รายรับ',
                ),
                onSaved: (String? value) {
                
                },
                controller: Toppic_income,
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(10.0),
              margin: EdgeInsets.only(bottom: 4.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.money),
                  hintText: 'จำนวนเงิน',
                ),
                onSaved: (String? value) {
                
                },
                controller: Amonta_income,
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(20.0),
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: TextButton(
                onPressed: () async {
                  const url = 'http://10.0.2.2/API/outcome.php';
                  final respone = await post(Uri.parse(url),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8'
                      },
                      body: jsonEncode({
                        'Toppic': Toppic_income.text,
                        'Amount': Amonta_income.text,
                        'outcomeType': "รายรับ"
                      }));

                  if (respone.statusCode == 200) {
                    final jsonData = jsonDecode(respone.body);

                    print(jsonData['message']);
                    // ignore: use_build_context_synchronously
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Report()));
                  }
                },
                style: TextButton.styleFrom(
                 backgroundColor: primary
                ),
                child: const Text(
                  'บันทึกรายรับ',
                  style: TextStyle(
                      fontSize: 18.0, color: Color.fromARGB(255, 27, 0, 0)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(10.0),
              margin: EdgeInsets.only(bottom: 4.0, top: 15.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.list),
                  hintText: 'รายจ่าย',
                ),
                onSaved: (String? value) {
                 
                },
                controller: Toppic_outcome,
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(10.0),
              margin: EdgeInsets.only(bottom: 4.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.money),
                  hintText: 'จำนวนเงิน',
                ),
                onSaved: (String? value) {
                  print(value);
                },
                controller: Amonta_outcome,
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(20.0),
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: TextButton(
                onPressed: () async {
                  const url = 'http://10.0.2.2/API/outcome.php';
                  final respone = await post(Uri.parse(url),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8'
                      },
                      body: jsonEncode({
                        'Toppic': Toppic_outcome.text,
                        'Amount': Amonta_outcome.text,
                        'outcomeType': "รายจ่าย"
                      }));

                  if (respone.statusCode == 200) {
                    final jsonData = jsonDecode(respone.body);

                    print(jsonData['message']);
                    // ignore: use_build_context_synchronously
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Report()));
                  }
                },
                style: TextButton.styleFrom(
                   backgroundColor: primary
                ),
                child: const Text(
                  'บันทึกรายจ่าย',
                  style: TextStyle(
                      fontSize: 18.0, color: Color.fromARGB(255, 27, 0, 0)),
                ),
              ),
            )
          ]),
        )));
  }
}
