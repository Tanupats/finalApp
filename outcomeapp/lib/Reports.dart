import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    home: Report(),
  ));
}

class Report extends StatefulWidget {
  @override
  _StateForm createState() => _StateForm();
}

class _StateForm extends State<Report> {
  var LinksStore = [];

  void Getoutcome() async {
    final url = 'http://10.0.2.2/API/outcome.php';
    final respone = await get(Uri.parse(url));

    if (respone.statusCode == 200) {
      final DataRespone = jsonDecode(respone.body);
      setState(() {
        LinksStore = DataRespone;
      });

      //print(LinksStore);
    }
  }

  @override
  void initState() {
    Getoutcome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'สรุปข้อมูล รายรับ-รายจ่าย',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: Expanded(
              child: ListView.builder(
                  itemCount: LinksStore.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = LinksStore[index];

                    if (LinksStore.isEmpty)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[CircularProgressIndicator()],
                        ),
                      );
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(color: Colors.white),
                      margin: EdgeInsets.only(top: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                "วันที่ " + post['Date_outcome'],
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                          Row(children: [Text(post['outcomeType'] , style: TextStyle(fontSize: 18.0) )]),
                          Row(children: [Text(post['Toppic'], style: TextStyle(fontSize: 18.0)  )]),
                          Row(children: [Text(post['Amount'], style: TextStyle(fontSize: 18.0)  )])
                        ],
                      ),
                    );
                  })),
        ));
  }
}
