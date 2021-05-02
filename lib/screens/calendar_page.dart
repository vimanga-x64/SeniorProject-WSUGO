import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wsu_go/constants.dart';
import './drawer.dart';
//Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';
//Import Cloud Firestore package
import 'package:cloud_firestore/cloud_firestore.dart';
import './register_page.dart';
import './add_event.dart';
import './calendar_routes.dart';
import './event_firestore_service.dart';
import './app_event.dart';
import 'package:intl/intl.dart';


class CalendarPage extends StatefulWidget {
  static const String id = 'calendar_page';
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  //Allows for selecting day
  CalendarController _calendarController;
  //Shows events on the calendar as a dot
  Map<DateTime, List<AppEvent>> _events;
  //Allows for adding events
  TextEditingController _eventController;
  //Prints events on day select
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
  }

  _groupEvents(List<AppEvent> events) {
    _events = {};
    events.forEach((event){
      //Table calendar uses utc
      DateTime date = DateTime.utc(event.date.year, event.date.month, event.date.day, 12);
      if (_events[date] == null)
        _events[date] = [];
      _events[date].add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calendar'),
          backgroundColor: shockerYellow,
        ),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
            child:
            StreamBuilder(
                stream: eventDBS.streamList(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    //Get events
                    final events = snapshot.data;
                    //Show events on calendar
                    _groupEvents(events);
                    //Show event list on selected day
                    DateTime selectedDate = _calendarController.selectedDay;
                    final _selectedEvents = _events[selectedDate] ?? []; //If there are no events display an empty list
                    return Column(
                        children: [
                          Card(
                            //clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.all(8.0),
                            child: TableCalendar(
                              calendarController: _calendarController,
                              events: _events,
                              onDaySelected: (date,events,_) {
                                setState(() {

                                });
                              },
                              headerStyle: HeaderStyle(
                                  decoration: BoxDecoration(
                                    color: shockerYellow,
                                  ),
                                  headerMargin: const EdgeInsets.only(bottom: 8.0),
                                  titleTextStyle: TextStyle(color: shockerWhite),
                                  formatButtonDecoration: BoxDecoration(
                                    border: Border.all(color: shockerWhite),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  formatButtonTextStyle: TextStyle(color: shockerWhite),
                                  leftChevronIcon: Icon(Icons.chevron_left, color: shockerWhite),
                                  rightChevronIcon: Icon(Icons.chevron_right, color: shockerWhite)
                              ),
                              calendarStyle: CalendarStyle(
                                  todayColor: shockerBlack,
                                  selectedColor: shockerYellow
                              ),
                              builders: CalendarBuilders(

                              ),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _selectedEvents.length,
                              itemBuilder: (BuildContext context, int index) {
                                AppEvent event = _selectedEvents[index];
                                return ListTile(title: Text(event.title),
                                  subtitle: Text(DateFormat("EEEE, dd MMMM, yyyy").format(event.date)),
                                  onTap: () => Navigator.pushNamed(context, AppRoutes.viewEvent, arguments: event),
                                );
                              }
                          )
                        ]
                    );

                  }
                  return CircularProgressIndicator();
                }
            )


        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: shockerYellow,
            onPressed: (){
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddEventPage()));
              Navigator.pushNamed(context, AppRoutes.addEvent,
                  arguments: _calendarController.selectedDay);
            }
        )
    );
  }
}

class EventDetails extends StatelessWidget {
  final AppEvent event;

  const EventDetails({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text('Event Details'),
            backgroundColor: shockerYellow,
            actions: [
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async{
                    final confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            content: Text("Are you sure you want to delete this event?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text("No"),
                              )
                            ]
                        )
                    ) ?? false; //NULL operator if no option is selected output false
                    if(confirm) {
                      await eventDBS.removeItem(event.id);
                      Navigator.pop(context);
                    }
                  }
              )
            ]
        ),
        body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(
                title: Text(event.title),
                subtitle: Text(DateFormat("EEEE, dd MMMM, yyyy").format(event.date)),
              ),
              const SizedBox(height: 10.0),
              if(event.description != null)
                ListTile(
                  title: Text(event.description),
                ),
              const SizedBox(height: 20.0),
            ]
        )
    );
  }
}