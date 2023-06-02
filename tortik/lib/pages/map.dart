import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tortik/Services/app_location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CafeMap extends StatefulWidget {
  const CafeMap({Key? key}) : super(key: key);

  @override
  State<CafeMap> createState() => _CafeMapState();
}

class _CafeMapState extends State<CafeMap> {
  final mapControllerCompleter = Completer<YandexMapController>();

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _initPermission();
        },
        backgroundColor: const Color(0xFF5B2C6F),
        child: const Icon(Icons.my_location),
      ),
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: const Text(
          'Карта кофеен',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      body: YandexMap(
        mapObjects: [
          PlacemarkMapObject(
              mapId: const MapObjectId('Petrovka'),
              point: const Point(latitude: 55.765307, longitude: 37.615958),
              opacity: 1,
              consumeTapEvents: true,
              onTap: (PlacemarkMapObject, Point) {
                Fluttertoast.showToast(
                    msg: "улица Петровка, 19с1",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage('assets/dot.png')))),
          PlacemarkMapObject(
              mapId: const MapObjectId('Rozdestvenka'),
              point: const Point(latitude: 55.761060, longitude: 37.623420),
              opacity: 1,
              onTap: (PlacemarkMapObject, Point) {
                Fluttertoast.showToast(
                    msg: "улица Рождественка, 5/7с2",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor:Theme.of(context).colorScheme.onPrimary,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage('assets/dot.png')))),
          PlacemarkMapObject(
              mapId: const MapObjectId('Sretenka'),
              point: const Point(latitude: 55.767625, longitude: 37.631488),
              opacity: 1,
              onTap: (PlacemarkMapObject, Point) {
                Fluttertoast.showToast(
                    msg: "улица Сретенка, 9",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage('assets/dot.png')))),
          PlacemarkMapObject(
              mapId: const MapObjectId('Maroseyka'),
              point: const Point(latitude: 55.757750, longitude: 37.637119),
              opacity: 1,
              onTap: (PlacemarkMapObject, Point) {
                Fluttertoast.showToast(
                    msg: "улица Маросейка, 10/1с1",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage('assets/dot.png')))),
        ],
        onMapCreated: (YandexMapController controller) {
          mapControllerCompleter.complete(controller);
          controller.toggleUserLayer(visible: true, headingEnabled: true);
          controller.moveCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(
              target: Point(
                latitude: 55.7522200,
                longitude: 37.6155600,
              ),
              zoom: 8,
            ),
          ));
        },
      ),
    );
  }

  /// Проверка разрешений на доступ к геопозиции пользователя
  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  /// Получение текущей геопозиции пользователя
  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = MoscowLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  /// Метод для показа текущей позиции
  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 13,
        ),
      ),
    );
  }
}
