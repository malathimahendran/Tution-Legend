import 'package:flutter/material.dart';

class TestOne extends StatefulWidget {
  @override
  _TestOneState createState() => _TestOneState();
}

class _TestOneState extends State<TestOne> {
  List all = [
    'number1',
    'number2',
    'number3',
    'number4',
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Test One')),
      body: Container(
        child: ListView.builder(
          itemCount: all.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: height * 0.1,
              child: Row(
                children: [
                  Container(
                    width: width * 0.8,
                    child: Text(
                      all[index].toString(),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      width: width * 0.2,
                      child: Icon(Icons.favorite),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
