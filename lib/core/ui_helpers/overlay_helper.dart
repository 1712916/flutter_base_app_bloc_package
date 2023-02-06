import 'package:flutter/material.dart';
import 'package:flutter_base_app_bloc_package/routers/route_manager.dart';

class OverlayHelper {
  OverlayHelper._();

  static final OverlayHelper _instance = OverlayHelper._();

  static OverlayHelper get instance => _instance;

  final Map<String, OverlayEntry> overlayEntries = {};

  ///[tag] tạo tag để handle các overlay giống nhau không đè lên nhau
  ///[replaceTag] dùng để xóa một tag được chỉ định
  ///
  ///Có 1 cách khác để xóa 1 tag là truyền tag mới bằng chính tag cũ
  ///Nhưng cách này lại không rõ ràng nếu muốn hiển thị nhiều overlay cùng lúc
  void show(
    Widget child, {
    Duration duration = const Duration(seconds: 1),
    BuildContext? context,
    String? tag,
    String? replaceTag,
  }) {
    ///ưu tiên lấy context khi truyền vào
    ///nếu không thì xài của navigator key

    if (RouteManager.overlay != null || context != null) {
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) {
          return IgnorePointer(
            child: Material(
              color: Colors.transparent,
              child: child,
            ),
          );
        },
      );

      OverlayState? overlay;
      if (context != null) {
        overlay = Overlay.of(context);
      } else {
        overlay = RouteManager.overlay;
      }

      if (overlay != null) {
        //remove current tag
        removeByTag(tag);

        //remove another tag
        removeByTag(replaceTag);

        overlayEntries[tag ?? ''] = overlayEntry;

        //show overlay
        overlay.insert(overlayEntry);

        //remove overlay after duration
        Future.delayed(
          duration,
        ).then(
              (_) {
                if (overlayEntry.mounted) {
                  overlayEntries.remove(tag ?? '');
                  overlayEntry.remove();
                }
              },
        );
      }
    }
  }

  void removeByTag(String? tag) {
    if (overlayEntries.containsKey(tag)) {
      overlayEntries[tag]?.remove();
      overlayEntries.remove(tag);
    } else {
    }
  }

  void clear() {
    //note: nhớ handle cho nút back vật lý Android
    overlayEntries.forEach((_, value) {
      value.remove();
    });
    overlayEntries.clear();
  }
}