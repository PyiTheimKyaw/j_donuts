/// Every route path and name in one place.
abstract final class AppRoutes {
  // Auth flow
  static const String onboarding = '/onboarding';
  static const String phone = '/auth/phone';
  static const String otp = '/auth/otp';
  static const String name = '/auth/name';
  static const String dateOfBirth = '/auth/date-of-birth';
  static const String welcome = '/welcome';

  // Shell tabs
  static const String home = '/home';
  static const String rewards = '/rewards';
  static const String orders = '/orders';
  static const String wallet = '/wallet';
  static const String settings = '/settings';

  // Detail
  static const String product = '/product/:id';

  static String productPath(String id) => '/product/$id';

  /// Query parameter that tells the phone step whether the user is
  /// registering or logging in.
  static const String modeParam = 'mode';
  static const String modeRegister = 'register';
  static const String modeLogin = 'login';

  /// Routes a signed-out user may visit.
  static const Set<String> publicPaths = {
    onboarding,
    phone,
    otp,
    name,
    dateOfBirth,
  };

  static bool isPublic(String location) {
    final path = Uri.parse(location).path;
    return publicPaths.contains(path);
  }
}
