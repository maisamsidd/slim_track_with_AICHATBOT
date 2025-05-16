import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class Week_days extends StatefulWidget {
  const Week_days({super.key});

  @override
  State<Week_days> createState() => _Week_daysState();
}

class _Week_daysState extends State<Week_days> {
  late List<String> daysOfWeek;
  late List<int> datesOfWeek;

  //weekdaysstate

  List<String> _getDaysOfWeek() {
    final today = DateTime.now();
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
    return List.generate(7, (index) {
      final day = firstDayOfWeek.add(Duration(days: index));
      return DateFormat('EEE').format(day); // Short format: Mon, Tue, etc.
    });
  }

  List<int> _getDatesOfWeek() {
    final today = DateTime.now();
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
    return List.generate(7, (index) {
      final day = firstDayOfWeek.add(Duration(days: index));
      return day.day;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    daysOfWeek = _getDaysOfWeek();
    datesOfWeek = _getDatesOfWeek();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Days of the week with real dates
          Row(
            children: List.generate(7, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    Text(
                      daysOfWeek[index],
                      style: const TextStyle(
                        color: AppColors.lite_green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            datesOfWeek[index] == DateTime.now().day
                                ? Colors.white
                                : AppColors.lite_green,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${datesOfWeek[index]}',
                        style: TextStyle(
                          color:
                              datesOfWeek[index] == DateTime.now().day
                                  ? AppColors.lite_green
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          // Calls left
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'calls left',
                  style: TextStyle(
                    color: AppColors.lite_green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.lite_green,
                    shape: BoxShape.circle,
                  ),
                  child: const Text('2', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
