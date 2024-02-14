import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class PermissionsCheck {
  static Location location = Location();
  static List<geo.Placemark> placemarks = [];
 
  static checkLocation({bool ask = false}) async {
   

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        permission.openAppSettings();
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (ask && (permissionGranted != PermissionStatus.granted)) {
      

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          permission.openAppSettings();
        }
      }
      return (permissionGranted  == PermissionStatus.granted);
    }

    return (permissionGranted == PermissionStatus.granted);
  }

  
}
