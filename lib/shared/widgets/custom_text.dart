import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final AlignmentDirectional alignment;
  final bool isBold;

  const CustomText({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.size = 16,
    this.alignment = AlignmentDirectional.center,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: ScreenUtilInit(
        builder: (BuildContext context, Widget? child) => Text(
          text,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(size),
            color: color,
            fontWeight: isBold ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }
}
