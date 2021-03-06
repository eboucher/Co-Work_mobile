import 'package:flutter/material.dart';
import 'package:time_range/time_list.dart';
import 'package:time_range/time_range.dart';

export 'package:time_range/time_of_day_extension.dart';
class CustomTimeRange extends StatefulWidget {
  final int timeStep;
  final int timeBlock;
  final TimeOfDay firstTime;
  final TimeOfDay lastTime;
  final Widget fromTitle;
  final Widget toTitle;
  final double titlePadding;
  final void Function(TimeRangeResult range) onRangeCompleted;
  final TimeRangeResult initialRange;
  final Color borderColor;
  final Color activeBorderColor;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;

  final Function onStartHourChanged;
  CustomTimeRange({
    Key key,
    @required this.timeBlock,
    @required this.onRangeCompleted,
    @required this.firstTime,
    @required this.lastTime,
    this.timeStep = 60,
    this.fromTitle,
    this.toTitle,
    this.titlePadding = 0,
    this.initialRange,
    this.borderColor,
    this.activeBorderColor,
    this.backgroundColor,
    this.activeBackgroundColor,
    this.textStyle,
    this.activeTextStyle,
    this.onStartHourChanged
  })  : assert(timeBlock != null),
        assert(firstTime != null && lastTime != null),
        assert(onRangeCompleted != null),
        super(key: key);
  @override
  _CustomTimeRangeState createState() => _CustomTimeRangeState();


}



class _CustomTimeRangeState extends State<CustomTimeRange> {
  TimeOfDay _startHour;
  TimeOfDay _endHour;

  @override
  void initState() {
    super.initState();
    setRange();
  }

  @override
  void didUpdateWidget(CustomTimeRange oldWidget) {
    super.didUpdateWidget(oldWidget);
    setRange();
  }

  void setRange() {
    if (widget.initialRange != null) {
      _startHour = widget.initialRange.start;
      _endHour = widget.initialRange.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.fromTitle != null)
          Padding(
            padding: EdgeInsets.only(left: widget.titlePadding),
            child: widget.fromTitle,
          ),
        SizedBox(height: 8),
        TimeList(
          firstTime: widget.firstTime,
          lastTime: widget.lastTime.subtract(minutes: widget.timeBlock),
          initialTime: _startHour,
          timeStep: widget.timeStep,
          padding: widget.titlePadding,
          onHourSelected: _startHourChanged,
          borderColor: widget.borderColor,
          activeBorderColor: widget.activeBorderColor,
          backgroundColor: widget.backgroundColor,
          activeBackgroundColor: widget.activeBackgroundColor,
          textStyle: widget.textStyle,
          activeTextStyle: widget.activeTextStyle,
        ),
        if (widget.toTitle != null)
          Padding(
            padding: EdgeInsets.only(left: widget.titlePadding, top: 8),
            child: widget.toTitle,
          ),
        SizedBox(height: 8),
        TimeList(
          firstTime: _startHour == null
              ? widget.firstTime.add(minutes: widget.timeBlock)
              : _startHour.add(minutes: widget.timeBlock),
          lastTime: widget.lastTime,
          initialTime: _endHour,
          timeStep: widget.timeBlock,
          padding: widget.titlePadding,
          onHourSelected: _endHourChanged,
          borderColor: widget.borderColor,
          activeBorderColor: widget.activeBorderColor,
          backgroundColor: widget.backgroundColor,
          activeBackgroundColor: widget.activeBackgroundColor,
          textStyle: widget.textStyle,
          activeTextStyle: widget.activeTextStyle,
        ),
      ],
    );
  }

  void _startHourChanged(TimeOfDay hour) {
    setState(() => _startHour = hour);
    if (_endHour != null) {
      if(_endHour.inMinutes() <= _startHour.inMinutes() || (_endHour.inMinutes() - _startHour.inMinutes()).remainder(widget.timeBlock) != 0){
        _endHour = null;
        widget.onRangeCompleted(null);
      } else {
        widget.onRangeCompleted(TimeRangeResult(_startHour, _endHour));
      }
    }
    widget.onStartHourChanged();
  }

  void _endHourChanged(TimeOfDay hour) {
    setState(() => _endHour = hour);
    widget.onRangeCompleted(TimeRangeResult(_startHour, _endHour));
  }
}
