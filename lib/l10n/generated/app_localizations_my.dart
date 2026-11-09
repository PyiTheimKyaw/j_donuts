// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get onboardingTitle =>
      'ခံစားမှုတိုင်းအတွက်\nဒိုးနတ်ဝိုင်းဝိုင်းလေးများ';

  @override
  String get getStarted => 'စတင်လိုက်ရအောင်';

  @override
  String get alreadyHaveAccount => 'အကောင့်ရှိပြီးသားလား?';

  @override
  String get logIn => 'ဝင်ရန်';

  @override
  String continueWithProvider(String provider) {
    return '$provider ဖြင့် ဆက်လုပ်ရန်';
  }

  @override
  String providerNotAvailable(String provider) {
    return '$provider ဖြင့်ဝင်ခြင်းကို ဤနမူနာတွင် မပါဝင်ပါ။';
  }

  @override
  String get legalPrefix => 'ဆက်လုပ်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ ';

  @override
  String get legalAnd => ' နှင့် ';

  @override
  String get legalSuffix =>
      ' ကို ဖတ်ရှုသဘောတူပြီးဖြစ်ကြောင်း အသိအမှတ်ပြုပါသည်။';

  @override
  String get termsOfUse => 'အသုံးပြုမှုစည်းမျဉ်းများ';

  @override
  String get privacyPolicy => 'ကိုယ်ရေးအချက်အလက်မူဝါဒ';

  @override
  String get legalPlaceholderBody =>
      'ဤသည်မှာ နမူနာစာမျက်နှာဖြစ်သည်။ အက်ပ်ကို ဆာဗာနှင့်ချိတ်ဆက်ပြီးပါက စာရွက်စာတမ်းအစစ် ဤနေရာတွင် ပွင့်လာပါမည်။';

  @override
  String get close => 'ပိတ်ရန်';

  @override
  String progressStep(int step, int total) {
    return 'အဆင့် $step / $total';
  }

  @override
  String get continueLabel => 'ဆက်လုပ်ရန်';

  @override
  String get back => 'နောက်သို့';

  @override
  String get retry => 'ပြန်ကြိုးစားရန်';

  @override
  String get phoneTitle => 'သင့်ဖုန်းနံပါတ်\nထည့်ပါ';

  @override
  String get phoneCountryCode => '+95';

  @override
  String get phoneHint => '09xxxxxxxxx';

  @override
  String get phoneInvalid =>
      'မြန်မာမိုဘိုင်းဖုန်းနံပါတ် မှန်ကန်စွာထည့်ပါ၊ ဥပမာ 09254135592။';

  @override
  String get phoneNotRegistered => 'ဤနံပါတ်ကို မှတ်ပုံတင်ထားခြင်း မရှိသေးပါ။ ';

  @override
  String get registerLink => 'မှတ်ပုံတင်ရန်';

  @override
  String get otpTitle => 'သင့်နံပါတ်ကို အတည်ပြုပါ';

  @override
  String otpSubtitle(String phone) {
    return '$phone သို့ ဂဏန်း ၆ လုံး OTP ပို့ထားပါသည်';
  }

  @override
  String get otpDidntReceive => 'ကုဒ် မရရှိဘူးလား?';

  @override
  String get otpResendIn => 'ပြန်ပို့နိုင်ရန် ';

  @override
  String get otpResendUnit => ' မိနစ်';

  @override
  String get otpResend => 'ပြန်ပို့ရန်';

  @override
  String get otpInvalid => 'ကုဒ် မှားနေပါသည်။ ထပ်ကြိုးစားပါ။';

  @override
  String get otpLocked =>
      'မှားသောကုဒ် အကြိမ်များလွန်းပါသည်။ ကုဒ်အသစ်ရယူရန် ပြန်ပို့ရန်ကို နှိပ်ပါ။';

  @override
  String get otpResent => 'ကုဒ်အသစ် ပို့ပြီးပါပြီ။';

  @override
  String otpAttemptsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'နောက်ထပ် $count ကြိမ် ကြိုးစားနိုင်ပါသည်။',
    );
    return '$_temp0';
  }

  @override
  String get otpCodeLabel => 'အတည်ပြုကုဒ် ဂဏန်း ၆ လုံး';

  @override
  String get nameTitle => 'သင့်နာမည်က\nဘာလဲ?';

  @override
  String get firstName => 'နာမည်';

  @override
  String get lastName => 'မိသားစုနာမည်';

  @override
  String get nameRequired => 'သင့်နာမည်ကို ထည့်ပါ။';

  @override
  String nameTooLong(int max) {
    return 'အက္ခရာ $max လုံးထက် မပိုစေရပါ။';
  }

  @override
  String get nameInvalidCharacters => 'စာလုံးနှင့် နေရာလွတ်များသာ အသုံးပြုပါ။';

  @override
  String get dobTitle => 'သင့်မွေးနေ့က\nဘယ်တော့လဲ?';

  @override
  String get dobMonth => 'လ';

  @override
  String get dobDay => 'ရက်';

  @override
  String get dobYear => 'နှစ်';

  @override
  String get dobChooseMonth => 'မွေးလ ရွေးပါ';

  @override
  String get dobInvalidDate => 'ဤရက်စွဲသည် ပြက္ခဒိန်တွင် မရှိပါ။';

  @override
  String get dobInFuture => 'မွေးနေ့သည် အနာဂတ်ရက်စွဲ မဖြစ်နိုင်ပါ။';

  @override
  String dobTooYoung(int age) {
    return 'အသက် အနည်းဆုံး $age နှစ် ပြည့်ရပါမည်။';
  }

  @override
  String get welcomeTitle => 'J\'donuts ကမ္ဘာမှ\nကြိုဆိုပါတယ်';

  @override
  String get letsExplore => 'စူးစမ်းကြည့်ရအောင်';

  @override
  String memberTier(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String pointsToNextTier(String points, String tier) {
    return '$tier အဖွဲ့ဝင်ဖြစ်ရန် $points မှတ် လိုပါသေးသည်';
  }

  @override
  String get notifications => 'အသိပေးချက်များ';

  @override
  String get seasonalSpecials => 'ရာသီအလိုက် အထူးအစီအစဉ်များ';

  @override
  String get popular => 'လူကြိုက်များ 🔥';

  @override
  String get orderAgain => 'ထပ်မှာရန်';

  @override
  String get seeAll => 'အားလုံးကြည့်ရန်';

  @override
  String nearbyShopsTitle(int count) {
    return 'သင့်အနီးတွင် J\'Donut ဆိုင် $count ဆိုင် ရှိပါသည်။ 😊';
  }

  @override
  String get exploreNow => 'ယခု ကြည့်ရန်';

  @override
  String get orderOnline => 'အွန်လိုင်းမှ မှာရန်';

  @override
  String percentOff(int percent) {
    return '$percent% လျှော့';
  }

  @override
  String get newBadge => 'အသစ်';

  @override
  String get sectionEmpty => 'ဘာမှ မရှိသေးပါ။';

  @override
  String get sectionError => 'ဤအပိုင်းကို ဖွင့်၍ မရပါ။';

  @override
  String get offlineBanner =>
      'အင်တာနက် မရှိပါ။ သိမ်းထားသော အချက်အလက်များကို ပြသနေသည်။';

  @override
  String get refreshFailed =>
      'ပြန်လည်ရယူ၍ မရပါ။ သိမ်းထားသော အချက်အလက်များကို ပြသနေသည်။';

  @override
  String get productNotFound => 'ဤပစ္စည်းကို ရှာမတွေ့ပါ။';

  @override
  String get whatsThis => 'ဒါက ဘာလဲ?';

  @override
  String get quantity => 'အရေအတွက်';

  @override
  String get decreaseQuantity => 'အရေအတွက် လျှော့ရန်';

  @override
  String get increaseQuantity => 'အရေအတွက် တိုးရန်';

  @override
  String get addToCart => 'ခြင်းထဲထည့်ရန်';

  @override
  String addedToCart(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ပစ္စည်း $count ခု ခြင်းထဲ ထည့်ပြီးပါပြီ',
    );
    return '$_temp0';
  }

  @override
  String mmkAmount(String amount) {
    return '$amount ကျပ်';
  }

  @override
  String get rewardsTitle => 'J\' Donuts ဆုလာဘ်များ';

  @override
  String get rewards => 'ဆုလာဘ်';

  @override
  String get totalPoints => 'စုစုပေါင်း အမှတ်';

  @override
  String get tierYouAreHere => 'သင် ယခု ဤနေရာတွင်';

  @override
  String tierRemaining(String points, String tier) {
    return '$tier ဖြစ်ရန်\n$points မှတ် လိုသေးသည်';
  }

  @override
  String get tierSoon => 'မကြာမီ ဤနေရာသို့ ရောက်ပါမည်';

  @override
  String get eatMoreEarnMore => 'များများစား များများရ';

  @override
  String get gift => 'လက်ဆောင်';

  @override
  String get earn => 'ရယူရန်';

  @override
  String pointsReward(int points) {
    return '$points မှတ်';
  }

  @override
  String challengeProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String get giftsEmpty => 'လက်ဆောင် မရှိသေးပါ။ ဆက်လက်အားပေးပါဦး!';

  @override
  String get tierBronze => 'ကြေးနီ';

  @override
  String get tierSilver => 'ငွေ';

  @override
  String get tierGold => 'ရွှေ';

  @override
  String get tierPlatinum => 'ပလက်တီနမ်';

  @override
  String get tabHome => 'ပင်မ';

  @override
  String get tabReward => 'ဆုလာဘ်';

  @override
  String get tabOrders => 'အော်ဒါများ';

  @override
  String get tabWallet => 'ပိုက်ဆံအိတ်';

  @override
  String get tabSettings => 'ဆက်တင်များ';

  @override
  String comingSoon(String feature) {
    return '$feature မကြာမီ ရောက်ရှိလာပါမည်။';
  }

  @override
  String get logOut => 'ထွက်ရန်';

  @override
  String get logOutConfirmTitle => 'ထွက်မှာလား?';

  @override
  String get logOutConfirmBody =>
      'ပြန်ဝင်ရန် သင့်ဖုန်းနံပါတ်နှင့် OTP လိုအပ်ပါမည်။';

  @override
  String get cancel => 'မလုပ်တော့ပါ';

  @override
  String unreadNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'အသိပေးချက်အသစ် $count ခု',
      zero: 'အသိပေးချက်အသစ် မရှိပါ',
    );
    return '$_temp0';
  }

  @override
  String openSection(String section) {
    return '$section အားလုံးကြည့်ရန်';
  }

  @override
  String get settingsAccount => 'အကောင့်';

  @override
  String get settingsLanguage => 'ဘာသာစကား';

  @override
  String get logOutFailed => 'ထွက်၍ မရပါ။ ထပ်ကြိုးစားပါ။';

  @override
  String get refreshed => 'နောက်ဆုံးအခြေအနေ ဖြစ်ပါပြီ။';

  @override
  String get errorGeneric => 'တစ်ခုခု မှားယွင်းသွားပါသည်။ ထပ်ကြိုးစားပါ။';

  @override
  String get loading => 'ဖွင့်နေသည်';
}
