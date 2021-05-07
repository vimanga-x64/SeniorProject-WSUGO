import '../constants.dart';
import './app_event.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

final eventDBS = DatabaseService<AppEvent>(
  AppDBConstants.eventsCollection,
  fromDS: (id, data) => AppEvent.fromDS(id, data),
  toMap: (event) => event.toMap(),
);