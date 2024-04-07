import 'calendar_logic.dart';
import 'year_month_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class Calendar extends StatefulWidget {
  DateTime date;

  Calendar({
    super.key,
    required this.date,
  });

  @override
  _SwipeWidgetState createState() => _SwipeWidgetState();
}


class _SwipeWidgetState extends State<Calendar> {
  String content = 'Initial Content';

  @override
  Widget build(BuildContext context) {
    final calendarData = CalendarBuilder().build(widget.date);
    double width;
    double? _dragStartX;
    double? _lastDragUpdatedX;
    bool _dragged = false;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        width = constraints.maxWidth;
        return GestureDetector(
          onHorizontalDragDown: (DragDownDetails details) {
              _dragStartX = null;
              _dragged = false;
            },
          onHorizontalDragStart: (DragStartDetails details) {
              _dragStartX = details.localPosition.dx;
            },
          onHorizontalDragUpdate: (details) {
            final dragStartX = _dragStartX;
            if (dragStartX == null) return;

            final newX = details.localPosition.dx;

            if (newX - dragStartX > width / 3 && !_dragged) {
              // 右にスワイプされた場合
              setState(() {
                _dragged = true;
                if(widget.date.month == 1){
                  widget.date = widget.date.copyWith(year: widget.date.year - 1, month: 12);
                }else{
                  widget.date = widget.date.copyWith(month: widget.date.month - 1);
                }
              });
            } else if (newX - dragStartX < -width / 3 && !_dragged){
              // 左にスワイプされた場合
              setState(() {
                _dragged = true;
                if(widget.date.month == 12){
                  widget.date = widget.date.copyWith(year: widget.date.year + 1, month: 1);
                }else{
                  widget.date = widget.date.copyWith(month: widget.date.month + 1);
                }
              });
            }
          },
          onHorizontalDragEnd: (DragEndDetails details) {
              final dragStartX = _dragStartX;
              final lastDragUpdateX = _lastDragUpdatedX;
              if (dragStartX == null || lastDragUpdateX == null) return;

              _dragStartX = null;
              _lastDragUpdatedX = null;
              _dragged = false;
            },
          onHorizontalDragCancel: () {
              _dragStartX = null;
              _dragged = false;
            },
          child: Column(
            children: [
              // 年月表示
              ElevatedButton(
                  onPressed: () {
                    DatePicker.showPicker(
                      context,
                      showTitleActions: true,
                      pickerModel: YearMonthModel(
                        currentTime: widget.date,
                        minTime: DateTime(2022, 1, 1),
                        maxTime: DateTime.now(),
                        locale: LocaleType.jp
                      ),
                      onChanged: (date) {
                        widget.date = date;
                      },
                      onConfirm: (date) {
                        setState(() {
                          widget.date = date;
                        });
                      },
                      locale: LocaleType.jp
                    );
                  },
                  child: Text(widget.date.year.toString() + '年' + widget.date.month.toString() + '月'),
                ),
              const _WeekRow(['月', '火', '水', '木', '金', '土', '日']),
              ...calendarData.map(
                (week) => _WeekRow(
                  week.map((date) => date?.toString() ?? '').toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WeekRow extends StatelessWidget {
  const _WeekRow(this.datesOfWeek);

  final List<String> datesOfWeek;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        datesOfWeek.length,
        (index) => Expanded(
          child: _DateBox(
            datesOfWeek[index],
            weekday: index + 1,
          ),
        ),
      ).toList(),
    );
  }
}

class _DateBox extends StatelessWidget {
  const _DateBox(
    this.label, {
    required this.weekday,
    super.key,
  });

  final String label;
  final int weekday;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
          color: weekday == 6
              ? Colors.blue.shade50
              : weekday == 7
                  ? Colors.red.shade50
                  : Colors.white,
        ),
        child: Center(
          child: Text(label),
        ),
      ),
    );
  }
}