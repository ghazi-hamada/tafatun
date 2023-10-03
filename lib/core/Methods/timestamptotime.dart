import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestampToTime(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}
//format Timestamp to date

String formatTimestampToDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

  return formattedDate;
}
//Do a time comparison to see if the time is before or after the current time

bool isTimeAfterNow(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();
  return dateTime.isAfter(now);
}
//Do a date comparison to see if the date is before or after the current date

bool isDateAfterNow(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();
  return dateTime.isAfter(now);
}
//Do a date comparison to see if the date is before or after the current date

bool isDateBeforeNow(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();
  return dateTime.isBefore(now);
}

//Is the time between two timestamp dates

bool isTimeBetweenTwoTimestamps({required Timestamp startTime,required Timestamp endTime}) {
  DateTime startDateTime = startTime.toDate();
  DateTime endDateTime = endTime.toDate();
  DateTime now = DateTime.now();
  return now.isAfter(startDateTime) && now.isBefore(endDateTime);
}

//timestamp to Duration 

Duration timestampToDuration(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();
  Duration duration = dateTime.difference(now);
  return duration;
}

//timestamp to time

String timestampToTime(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}

//datetime to timestamp

Timestamp dateTimeToTimestamp(DateTime dateTime) {
  Timestamp timestamp = Timestamp.fromDate(dateTime);
  return timestamp;
}