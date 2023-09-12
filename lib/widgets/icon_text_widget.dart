import 'package:flutter/cupertino.dart';
import 'package:grocery_store/utils/dimensions.dart';
import 'package:grocery_store/widgets/small_text.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final double size;
  final Color iconColor;
  const IconTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor, required this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: size,),
        SizedBox(width: Dimensions.width10-5,),
        SmallText(text: text),
      ]

    );
  }
}
