import 'package:flutter/material.dart';
import 'package:adoptify/utilities/components/custom_btn.dart';
import 'package:adoptify/utilities/theme/media.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationScreen extends StatefulWidget {
//  const ReservationScreen({required this.toHighlight});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime today = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  var calendarFormat;
  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      today = day;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              width: MediaHelper.width,
              decoration: BoxDecoration(
                  color: Colors.black,
                  // shape: BoxShape.values,
                  gradient: LinearGradient(colors: [
                    Colors.black45,
                    Colors.black87,
                    Colors.white38,
                    Colors.grey
                  ]),
                  backgroundBlendMode: BlendMode.overlay,
                  image: DecorationImage(
                      image: AssetImage('assets/images/calender7.jpg'),
                      fit: BoxFit.cover)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      // Text("Selected Day =" + today.toString().split(" ")[0]),
                      TableCalendar(
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          weekdayStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),

                        calendarStyle: CalendarStyle(
                          rangeStartTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          withinRangeTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          defaultTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          disabledTextStyle: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          todayTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                          selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          holidayTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                          weekendTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                          //  todayDecoration:  BoxDecoration(color: Colors.white24),
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white38,
                          ),
                          todayDecoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          markerDecoration: BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                          ),
                          //  selectedDecoration:  BoxDecoration(color: Colors.white24,borderRadius: BorderRadius.circular(22)),
                        ),
                        locale: "en_US",
                        rowHeight: 60,
                        headerStyle: HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                        availableGestures: AvailableGestures.all,
                        focusedDay: today,
                        firstDay: DateTime.utc(2023, 9, 22),
                        lastDay: DateTime.utc(2040, 10, 22),
                        onDaySelected: _onDaySelected,
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        // calendarFormat: calendarFormat,
                        // onFormatChanged: (format) {
                        //   setState(() {
                        //     calendarFormat = format;
                        //   });
                        // },
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grooming Pets',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '368 Latona, Washington',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '14:30 PM',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    CustomBtn(
                      width: 90,
                      height: 36,
                      buttonColor: Colors.transparent,
                      text: Text('View',style: TextStyle(                      fontSize: 18,
),),
                      textColor: Colors.amber,
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            indent: 20,
            endIndent: 0,
            color: Colors.grey.shade300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grooming Pets',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '368 Latona, Washington',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '14:30 PM',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    CustomBtn(
                      width: 90,
                      height: 36,
                      buttonColor: Colors.transparent,
                      text: Text('View',style: TextStyle( fontSize: 18,),),
                      textColor: Colors.amber,
                     
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            indent: 20,
            endIndent: 0,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}

// class Chevron extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Gradient gradient = new LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [Colors.orangeAccent, Colors.yellow],
//       tileMode: TileMode.clamp,
//     );

//     final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
//     final Paint paint = new Paint()
//       ..shader = gradient.createShader(colorBounds);

//     Path path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(size.width / 2, size.height - size.height / 2);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }