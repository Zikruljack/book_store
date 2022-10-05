import 'package:book_store/util/dimension.dart';
import 'package:book_store/util/style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonText;
  final bool? transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButton(
      {super.key,
      this.onPressed,
      this.buttonText,
      this.transparent,
      this.margin,
      this.height,
      this.width,
      this.fontSize,
      this.radius = 5,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent!
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(width ?? Dimensions.webMaxWidth, height ?? 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimensions.webMaxWidth,
        child: Padding(
          padding: margin ?? const EdgeInsets.all(0),
          child: TextButton(
            onPressed: onPressed,
            style: flatButtonStyle,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          right: Dimensions.paddingSizeExtraSmall),
                      child: Icon(icon,
                          color: transparent!
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor),
                    )
                  : const SizedBox(),
              Text(buttonText ?? '',
                  textAlign: TextAlign.center,
                  style: robotoBold.copyWith(
                    color: transparent!
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                    fontSize: fontSize ?? Dimensions.fontSizeLarge,
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
