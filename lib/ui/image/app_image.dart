import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_base_app_bloc_package/ui/app_spinner.dart';

enum _ImageType { network, asset, svg }

class AppImage extends StatefulWidget {
  AppImage(this.url, {Key? key, this.boxFit, this.height, this.width, this.color, _ImageType imageType = _ImageType.network,}) : super(key: key) {
    _imageType = imageType;
  }

  final BoxFit? boxFit;
  final String url;
  final double? height;
  final double? width;
  final Color? color;
  late final _ImageType _imageType;

  factory AppImage.asset(String url, {BoxFit? boxFit, double? height, double? width, Color? color,}) {
    return AppImage(
      url,
      boxFit: boxFit,
      imageType: _ImageType.asset,
      width: width,
      height: height,
      color: color,
    );
  }

  factory AppImage.network(String url, {BoxFit? boxFit, double? height, double? width, Color? color,}) {
    return AppImage(
      url,
      boxFit: boxFit,
      imageType: _ImageType.network,
      width: width,
      height: height,
      color: color,
    );
  }

  factory AppImage.svg(String url, {BoxFit? boxFit, double? height, double? width, Color? color,}) {
    return AppImage(
      url,
      boxFit: boxFit,
      imageType: _ImageType.svg,
      width: width,
      height: height,
      color: color,
    );
  }

  @override
  _AppImageState createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  @override
  Widget build(BuildContext context) {
    switch (widget._imageType) {
      case _ImageType.network:
        return Image.network(
          widget.url,
          color: widget.color,
          fit: widget.boxFit,
          width: widget.width,
          height: widget.height,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return const AppSpinner();
          },
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        );
      case _ImageType.asset:
        return Image.asset(
          widget.url,
          color: widget.color,
          fit: widget.boxFit,
          width: widget.width,
          height: widget.height,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        );
      case _ImageType.svg:
        return SvgPicture.asset(
          widget.url,
          color: widget.color,
          fit: widget.boxFit ?? BoxFit.cover,
          width: widget.width,
          height: widget.height,
        );
    }
  }
}