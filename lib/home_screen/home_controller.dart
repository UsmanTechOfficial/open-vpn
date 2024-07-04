import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/vpn_config.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController {
  var vpnState = VpnEngine.vpnDisconnected.obs;
  var listVpn = <VpnConfig>[].obs;
  var selectedVpn = Rx<VpnConfig?>(null);
  var vpnStatus = VpnStatus().obs;

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
    } else {
      VpnEngine.stopVpn();
    }
  }
}
