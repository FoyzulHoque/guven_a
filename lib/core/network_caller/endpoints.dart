class Urls {
  static const String baseUrl = 'https://api.guven.code-commando.com/api/v1';
  static const String socketUrl = 'ws://10.0.20.38:5005';
  static const String login = '$baseUrl/auth/login';
  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String logout = '$baseUrl/auth/logout';
  static const String forgotPass = '$baseUrl/auth/forgot-password';
  static const String pickUpLocation = '$baseUrl/user/pickup-locations';
  static String getCalendar(String date, String locationUuid) =>
      '$baseUrl/calendar?date=$date&pickup_location_uuid=$locationUuid';
}
