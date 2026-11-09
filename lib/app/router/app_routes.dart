abstract final class AppRoutes {
  /// Held only while the stored session is read at launch.
  static const String splash = '/';

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

  static const String modeParam = 'mode';
  static const String modeRegister = 'register';
  static const String modeLogin = 'login';

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
