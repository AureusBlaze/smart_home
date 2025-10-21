import 'package:flutter/material.dart';
// import 'package:smart_home/approutes.dart';
import 'package:smart_home/pages/Devices/smart_lights_page.dart';
// import 'package:smart_home/pages/device_details_page.dart';
import 'package:smart_home/pages/profile_page.dart';
import 'package:smart_home/util/basic_custom_drawer.dart';
import 'package:smart_home/util/smart_device_box.dart';
import 'package:smart_home/pages/Devices/smart_ac_page.dart';
import 'package:smart_home/pages/Devices/smart_speaker_page.dart';
import 'package:smart_home/pages/Devices/smart_tv_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constant
  final double horizontalPadding = 40;
  final double verticalPadding = 15;

  // list of smart devices
  List mySmartDevices = [
    // [device name, icon path, power status]
    [
      "Smart Light",
      "lib/assets/icons/light_bulb.png",
      true,
      const SmartLightsPage(),
      // Approutes.lightPage,
    ],
    [
      "Smart AC",
      "lib/assets/icons/air-conditioner.png",
      false,
      const SmartAcPage(),
      // Approutes.lightPage,
    ],
    [
      "Smart TV",
      "lib/assets/icons/smart_tv_2.png",
      false,
      const SmartTvPage(),
      // Approutes.lightPage
    ],
    [
      "Smart Speaker",
      "lib/assets/icons/sm speaker.png",
      true,
      const SmartSpeakerPage(),
      // Approutes.lightPage,
    ],
  ];

  // power switch changed

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const BasicCustomDrawer(),
      // drawer: SafeArea(
      //   child: Drawer(
      //     backgroundColor: Colors.grey[900],
      //     child: Center(
      //       child: Text(
      //         "Menu",
      //         style: TextStyle(fontSize: 24, color: Colors.grey[100]),
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // custom app bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // menu icon
                  Builder(
                    builder: (context) => Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },

                          child: Image.asset(
                            'lib/assets/icons/menu.png',
                            height: 45,
                            color: Colors.grey[900],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //account icon
                  Builder(
                    builder: (context) => Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.grey[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // welcome home message
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "welcome home,",
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  Text(
                    "Omar Sami",
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 2,
                          color: Colors.grey.shade600,
                        ),
                        Shadow(
                          offset: Offset(-2, -2),
                          blurRadius: 2,
                          color: Colors.white,
                        ),
                      ],
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Divider(
              color: Colors.grey[500],
              thickness: 3,
              indent: horizontalPadding,
              endIndent: horizontalPadding,
            ),
            const SizedBox(height: 40),

            // smart devices + grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Smart Devices",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 0),

            Expanded(
              child: GridView.builder(
                itemCount: mySmartDevices.length,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDevicesName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    powerOn: mySmartDevices[index][2],
                    onChanged: (value) => powerSwitchChanged(value, index),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => mySmartDevices[index][3],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
