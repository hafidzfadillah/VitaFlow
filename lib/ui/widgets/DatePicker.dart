import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/models/nutrion/nutrion_model.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';

class DateSelector extends StatefulWidget {
   DateSelector({Key? key , required this.userProvider}) : super(key: key);

  UserProvider userProvider;
  @override
  // ignore: library_private_types_in_public_api
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime _selectedDate;
  late DateTime _firstDayOfSelectedMonth;
  int _selectedDateIndex = DateTime.now().weekday - 1;

  @override
  void initState() {
    super.initState();
    // initialize  locale to id
    initializeDateFormatting();

    _selectedDate = DateTime.now();
    _firstDayOfSelectedMonth =
        DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  void _previousWeek() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 7));
      _firstDayOfSelectedMonth =
          DateTime(_selectedDate.year, _selectedDate.month, 1);
    });
  }

  void _nextWeek() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 7));
      _firstDayOfSelectedMonth =
          DateTime(_selectedDate.year, _selectedDate.month, 1);
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _firstDayOfSelectedMonth =
          DateTime(_selectedDate.year, _selectedDate.month, 1);
    });
  }

  void _onMonthYearPressed(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
        _firstDayOfSelectedMonth =
            DateTime(_selectedDate.year, _selectedDate.month, 1);
      });
    }
  }

  List<Widget> _buildWeekdays() {
    final List<String> weekdays = [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
      'Sab',
      'Min'
    ];
    return weekdays
        .map((weekday) => Expanded(
              child: Text(
                weekday,
                textAlign: TextAlign.center,
              ),
            ))
        .toList();
  }

  List<Widget> _buildDates() {
    final List<Widget> dates = [];
    final DateFormat dateFormat = DateFormat('d', 'id_ID');
    final DateTime now = DateTime.now();
    final DateTime firstDateOfSelectedWeek =
        _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    for (int i = 0; i < 7; i++) {
      final DateTime date = firstDateOfSelectedWeek.add(Duration(days: i));
      final bool isSameMonth = date.month == _selectedDate.month;
      final bool isToday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      final bool isSelectDay = date.year == _selectedDate.year &&
          date.month == _selectedDate.month &&
          date.day == _selectedDate.day;
      final Widget dateWidget = Expanded(
        child: TextButton(
          onPressed: () async {
            _onDateSelected(date);

            widget.userProvider.getNutrion(
                date: date // call getNutrion and getUserMission provider
            );
            widget.userProvider.getMyMission(date: date);
                        widget.userProvider.getUserFood(date: date);


            /// call getNutrion and getUserMission provider
            ///
            ///

            // UserProvider userProvider = UserProvider();
            // userProvider.clearMyNutrition();
            // userProvider.clearMyMission();

            // await userProvider.getNutrion(date: date);
            // await userProvider.getMyMission(date: date);
          },
          child: Text(
            dateFormat.format(date),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSameMonth ? FontWeight.w500 : FontWeight.w300,
              color: isSameMonth
                  ? (isSelectDay ? primaryColor : Color(0xfffB4B8BB))
                  : Colors.grey,
            ),
          ),
        ),
      );
      dates.add(dateWidget);
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat monthYearFormat = DateFormat('MMMM y');
    return Column(
      children: [
        // bagian atas
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 20,
                  color: primaryColor,
                ),
                TextButton(
                  onPressed: () => _onMonthYearPressed(context),
                  child: Text(monthYearFormat.format(_selectedDate),
                      style: normalText.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _previousWeek,
                  iconSize: 16,
                  icon: Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed: _nextWeek,
                  iconSize: 16,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
        // bagian tengah
        SizedBox(
          height: 16,
        ),
        Row(
          children: _buildWeekdays(),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(0xffF6F8FA),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: _buildDates(),
          ),
        ),
      ],
    );
  }
}
