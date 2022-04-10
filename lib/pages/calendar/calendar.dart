import 'dart:collection';
import 'package:black_pearl/sevices/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:black_pearl/models/game_model.dart';
import 'package:black_pearl/sevices/game_details.dart';

import '../../models/game_dbs.dart';
import '../../sevices/add_game_elevated.dart';
import '../../sevices/colors.dart';

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late LinkedHashMap<DateTime, List<Game>> _groupedGames;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  @override
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List<Game> game) {
    _groupedGames = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    game.forEach((game) {
      DateTime date = DateTime.utc(
          game.gameDate.year, game.gameDate.month, game.gameDate.day, 12);
      if (_groupedGames[date] == null) _groupedGames[date] = [];
      _groupedGames[date]!.add(game);
    });
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    return _groupedGames[date] ?? [];
  }

  CollectionReference gamesTable =
      FirebaseFirestore.instance.collection('games');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase starter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, './todo'), //profile
          )
        ],
      ),
      drawer: SideBarWidget(),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: gameDBS.streamQueryList(args: []),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final events = snapshot.data;
              _groupEvents(events);
              DateTime selectedDate = _selectedDay;
              final _selectedEvents = _groupedGames[selectedDate] ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8.0),
                    child: TableCalendar(
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(day, _selectedDay),
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      eventLoader: _getEventsForDay,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      weekendDays: [6],
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        headerMargin: const EdgeInsets.only(bottom: 8.0),
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                        formatButtonDecoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        formatButtonTextStyle: TextStyle(color: Colors.white),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                      calendarStyle: CalendarStyle(),
                      calendarBuilders: CalendarBuilders(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(
                      DateFormat('EEEE, dd MMMM, yyyy').format(selectedDate),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _selectedEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      Game game = _selectedEvents[index];
                      return (GameDetails(game: game));
                    },
                  ),
                ],
              );
            } else {}
            return LinearProgressIndicator();
          },
        ),
      ),
      floatingActionButton: AddGameElevated(),
    );
  }
}
