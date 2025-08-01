// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get hello => 'Merhaba';

  @override
  String get markalar => 'Markalar';

  @override
  String get ara => 'Ara';

  @override
  String get tumurunler => 'Tüm Ürünleriniz';

  @override
  String get urunleriniz => 'Ürünleriniz';

  @override
  String get siteyegit => 'Siteye Git';

  @override
  String get guncelfiyat => 'Güncel Fiyat';

  @override
  String get fiyatgecmisi => 'Fiyat Geçmişi';

  @override
  String get ilkfiyat => 'İlk Fiyat';

  @override
  String get linkgonder => 'Link Gönder';

  @override
  String get takipyapistirmetin =>
      'Takip etmek istediğiniz ürünün linkini buraya yapıştırınız ve gönderiniz.';

  @override
  String get yapistirmetin => 'Link buraya yapıştırın';

  @override
  String get yapistir => 'Yapıştır';

  @override
  String get gonder => 'Gönder';

  @override
  String get silmebaslik => 'Silme Onayı';

  @override
  String get silmemetin => 'Bu ürünü silmek istediğinize emin misiniz?';

  @override
  String get urunbulunamadi => 'Ürün Bulunamadı';

  @override
  String get urunbulunamadimetin =>
      'Seçilen markalardan takip edilmesini istediğiniz ürünün bağlantı adresini paylaşın.';

  @override
  String get hata => 'Hatalı';

  @override
  String get urunkontrol => 'Kontrol Ediliyor... Bekleyiniz';

  @override
  String get gecerligonder => 'Geçerli bir ürün linki gönderiniz.';

  @override
  String get urunkaydediliyor => 'Ürünleriniz Kaydediliyor... ';

  @override
  String get bitti => 'Bitti';

  @override
  String get bosgonderilemez => 'Boş gönderilemez';

  @override
  String get bildirimkapatildi => 'Bu ürün için bildirimler kapatıldı';

  @override
  String get bildirimacildi => 'Bu ürün için bildirimler açıldı';

  @override
  String get bildirimbulunamadi => 'Bildirim Bulunamadı';

  @override
  String get bildirimbulunamadimetin =>
      'Bildirimlerinizi burada görüntüleyebilirsiniz';

  @override
  String get bildirimler => 'Bildirimler';

  @override
  String get hatalikayitislemi => 'Hatalı Kayıt İşlemi';

  @override
  String get herhangiveribulunamadi => 'Herhangi bir veri bulunamadı';

  @override
  String get evet => 'Evet';

  @override
  String get hayir => 'Hayır';

  @override
  String get iptal => 'İptal';

  @override
  String get defaultOnay => 'Onayla';

  @override
  String get defaultOnayMetin =>
      'Bu işlemi yapmak istediğinizden emin misiniz?';

  @override
  String get ileri => 'İleri';

  @override
  String get geri => 'Geri';

  @override
  String get basla => 'Başla';

  @override
  String get markabulunamadi => 'Seçili marka bulunamadı';

  @override
  String get aramamarkabulunamadi => 'Aranan kritere göre marka bulunamadı';

  @override
  String get markasiteyegit => 'sitesine git ve linki paylaş';

  @override
  String get yardimtext1 => 'Linkleri nasıl paylaşabilirim?';

  @override
  String get yardimtext2 => '1. Browserdan \'Paylaş\' Seçeneğini Kullanarak:';

  @override
  String get yardimtext3 =>
      'Kullandığınız tarayıcıda paylaş simgesine tıklayarak linki kolayca paylaşabilirsiniz.';

  @override
  String get yardimtext4 => '2. Kopyala-Yapıştır Yöntemiyle:';

  @override
  String get yardimtext5 =>
      'Not: Linkler çalışmıyorsa doğru şekilde kopyaladığınızdan emin olun.';

  @override
  String get yardimtext6 =>
      'Note: If the links don\'t work, make sure you copied them correctly.';

  @override
  String get uruneklememetni =>
      'Ürün eklemek için yukarıdaki ‘+’ butonuna tıklayın.';

  @override
  String get uruneklememetni2 =>
      'ürünü eklemek için yukarıdaki ‘+’ butonuna tıklayın.';

  @override
  String uruneklememetni_markali(String brand) {
    return '$brand ürünü eklemek için yukarıdaki ‘+’ butonuna tıklayın.';
  }

  @override
  String get bildirimizinbaslik => 'Bildirim İzni';

  @override
  String get bildirimizinmetin =>
      'Fiyatlar düşünce bildirim almak ister misiniz? Bildirimlerinizi açın';

  @override
  String get bildirimizinayaragit => 'Ayarlara Git';

  @override
  String get urunlinkinipaylas => 'Ürünün Linkini Gönder';

  @override
  String get urunsitesinegit => 'Sitesine Git';

  @override
  String get dahafazlabilgi => 'Daha Fazla Bilgi Göster';

  @override
  String get dahaaz => 'Daha Az';
}
