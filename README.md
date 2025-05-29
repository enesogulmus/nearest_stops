# Yakındaki Duraklar Uygulaması

Bu uygulama, kullanıcının bulunduğu konuma yakın otobüs duraklarını harita üzerinde gösteren ve seçilen durak için basit bir rota çizen bir Flutter uygulamasıdır.

## Özellikler

- OpenStreetMap entegrasyonu
- Kullanıcı konumu tespiti
- Yakındaki durakların listelenmesi
- Duraklar arası mesafe hesaplama
- Seçilen durak için basit rota çizimi
- Material Design 3 arayüzü

## Kullanılan Paketler

- flutter_map: ^8.1.1 (OpenStreetMap entegrasyonu için)
- geolocator: ^14.0.1 (Konum servisleri için)
- latlong2: ^0.9.1 (Koordinat işlemleri için)
- open_route_service: ^1.2.7 (Yönlendirme için)
- flutter_dotenv: ^5.2.1 (Api anahatarını güvenle saklamak için)
- mockito: ^5.4.6 (Sahte veri için)

## Geliştirme Süreci

Bu proje yaklaşık 5 saatte tamamlanmıştır. Geliştirme sürecinde:

1. Harita entegrasyonu ve mevcut konum gösterimi (20 dk)
2. Durak oluşturulması ve gösterilmesi (1 saat)
3. Durak listesinin oluşturulması ve gösterilmesi (10 dk)
4. Yönlendirme fonksiyonun eklenmesi (1 saat)
5. Yeni duraklar oluşturmak için yenile fonksiyonu (10 dk)
6. Api anahtarının güvene alınması (15 dk)
7. Widget ve Unit testlerin yazılması (2 saat 10 dk)
8. Readme dosyasının düzenlenmesi (15 dk)
9. Paket hazırlığı (10 dk)

## Proje Yapısı

```
lib/
  ├── main.dart
  ├── models/
  │   └── bus_stop.dart
  ├── screens/
  │   └── map_screen.dart
  ├── services/
  │   ├── location_service.dart
  │   └── bus_stop_service.dart
  └── widgets/
      ├── bus_stop_list.dart
      └── map_widget.dart
test/
  ├── unit/
  │    ├── models/
  │          └── bus_stop_test.dart
  │    ├── services/
  │          ├── bus_stop_service_test.dart
  │          └── location_service_test.dart
  ├── widget/
  │   ├── bus_stop_list_test.dart
  │   ├── map_screen_test.dart
  │   └── map_widget_test.dart
```

## Test

### Testlerin Çalıştırılması

Projedeki testler, Flutter'ın test komutu ile çalıştırılabilir. Örneğin, aşağıdaki komut tüm testleri (unit, widget, integration) çalıştırır:

```bash
flutter test
```

### Mevcut Test Dosyaları

Projede aşağıdaki test dosyaları bulunmaktadır:

- **Model Testleri:**
    - test/unit/models/bus_stop_test.dart  
      (BusStop modelinin doğru oluşturulduğunu ve varsayılan değerlerin atandığını kontrol eder.)

- **Servis Testleri:**
    - test/unit/services/bus_stop_service_test.dart  
      (BusStopService'in (örneğin, yakındaki durakları oluşturma, mesafe sıralaması, maksimum mesafe ve benzersiz ID) işlevlerini test eder.)
    - test/unit/services/location_service_test.dart  
      (LocationService'in (örneğin, konum dönüşümü) işlevlerini test eder.)

- **Widget Testleri:**
    - test/widget/bus_stop_list_test.dart  
      (BusStopList widget'ının doğru render edildiğini, seçim işlevinin çalıştığını ve seçili durak görünümünü kontrol eder.)
    - test/widget/map_widget_test.dart  
      (MapWidget'ın (örneğin, harita üzerinde durakların gösterilmesi) doğru render edildiğini kontrol eder.)
    - test/widget/map_screen_test.dart  
      (MapScreen'in doğru render edildiğini kontrol eder.)