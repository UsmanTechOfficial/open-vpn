import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/vpn_config.dart';
import 'controller.dart';

const kBgColor = Color(0xff246CE2);

class HomeScreen extends StatelessWidget {
  final VpnController vpnController = Get.put(VpnController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: vpnController.scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.electric_bolt,
                    color: Colors.orangeAccent,
                    size: 26,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Open VPN',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: kBgColor,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeLanguage()));
              },
              leading: const Icon(Icons.translate, size: 18),
              title:
                  const Text('Change Language', style: TextStyle(fontSize: 14)),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
            const ListTile(
              leading: Icon(Icons.rate_review, size: 18),
              title: Text('Rate US', style: TextStyle(fontSize: 14)),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
            const ListTile(
              leading: Icon(Icons.share, size: 18),
              title: Text('Share App', style: TextStyle(fontSize: 14)),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
            const ListTile(
              leading: Icon(Icons.info, size: 18),
              title: Text('About', style: TextStyle(fontSize: 14)),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          elevation: 0,
          backgroundColor: kBgColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: kBgColor,
            statusBarBrightness: Brightness.dark, // For iOS: (dark icons)
            statusBarIconBrightness:
                Brightness.light, // For Android: (dark icons)
          ),
        ),
      ),
      backgroundColor: kBgColor,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.4,
              child: Column(
                children: [
                  // Header action icons
                  Container(
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: InkWell(
                            onTap: () {
                              vpnController.scaffoldKey.currentState
                                  ?.openDrawer();
                            },
                            child: const Icon(
                              Icons.segment,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.electric_bolt,
                              color: Colors.orangeAccent,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Open VPN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.settings_outlined,
                            color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: kBgColor,
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.02),
                          InkWell(
                            borderRadius: BorderRadius.circular(size.height),
                            onTap: () {
                              vpnController.connectClick();
                            },
                            child: Obx(() => Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      width: size.height * 0.12,
                                      height: size.height * 0.12,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.power_settings_new,
                                              size: size.height * 0.035,
                                              color: kBgColor,
                                            ),
                                            Text(
                                              vpnController.isConnected.value
                                                  ? 'Disconnect'
                                                  : 'Tap to Connect',
                                              style: TextStyle(
                                                fontSize: size.height * 0.013,
                                                fontWeight: FontWeight.w500,
                                                color: kBgColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Column(
                            children: [
                              Obx(() => Container(
                                    alignment: Alignment.center,
                                    width: vpnController.isConnected.value
                                        ? 90
                                        : size.height * 0.14,
                                    height: size.height * 0.030,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      vpnController.isConnected.value
                                          ? 'Connected'
                                          : 'Not Connected',
                                      style: TextStyle(
                                        fontSize: size.height * 0.015,
                                        color: kBgColor,
                                      ),
                                    ),
                                  )),
                              SizedBox(height: size.height * 0.012),
                              Obx(() => _countDownWidget(
                                  size, vpnController.duration.value)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Platform.isIOS ? size.height * 0.51 : size.height * 0.565,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  // Horizontal line
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: Color(0xffB4B4C7),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    height: size.height * 0.005,
                    width: 35,
                  ),
                  // Connection Information
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 30, 30, 0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: size.height * 0.07,
                                        height: size.height * 0.07,
                                        child: Obx(() => CircleAvatar(
                                              backgroundImage: AssetImage(vpnController
                                                          .selectedVpn
                                                          .value
                                                          ?.country ==
                                                      'Japan'
                                                  ? 'assets/images/japan_flag.png'
                                                  : 'assets/images/thailand_flag.png'),
                                            )),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Obx(() => Text(
                                                vpnController.selectedVpn.value
                                                        ?.country ??
                                                    'Select Country',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 22,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffFEF7F0),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Text(
                                              'Free Server',
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'NEW YORK CITY',
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: size.height * 0.07,
                                        height: size.height * 0.07,
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.equalizer_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            '10',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            ' ms',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'PING',
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: size.height * 0.07,
                                          height: size.height * 0.07,
                                          decoration: const BoxDecoration(
                                            color: Color(0xff20C4F8),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_downward,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: const [
                                            Text(
                                              '15.47',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              ' mbps',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'DOWNLOAD',
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: size.height * 0.07,
                                          height: size.height * 0.07,
                                          decoration: const BoxDecoration(
                                            color: Color(0xff8220F9),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_upward,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: const [
                                            Text(
                                              '250',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              ' mbps',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'UPLOAD',
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: kBgColor,
                    child: InkWell(
                      onTap: () {
                        _showLocationPopup(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Row(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' Change Location',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 25,
                                  color: kBgColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: vpnController.listVpn.map((VpnConfig config) {
              return ListTile(
                title: Text(config.country),
                onTap: () {
                  vpnController.changeLocation(config);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _countDownWidget(Size size, Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours.remainder(60));

    return Text(
      '$hours : $minutes : $seconds',
      style: TextStyle(
        color: Colors.white,
        fontSize: size.height * 0.03,
      ),
    );
  }
}
