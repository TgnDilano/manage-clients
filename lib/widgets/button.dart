import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management/constant/colors.dart';

class NButton extends StatelessWidget {
  const NButton({
    super.key,
    this.text,
    this.backgroundColor = AppColors.kPrimary,
    required this.onTap,
    this.isOutlined = false,
    this.isLoading = false,
    this.radius = 8,
    this.width,
    this.height,
    this.isEnabled = true,
  });

  final String? text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final bool isOutlined;
  final bool isLoading, isEnabled;
  final double radius;
  final double? width;
  final double? height;

  Color? getButtonColor() {
    if (isLoading) return backgroundColor;
    if (!isEnabled) return AppColors.kPrimary;
    if (isOutlined) return AppColors.kPrimary;
    return backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: isOutlined && isEnabled
                ? BorderSide(
                    color: isOutlined
                        ? Theme.of(context).primaryColor
                        : backgroundColor ?? (AppColors.kPrimary),
                    width: 0.6,
                  )
                : BorderSide.none,
          ),
          backgroundColor: isLoading
              ? Theme.of(context).primaryColor.withOpacity(0.8)
              : isOutlined
                  ? Colors.transparent
                  : Theme.of(context).primaryColor,
        ),
        onPressed: isEnabled && !isLoading ? onTap : null,
        child: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeIn,
          child: isLoading
              ? const CupertinoActivityIndicator(
                  animating: true,
                  color: Colors.white,
                  radius: 14,
                )
              : Text(
                  text ?? "OK",
                  maxLines: 1,
                  style: TextStyle(
                    color: isOutlined
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
