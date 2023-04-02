import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'outcomePage.dart';
final _formKey = GlobalKey<FormState>();

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'แอพพลิเคชัน รายรับรายจ่าย'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login',
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.all(20.0),
                      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Email',
                        ),
                        onSaved: (String? value) {
                          print(value);
                        },
                         controller: email,
                         validator: (String? value) {
                          return (value != null && value.contains('@'))
                              ? 'Do not use the @ char.'
                              : null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.all(20.0),
                      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          hintText: 'Password',
                        ),
                        onSaved: (String? value) {
                          print(value);
                        },
                         controller: password,
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.all(20.0),
                      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: TextButton(
                        onPressed: () async {

                        

                                  final url = 'http://10.0.2.2/API/login.php';
                                  final respone = await post(Uri.parse(url),
                                      headers: {
                                        'Content-Type':
                                            'application/json; charset=UTF-8'
                                      },
                                      body: jsonEncode({
                                        'Email': email.text,
                                        'Password': password.text,
                                       
                                      }));

                                  if (respone.statusCode == 200) {
                                      final jsonData = jsonDecode(respone.body);
                                    
                                      print(jsonData['message']);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OutcomeForm()));

                                  }
                        },
                        style: TextButton.styleFrom(),
                        child: const Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromARGB(255, 27, 0, 0)),
                        ),
                      ),
                    )
                  ],
                )
                ),
          ],
        ),
      ),
    );
  }
}
