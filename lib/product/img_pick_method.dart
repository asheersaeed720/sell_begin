import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class ImgPickMethod {
  const ImgPickMethod({
    required this.icon,
    required this.name,
    required this.description,
    required this.method,
  });

  factory ImgPickMethod.cameraAndStay({required int maxAssetsCount}) {
    return ImgPickMethod(
      icon: '📸',
      name: 'Camera',
      description: 'Take a photo with the camera picker',
      method: (BuildContext context, List<AssetEntity> assets) {
        return AssetPicker.pickAssets(
          context,
          maxAssets: maxAssetsCount,
          selectedAssets: assets,
          requestType: RequestType.common,
          specialItemPosition: SpecialItemPosition.prepend,
          textDelegate: EnglishTextDelegate(),
          specialItemBuilder: (BuildContext context) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                final AssetEntity? result = await CameraPicker.pickFromCamera(
                  context,
                  enableRecording: true,
                );
                if (result != null) {
                  final AssetPicker<AssetEntity, AssetPathEntity> picker =
                      context.findAncestorWidgetOfExactType()!;
                  final DefaultAssetPickerProvider p =
                      picker.builder.provider as DefaultAssetPickerProvider;
                  await p.currentPathEntity!.refreshPathProperties();
                  await p.switchPath(p.currentPathEntity!);
                  p.selectAsset(result);
                }
              },
              child: const Center(
                child: Icon(Icons.camera_enhance, size: 42.0),
              ),
            );
          },
        );
      },
    );
  }

  factory ImgPickMethod.image(int maxAssetsCount) {
    return ImgPickMethod(
      icon: '🖼️',
      name: 'Gallery',
      description: 'Only pick image from Gallery.',
      method: (BuildContext context, List<AssetEntity> assets) {
        return AssetPicker.pickAssets(
          context,
          maxAssets: maxAssetsCount,
          selectedAssets: assets,
          requestType: RequestType.image,
          textDelegate: EnglishTextDelegate(),
        );
      },
    );
  }

  final String icon;
  final String name;
  final String description;
  final Future<List<AssetEntity>?> Function(
    BuildContext context,
    List<AssetEntity> selectedAssets,
  ) method;
}
