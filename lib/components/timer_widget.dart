import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:startlottery/responsive.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss a').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      textAlign: TextAlign.center,
      style: Responsive.isMobile(context)
          ? Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)
          : Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.white),
    );
  }
}
// DateFormat('dd/MM/yyyy, hh:mm:ss a').format(DateTime.now()),