import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/getdata.dart';

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

  gettingSubjectAndRelatedVideos() async {
    await Provider.of<GetSubjectList>(context, listen: false)
        .getSubjectListApi("3");
    l.w(Provider.of<GetSubjectList>(context, listen: false).subjectList);

    for (var i
        in Provider.of<GetSubjectList>(context, listen: false).subjectList) {
      print(i);
      await Provider.of<GetSubjectList>(context, listen: false).searchApi(i);
    }

    l.wtf(Provider.of<GetSubjectList>(context, listen: false).decodeDetails);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double status = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(),
    );
  }
}
