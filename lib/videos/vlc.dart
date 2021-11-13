import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/getdata.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

class Vlc extends StatefulWidget {
  @override
  _VlcState createState() => _VlcState();
}

class _VlcState extends State<Vlc> {
  final l = Logger();
  @override
  void initState() {
    gettingSubjectAndRelatedVideos();
    super.initState();
  }

  gettingSubjectAndRelatedVideos() {
    Shared().shared().then((value) async {
      var classId = value.getStringList('storeData');

      await Provider.of<GetSubjectList>(context, listen: false)
          .getSubjectListApi(classId[3]);
      l.w(Provider.of<GetSubjectList>(context, listen: false).subjectList);
      int i = 0;
      while (i <
          Provider.of<GetSubjectList>(context, listen: false)
              .subjectList
              .length) {
        await Provider.of<GetSubjectList>(context, listen: false).searchApi(
            Provider.of<GetSubjectList>(context, listen: false).subjectList[i]);
      }

      // for (int i = 0;
      //     i <
      //         Provider.of<GetSubjectList>(context, listen: false)
      //             .subjectList
      //             .length;
      //     i++) {
      //   await Provider.of<GetSubjectList>(context, listen: false).searchApi(
      //       Provider.of<GetSubjectList>(context, listen: false).subjectList[i]);
      // }
      // for (var i
      //     in Provider.of<GetSubjectList>(context, listen: false).subjectList) {
      //   print(i);
      //   Provider.of<GetSubjectList>(context, listen: false).searchApi(i);
      // }

      l.wtf(Provider.of<GetSubjectList>(context, listen: false).decodeDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double status = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        child: Center(
            child: ElevatedButton(
          child: Text('press'),
          onPressed: () {
            l.w(Provider.of<GetSubjectList>(context, listen: false)
                .decodeDetails);
          },
        )),
      ),
    );
  }
}
