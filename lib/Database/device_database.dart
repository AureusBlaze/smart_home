import 'package:smart_home/Database/device.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeviceDatabase {
  // Database -> Devices

  final database = Supabase.instance.client.from('devices');

  // Create
  Future addDevice(Device newDevice) async {
    await database.insert(newDevice.toMap());
  }

  // Read
  final stream = Supabase.instance.client
      .from('devices')
      .stream(primaryKey: ['id'])
      .map(
        (data) => data.map((deviceMap) => Device.fromMap(deviceMap)).toList(),
      );

  // Update
  Future updateDevices(Device oldDevice, String newContent) async {
    await database.update({'content': newContent}).eq('id', oldDevice);
  }

  // Delete
  Future deleteDevice(Device device) async {
    await database.delete().eq('id', device.id!);
  }
}
