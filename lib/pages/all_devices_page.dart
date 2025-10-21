import 'package:flutter/material.dart';
import 'package:smart_home/Database/device.dart';
import 'package:smart_home/Database/device_database.dart';
import 'package:smart_home/util/device_card.dart';

class AllDevicesPage extends StatefulWidget {
  const AllDevicesPage({super.key});

  @override
  State<AllDevicesPage> createState() => _AllDevicesPageState();
}

class _AllDevicesPageState extends State<AllDevicesPage> {
  //notes database
  final deviceDatabase = DeviceDatabase();

  // text controller
  final deviceController = TextEditingController();

  //-----------

  // user want to add new device
  void addNewDevice() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          "NEW DEVICE",
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: deviceController,
          decoration: InputDecoration(
            hintText: "Enter device name",
            hintStyle: TextStyle(color: Colors.grey[500]),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade900),
            ),
          ),
          style: TextStyle(color: Colors.grey[900]),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deviceController.clear();
            },
            child: Text("Cancel", style: TextStyle(color: Colors.grey[700])),
          ),
          TextButton(
            onPressed: () {
              final newDevice = Device(content: deviceController.text);
              deviceDatabase.addDevice(newDevice);
              Navigator.pop(context);
              deviceController.clear();
            },
            child: Text("SAVE", style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  // user want to update one of the Devices
  void updateDevice(Device device) {
    // pre-fill text controller with existing device
    deviceController.text = device.content ?? '';

    // the editing box
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          "UPDATE DEVICE",
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: deviceController,
          decoration: InputDecoration(
            hintText: "Enter device name",
            hintStyle: TextStyle(color: Colors.grey[500]),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade900),
            ),
          ),
          style: TextStyle(color: Colors.grey[900]),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deviceController.clear();
            },
            child: Text("Cancel", style: TextStyle(color: Colors.grey[700])),
          ),
          TextButton(
            onPressed: () {
              //update in database
              deviceDatabase.updateDevices(device, deviceController.text);
              Navigator.pop(context);
              deviceController.clear();
            },
            child: Text("Edit", style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  // user wants to delete a device
  void deleteDevice(Device device) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          "DELETE DEVICE?",
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deviceController.clear();
            },
            child: Text("Cancel", style: TextStyle(color: Colors.grey[700])),
          ),
          TextButton(
            onPressed: () {
              deviceDatabase.deleteDevice(device);
              Navigator.pop(context);
              deviceController.clear();
            },
            child: Text("Delete", style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[300]),
        title: Text("All Devices", style: TextStyle(color: Colors.grey[100])),
        backgroundColor: Colors.grey[900],
      ),

      body: StreamBuilder(
        //listen to this stream..
        stream: deviceDatabase.stream,

        // building the UI...
        builder: (context, snapshot) {
          //loading..
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          //loaded!
          final devices = snapshot.data!;

          //list of devices UI
          return ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              //get each device
              final device = devices[index];

              //list tile UI
              return DeviceCard(
                icon: Icons.devices_other,
                title: device.content ?? '',
                onEdit: () => updateDevice(device),
                onDelete: () => deleteDevice(device),
              );
            },
          );

          //
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: const Offset(5, 5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 0,
          onPressed: addNewDevice,
          child: Icon(Icons.add, color: Colors.grey[900]),
        ),
      ),
    );
  }
}

            // DeviceCard(icon: Icons.lightbulb, title: "Smart Lights"),
            //smart display, Smart thermostat, Smart Audio System,  Smart Camera, Smart projector, Smart doorbell, Smart doorlock