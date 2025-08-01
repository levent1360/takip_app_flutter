import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @markalar.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get markalar;

  /// No description provided for @ara.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get ara;

  /// No description provided for @tumurunler.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get tumurunler;

  /// No description provided for @urunleriniz.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get urunleriniz;

  /// No description provided for @siteyegit.
  ///
  /// In en, this message translates to:
  /// **'Go to Site'**
  String get siteyegit;

  /// No description provided for @guncelfiyat.
  ///
  /// In en, this message translates to:
  /// **'Current Price'**
  String get guncelfiyat;

  /// No description provided for @fiyatgecmisi.
  ///
  /// In en, this message translates to:
  /// **'Price History'**
  String get fiyatgecmisi;

  /// No description provided for @ilkfiyat.
  ///
  /// In en, this message translates to:
  /// **'Initial Price'**
  String get ilkfiyat;

  /// No description provided for @linkgonder.
  ///
  /// In en, this message translates to:
  /// **'Submit Link'**
  String get linkgonder;

  /// No description provided for @takipyapistirmetin.
  ///
  /// In en, this message translates to:
  /// **'Paste the link of the product you want to track here and submit it.'**
  String get takipyapistirmetin;

  /// No description provided for @yapistirmetin.
  ///
  /// In en, this message translates to:
  /// **'Paste the link here'**
  String get yapistirmetin;

  /// No description provided for @yapistir.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get yapistir;

  /// No description provided for @gonder.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get gonder;

  /// No description provided for @silmebaslik.
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get silmebaslik;

  /// No description provided for @silmemetin.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this product?'**
  String get silmemetin;

  /// No description provided for @urunbulunamadi.
  ///
  /// In en, this message translates to:
  /// **'Product Not Found'**
  String get urunbulunamadi;

  /// No description provided for @urunbulunamadimetin.
  ///
  /// In en, this message translates to:
  /// **'Please share the link of the product you want to track from the selected brands.'**
  String get urunbulunamadimetin;

  /// No description provided for @hata.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get hata;

  /// No description provided for @urunkontrol.
  ///
  /// In en, this message translates to:
  /// **'Checking... Please wait'**
  String get urunkontrol;

  /// No description provided for @gecerligonder.
  ///
  /// In en, this message translates to:
  /// **'Please send a valid product link.'**
  String get gecerligonder;

  /// No description provided for @urunkaydediliyor.
  ///
  /// In en, this message translates to:
  /// **'Saving your products...'**
  String get urunkaydediliyor;

  /// No description provided for @bitti.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get bitti;

  /// No description provided for @bosgonderilemez.
  ///
  /// In en, this message translates to:
  /// **'Cannot send empty'**
  String get bosgonderilemez;

  /// No description provided for @bildirimkapatildi.
  ///
  /// In en, this message translates to:
  /// **'Notifications for this product have been turned off'**
  String get bildirimkapatildi;

  /// No description provided for @bildirimacildi.
  ///
  /// In en, this message translates to:
  /// **'Notifications for this product have been turned on'**
  String get bildirimacildi;

  /// No description provided for @bildirimbulunamadi.
  ///
  /// In en, this message translates to:
  /// **'No notifications found'**
  String get bildirimbulunamadi;

  /// No description provided for @bildirimbulunamadimetin.
  ///
  /// In en, this message translates to:
  /// **'You can view your notifications here'**
  String get bildirimbulunamadimetin;

  /// No description provided for @bildirimler.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get bildirimler;

  /// No description provided for @hatalikayitislemi.
  ///
  /// In en, this message translates to:
  /// **'Invalid record operation'**
  String get hatalikayitislemi;

  /// No description provided for @herhangiveribulunamadi.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get herhangiveribulunamadi;

  /// No description provided for @evet.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get evet;

  /// No description provided for @hayir.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get hayir;

  /// No description provided for @iptal.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get iptal;

  /// No description provided for @defaultOnay.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get defaultOnay;

  /// No description provided for @defaultOnayMetin.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to perform this action?'**
  String get defaultOnayMetin;

  /// No description provided for @ileri.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get ileri;

  /// No description provided for @geri.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get geri;

  /// No description provided for @basla.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get basla;

  /// No description provided for @markabulunamadi.
  ///
  /// In en, this message translates to:
  /// **'Selected brand not found'**
  String get markabulunamadi;

  /// No description provided for @aramamarkabulunamadi.
  ///
  /// In en, this message translates to:
  /// **'No brand found matching the search criteria.'**
  String get aramamarkabulunamadi;

  /// No description provided for @markasiteyegit.
  ///
  /// In en, this message translates to:
  /// **'Go to the brand\'s website and share the link'**
  String get markasiteyegit;

  /// No description provided for @yardimtext1.
  ///
  /// In en, this message translates to:
  /// **'How can I share links?'**
  String get yardimtext1;

  /// No description provided for @yardimtext2.
  ///
  /// In en, this message translates to:
  /// **'1. By using the \'Share\' option from the browser:'**
  String get yardimtext2;

  /// No description provided for @yardimtext3.
  ///
  /// In en, this message translates to:
  /// **'You can easily share the link by clicking the share icon in your browser.'**
  String get yardimtext3;

  /// No description provided for @yardimtext4.
  ///
  /// In en, this message translates to:
  /// **'2. Using the Copy-Paste method:'**
  String get yardimtext4;

  /// No description provided for @yardimtext5.
  ///
  /// In en, this message translates to:
  /// **'Copy the link from the address bar and paste it into the app.'**
  String get yardimtext5;

  /// No description provided for @yardimtext6.
  ///
  /// In en, this message translates to:
  /// **'Note: If the links don\'t work, make sure you copied them correctly.'**
  String get yardimtext6;

  /// No description provided for @uruneklememetni.
  ///
  /// In en, this message translates to:
  /// **'Click the ‘+’ button above to add a product.'**
  String get uruneklememetni;

  /// No description provided for @uruneklememetni2.
  ///
  /// In en, this message translates to:
  /// **'Click the ‘+’ button above to add the product.'**
  String get uruneklememetni2;

  /// No description provided for @uruneklememetni_markali.
  ///
  /// In en, this message translates to:
  /// **'Click the ‘+’ button above to add the {brand} product.'**
  String uruneklememetni_markali(String brand);

  /// No description provided for @bildirimizinbaslik.
  ///
  /// In en, this message translates to:
  /// **'Notification Permission'**
  String get bildirimizinbaslik;

  /// No description provided for @bildirimizinmetin.
  ///
  /// In en, this message translates to:
  /// **'Would you like to receive a notification when prices drop? Turn on notifications.'**
  String get bildirimizinmetin;

  /// No description provided for @bildirimizinayaragit.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings'**
  String get bildirimizinayaragit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
