import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './add_event.dart';
import './calendar_page.dart';

class AppRoutes{
  static const String addEvent = "add_event";
  static const String editEvent = "edit_event";
  static const String viewEvent = "view_event";
  static const String calendarPage = "calendarPage";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name){
            case addEvent:
              return AddEventPage(selectedDate: settings.arguments);
            case editEvent:
            case viewEvent:
              return EventDetails(event: settings.arguments);
            case calendarPage:
            default:
              return CalendarPage();
          }
        }
    );
  }

}