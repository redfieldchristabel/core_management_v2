// import 'package:dbkl_sppc/screens/spupc_app_theme.dart';
import 'package:core_management_v2/core_management_v2.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
// import 'package:optimization_battery/optimization_battery.dart';

//TODO make it modular and customizable by consumer
class EnableNotificationsAlert extends StatelessWidget {
  const EnableNotificationsAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
      child: Column(
        children: [
          Icon(
            Icons.notifications_active_outlined,
            color: context.themeData.primaryColor,
            size: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "SPPC Ingin Menghantar Notifikasi Kepada Anda.",
              // "Peranti anda tidak membenarkan aplikasi ini untuk menghantar notifikasi sekiranya aplikasi ini ditutup (Swipe Up).",
              style: context.themeData.textTheme.headlineMedium!
                  .copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Peranti anda mungkin tidak menerima notifikasi sekiranya aplikasi ini ditutup kerana fungsi Pengoptimuman Bateri aplikasi ini diaktifkan. Klik butang di bawah untuk menyahaktifkan fungsi dan menerima notifikasi.",
              // "Notifikasi tidak boleh dihantar sekiranya aplikasi ini ditutup! Klik butang di bawah bagi membenarkan notifikasi dihantar walaupun aplikasi ini telah ditutup.",
              // "Klik butang di bawah bagi membenarkan aplikasi ini menghantar notifikasi.",
              style: context.themeData.textTheme.displayMedium!
                  .copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () async {
                  await DisableBatteryOptimization.showEnableAutoStartSettings(
                      "Enable Auto Start",
                      "Follow the steps and enable the auto start of this app");
                },
                child: Text(
                  "Buka Tetapan Peranti",
                  style: context.themeData.textTheme.displaySmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: context.themeData.primaryColor,
                  elevation: 0,
                  side: BorderSide(
                    width: 1.0,
                    color: context.themeData.primaryColor,
                  ),
                ),
                child: Text(
                  "Tidak, Terima kasih.",
                  style: context.themeData.textTheme.displaySmall!
                      .copyWith(color: context.themeData.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
