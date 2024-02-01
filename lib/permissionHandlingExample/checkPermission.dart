import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(
    home: PermissionCheck(),
  ));
}

class PermissionCheck extends StatelessWidget {
  const PermissionCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permission Handler"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              askCameraPermission(context);
            },
            child: const Text("Camera Permission"),
          ),
          const Spacer(
            flex: 1,
          ),
          ElevatedButton(
            onPressed: () {
              askMultiPermission();
            },
            child: const Text("MultiPermission"),
          ),
          const Spacer(
            flex: 1,
          ),
          ElevatedButton(
            onPressed: () {
              openSettings();
            },
            child: const Text("app  Settings"),
          ),
        ],
      ),
    );
  }

  void askCameraPermission(BuildContext context) async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.camera.status;
   // if (status.isGranted)
    if (await Permission.camera.request().isGranted)
    {
      var picker = ImagePicker();
      picker.pickImage(source: ImageSource.camera);
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission Denied")));
    }

    if (await Permission.camera.request().isGranted) {
      print("Granted");
    }
  }

  /// Request multiple permissions at once.
  /// / In this case location & storage
  void askMultiPermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
      Permission.mediaLibrary,
      Permission.contacts,
      Permission.phone,
      Permission.photos
    ].request();
    print(
        "Status location ${status[Permission.location]} photos ${status[Permission.photos]}");
  }
  /// The user opted to never again see the permission request dialog for this
  /// app. The only way to change the permission's status now is to let the
  /// user manually enable it in the system settings.
  void openSettings() async {
   openAppSettings();
  }
}
// You can can also directly ask the permission about its status.
// if (await Permission.location.isRestricted) {
//   // The OS restricts access, for example because of parental controls.
// }