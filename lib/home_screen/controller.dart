import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

import '../models/vpn_config.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class VpnController extends GetxController {
  var vpnState = VpnEngine.vpnDisconnected.obs;
  var listVpn = <VpnConfig>[].obs;
  var selectedVpn = Rx<VpnConfig?>(null);
  var vpnStatus = VpnStatus().obs;
  var isConnected = false.obs;
  var duration = Duration().obs;
  Timer? timer;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    VpnEngine.vpnStageSnapshot().listen((event) {
      vpnState.value = event;
    });

    VpnEngine.vpnStatusSnapshot().listen((event) {
      vpnStatus.value = event ?? VpnStatus();
    });

    initVpn();
  }

  void initVpn() async {
    listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/japan.ovpn'),
        country: 'Japan',
        username: 'vpn',
        password: 'vpn'));

    listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/thailand.ovpn'),
        country: 'Thailand',
        username: 'vpn',
        password: 'vpn'));

    selectedVpn.value = listVpn.first;
  }

  void connectClick() {
    if (selectedVpn.value == null) return;

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      VpnEngine.startVpn(selectedVpn.value!);
      startTimer();
    } else {
      VpnEngine.stopVpn();
      stopTimer();
    }
    isConnected.value = !isConnected.value;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = 1;
      duration.value = Duration(seconds: duration.value.inSeconds + addSeconds);
    });
  }

  void stopTimer() {
    timer?.cancel();
    duration.value = Duration();
  }

  void changeLocation(VpnConfig config) {
    selectedVpn.value = config;
  }
}
