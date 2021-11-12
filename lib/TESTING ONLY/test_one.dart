import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ExpansionOne extends StatefulWidget {
  @override
  _ExpansionOneState createState() => _ExpansionOneState();
}

class _ExpansionOneState extends State<ExpansionOne> {
  final l = Logger();
  var ke = GlobalKey();
  int? x;
  List y = [];
  List all = [];
  List alls = ['1', '2', '3', '4', '5'];
  Map s = {};
  bool bo = false;
  bool? so = false;
  String? ind;
  int? inds;
  var j = 100.0;
  var key = LocalKey;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...alls.asMap().entries.map((element) {
                for (var i = 0; i < alls.length; i++) {
                  if (alls[i] == element) {
                    if (i.isEven) {
                      setState(() {
                        so = true;
                      });
                    } else {
                      setState(() {
                        so = false;
                      });
                    }
                  }
                }
                return Container(
                  height: so! ? 200 : 100,
                  width: 200,
                  color: so! ? Colors.pink : Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${element.value}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          l.w(element.key);
                          l.i(element.value);
                          for (var i = 0; i < alls.length; i++) {
                            if (alls[i] == element) {
                              var zz = ke.currentContext.hashCode;
                              l.w(zz);
                              l.i(element.key);
                              l.i(element.value);

                              // setState(() {
                              //   j = 200.0;
                              //   inds = i;
                              // });

                              // setState(() {
                              //   ind = element;
                              //   if (y.contains(element)) {
                              //     y.remove(element);
                              //   } else {
                              //     y.add(element);
                              //   }
                              // });
                              // setState(() {
                              //   inds = element.key;
                              //   l.w(inds);
                              //   var index = alls
                              //       .indexWhere((element) => element == ind);
                              //   l.e(index);
                              //   if (index == i) {
                              //     setState(() {
                              //       so = true;
                              //     });
                              //   }
                              // });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
              }).toList()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // alls.forEach((element) {
    //   return Container();
    // });
    s = alls.asMap();
    all = generate(length: 5);

    print(all);
  }

  generate({length}) {
    return List.generate(length, (index) {
      return Container(
        height: bo ? 100 : 200,
        width: 200,
        color: index.isEven ? Colors.pink.shade100 : Colors.red.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    bo = !bo;
                    print(bo);
                  });
                  print('hello in icon button $index');
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("$index"),
                SizedBox(
                  height: 10,
                ),
                Text('Number, $index'),
              ],
            ),
          ],
        ),
      );
    });
  }
}
