import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_book/home/add_item/view_model/add_address_viewmodel.dart';
import 'package:provider/provider.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({
    super.key,
  });
  @override
  MyCalendarState createState() => MyCalendarState();
}

class MyCalendarState extends State<MyCalendar> {
  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  int currentyear = DateTime.now().year;
  int selectedDateMonth = 0;
  bool isSelected = false;
  bool showYearBuilder = false;

  @override
  Widget build(BuildContext context) {
    final addadressViewmodel = context.watch<AddaddressViewModel>();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFFE5F2FB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 5, color: const Color.fromRGBO(27, 94, 32, 1))),
              child: Column(
                children: [
                  showYearBuilder == true ? const SizedBox() : _buildHeader(),
                  showYearBuilder == true
                      ? const SizedBox()
                      : _buildDayLabels(),
                  showYearBuilder == true
                      ? buildYear(viewmodel: addadressViewmodel)
                      : _buildCalendar(viewmodel: addadressViewmodel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color.fromRGBO(27, 94, 32, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                selectedDate = DateTime(selectedDate.year,
                    selectedDate.month - 1, selectedDate.day);
              });
            },
          ),
          InkWell(
            onTap: () {
              setState(() {
                showYearBuilder = !showYearBuilder;
              });
            },
            child: Text(
              DateFormat('MMMM yyyy').format(selectedDate),
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios,
                size: 18, color: Colors.white),
            onPressed: () {
              setState(() {
                selectedDate = DateTime(selectedDate.year,
                    selectedDate.month + 1, selectedDate.day);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDayLabels() {
    List<String> dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      children: [
        Expanded(
          child: Container(
            color: const Color.fromARGB(255, 112, 154, 114),
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 50,
                  child: Center(
                    child: Text(
                      dayLabels[index],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: 2,
                  color: Colors.white,
                );
              },
              itemCount: dayLabels.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildYear({required AddaddressViewModel viewmodel}) {
    final afterList = List<String>.generate(15, (int index) {
      return (currentyear + index).toString();
    }, growable: true);
    final beforeList = List<String>.generate(15, (int index) {
      int item = currentyear - 15;
      return (item + index).toString();
    }, growable: true);
    List<String> merggedList = beforeList + afterList;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 2.5),
              itemBuilder: (context, index) {
                final item = merggedList[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedDate = DateTime(int.parse(merggedList[index]),
                          selectedDate.month, selectedDate.day);
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              selectedDate.year == int.parse(merggedList[index])
                                  ? Colors.grey[200]
                                  : Colors.white),
                      child: Center(
                          child: Container(
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: selectedDate.year ==
                                    int.parse(merggedList[index])
                                ? Colors.green[900]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          item,
                          style: TextStyle(
                              color: selectedDate.year ==
                                      int.parse(merggedList[index])
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ))),
                );
              },
              itemCount: 30,
            ),
          ),
          SizedBox(
            height: 50,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedDate = DateTime(currentyear,
                                selectedDate.month, selectedDate.day);
                            showYearBuilder = !showYearBuilder;
                          });
                        },
                        child: const Center(
                            child: Text(
                          'Back',
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            showYearBuilder = !showYearBuilder;
                          });
                          viewmodel.updateDateFrom(selectedDate);
                        },
                        child: const Center(
                            child: Text(
                          'Ok',
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCalendar({required AddaddressViewModel viewmodel}) {
    int firstDayIndex =
        DateTime(selectedDate.year, selectedDate.month, 1).weekday - 1;
    int daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemCount: daysInMonth + firstDayIndex,
        itemBuilder: (context, index) {
          if (index < firstDayIndex) {
            return Container(
              width: 52,
            );
          }
          DateTime day = DateTime(
              selectedDate.year, selectedDate.month, index - firstDayIndex + 1);
          bool isCurrentMonth = selectedDate.month == day.month;
          bool isCurrentDate = currentDate.day == day.day &&
              currentDate.month == day.month &&
              currentDate.year == day.year;
          isSelected =
              selectedDate.day == day.day && selectedDateMonth == day.month;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = day;
                selectedDateMonth = day.month;
              });
              viewmodel.updateDateFrom(day);
            },
            child: Container(
              width: 52,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.green[900]
                    : isCurrentDate && isCurrentMonth
                        ? Colors.green[100]
                        : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                (index - firstDayIndex + 1).toString(),
                style: TextStyle(
                  fontWeight: isSelected || isCurrentDate
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : isCurrentDate
                          ? Colors.black
                          : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
