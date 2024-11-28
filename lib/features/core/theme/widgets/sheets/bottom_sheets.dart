import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_settings_plus/open_settings_plus.dart';
import 'package:tezdaassesment/features/core/assets/AssetsManager.dart';
import 'package:tezdaassesment/features/core/theme/widgets/sheets/GenericBottomSheet.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

void showYouAreOfflineSheet(BuildContext context) {
  context.showBottomSheet(
      GenericBottomSheet(
        title: context.getLocalization()!.you_are_offline,
        icon: AllAppAssets.NetworkIcon.getPath(),
        body: context.getLocalization()!.turn_on_your_internet_connection,
        actionText: context.getLocalization()!.turn_on_data,
        onAction: () async {
          switch (OpenSettingsPlus.shared) {
            case OpenSettingsPlusAndroid settings:
              {
                await settings.dataRoaming();
                try {
                  context.pop();
                } catch (e) {}
              }
            case OpenSettingsPlusIOS settings:
              {
                await settings.cellular();
                try {
                  context.pop();
                } catch (e) {}
              }
          }
        },
      ),
      maxHeightFactor: 0.8);
}

void showPoorNetworkSheet(BuildContext context, VoidCallback onRetry) {
  context.showBottomSheet(
      GenericBottomSheet(
        title: context.getLocalization()!.poor_slow_network,
        icon: AllAppAssets.NetworkIcon.getPath(),
        body: context
            .getLocalization()!
            .your_internet_connection_seems_to_be_poor,
        actionText: context.getLocalization()!.retry,
        onAction: () async {
          onRetry();
        },
      ),
      maxHeightFactor: 0.8);
}
