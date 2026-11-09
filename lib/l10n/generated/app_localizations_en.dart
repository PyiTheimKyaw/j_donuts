// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get onboardingTitle => 'Round food for\nevery mood';

  @override
  String get getStarted => 'Let\'s get started';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logIn => 'Log In';

  @override
  String continueWithProvider(String provider) {
    return 'Continue with $provider';
  }

  @override
  String providerNotAvailable(String provider) {
    return '$provider sign-in is not part of this demo.';
  }

  @override
  String get legalPrefix =>
      'By continuing, you acknowledge that you have read and agree to our ';

  @override
  String get legalAnd => ' and ';

  @override
  String get legalSuffix => '.';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get legalPlaceholderBody =>
      'This is a placeholder. The real document opens here once the app connects to a back end.';

  @override
  String get close => 'Close';

  @override
  String progressStep(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get continueLabel => 'Continue';

  @override
  String get back => 'Back';

  @override
  String get retry => 'Retry';

  @override
  String get phoneTitle => 'Enter your phone\nnumber';

  @override
  String get phoneCountryCode => '+95';

  @override
  String get phoneHint => '09xxxxxxxxx';

  @override
  String get phoneInvalid =>
      'Enter a valid Myanmar mobile number, for example 09254135592.';

  @override
  String get phoneNotRegistered => 'This number isn\'t registered yet. ';

  @override
  String get registerLink => 'Register';

  @override
  String get otpTitle => 'Verify your number';

  @override
  String otpSubtitle(String phone) {
    return 'We\'ve sent 6 digit OTP to $phone';
  }

  @override
  String get otpDidntReceive => 'Didn\'t receive the code?';

  @override
  String get otpResendIn => 'resend in ';

  @override
  String get otpResendUnit => ' min';

  @override
  String get otpResend => 'Resend';

  @override
  String get otpInvalid => 'That code isn\'t right. Please try again.';

  @override
  String get otpLocked => 'Too many wrong codes. Tap Resend to get a new one.';

  @override
  String get otpResent => 'A new code has been sent.';

  @override
  String otpAttemptsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attempts left.',
      one: '1 attempt left.',
    );
    return '$_temp0';
  }

  @override
  String get otpCodeLabel => '6-digit verification code';

  @override
  String get nameTitle => 'What\'s your\nname?';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get nameRequired => 'Please enter your first name.';

  @override
  String nameTooLong(int max) {
    return 'Please use at most $max characters.';
  }

  @override
  String get nameInvalidCharacters => 'Use letters and spaces only.';

  @override
  String get dobTitle => 'What\'s your\ndate of birth?';

  @override
  String get dobMonth => 'Month';

  @override
  String get dobDay => 'Day';

  @override
  String get dobYear => 'Year';

  @override
  String get dobChooseMonth => 'Choose your birth month';

  @override
  String get dobInvalidDate => 'That isn\'t a real calendar date.';

  @override
  String get dobInFuture => 'Your date of birth can\'t be in the future.';

  @override
  String dobTooYoung(int age) {
    return 'You must be at least $age years old.';
  }

  @override
  String get welcomeTitle => 'Welcome to the\nworld of J\'donuts';

  @override
  String get letsExplore => 'Let\'s explore';

  @override
  String memberTier(String tier) {
    return '$tier member';
  }

  @override
  String pointsToNextTier(String points, String tier) {
    return '$points points left to become $tier Member';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get seasonalSpecials => 'Seasonal specials';

  @override
  String get popular => 'Popular 🔥';

  @override
  String get orderAgain => 'Order again';

  @override
  String get seeAll => 'See all';

  @override
  String nearbyShopsTitle(int count) {
    return 'There are $count J\'Donut shops near you. 😊';
  }

  @override
  String get exploreNow => 'Explore now';

  @override
  String get orderOnline => 'Order Online';

  @override
  String percentOff(int percent) {
    return '$percent% off';
  }

  @override
  String get newBadge => 'New';

  @override
  String get sectionEmpty => 'Nothing here yet.';

  @override
  String get sectionError => 'We couldn\'t load this section.';

  @override
  String get offlineBanner => 'You\'re offline. Showing saved data.';

  @override
  String get refreshFailed => 'Couldn\'t refresh. Showing saved data.';

  @override
  String get productNotFound => 'We couldn\'t find that product.';

  @override
  String get whatsThis => 'What\'s this?';

  @override
  String get quantity => 'Quantity';

  @override
  String get decreaseQuantity => 'Decrease quantity';

  @override
  String get increaseQuantity => 'Increase quantity';

  @override
  String get addToCart => 'Add to cart';

  @override
  String addedToCart(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Added $count items to your cart',
      one: 'Added 1 item to your cart',
    );
    return '$_temp0';
  }

  @override
  String mmkAmount(String amount) {
    return '$amount MMK';
  }

  @override
  String get rewardsTitle => 'J\' Donuts Rewards';

  @override
  String get rewards => 'Rewards';

  @override
  String get totalPoints => 'Total points';

  @override
  String get tierYouAreHere => 'You\'re here now';

  @override
  String tierRemaining(String points, String tier) {
    return '$points pts Remaining\nto become $tier';
  }

  @override
  String get tierSoon => 'You\'ll be here soon';

  @override
  String get eatMoreEarnMore => 'Eat more earn more';

  @override
  String get gift => 'Gift';

  @override
  String get earn => 'Earn';

  @override
  String pointsReward(int points) {
    return '$points pts';
  }

  @override
  String challengeProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String get giftsEmpty => 'No gifts yet. Keep eating!';

  @override
  String get tierBronze => 'Bronze';

  @override
  String get tierSilver => 'Silver';

  @override
  String get tierGold => 'Gold';

  @override
  String get tierPlatinum => 'Platinum';

  @override
  String get tabHome => 'Home';

  @override
  String get tabReward => 'Reward';

  @override
  String get tabOrders => 'Orders';

  @override
  String get tabWallet => 'Wallet';

  @override
  String get tabSettings => 'Settings';

  @override
  String comingSoon(String feature) {
    return '$feature is coming soon.';
  }

  @override
  String get logOut => 'Log out';

  @override
  String get logOutConfirmTitle => 'Log out?';

  @override
  String get logOutConfirmBody =>
      'You\'ll need your phone number and OTP to log back in.';

  @override
  String get cancel => 'Cancel';

  @override
  String unreadNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count new notifications',
      one: '1 new notification',
      zero: 'No new notifications',
    );
    return '$_temp0';
  }

  @override
  String openSection(String section) {
    return 'See all $section';
  }

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get logOutFailed => 'Couldn\'t log out. Please try again.';

  @override
  String get refreshed => 'Up to date.';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get loading => 'Loading';
}
