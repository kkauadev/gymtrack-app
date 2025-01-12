import 'package:flutter/widgets.dart';

abstract final class Dimens {
  const Dimens();

  static const paddingHorizontal = 20.0;

  static const paddingVertical = 24.0;

  double get paddingScreenHorizontal;

  double get paddingScreenVertical;

  double get profilePictureSize;

  EdgeInsets get edgeInsetsScreenHorizontal =>
      EdgeInsets.symmetric(horizontal: paddingScreenHorizontal);

  EdgeInsets get edgeInsetsScreenSymmetric => EdgeInsets.symmetric(
      horizontal: paddingScreenHorizontal, vertical: paddingScreenVertical);

  static final Dimens mobile = _DimensMobile();

  factory Dimens.of(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).width) {
        _ => mobile,
      };
}

final class _DimensMobile extends Dimens {
  @override
  final double paddingScreenHorizontal = Dimens.paddingHorizontal;

  @override
  final double paddingScreenVertical = Dimens.paddingVertical;

  @override
  final double profilePictureSize = 64.0;
}
