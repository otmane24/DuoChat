import 'package:flutter/material.dart';
import '../../../assistant_methode/size_config.dart';

class ContainerMessage extends StatelessWidget {
  final List<Widget> children;

  const ContainerMessage({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the maximum width of the Container
      constraints:
          BoxConstraints(maxWidth: 80 * SizeConfig.blockSizeHorizontal!),
      padding: EdgeInsets.symmetric(
          horizontal: 2.8 * SizeConfig.blockSizeHorizontal!,
          vertical: .8 * SizeConfig.blockSizeVertical!),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children,
      ),
    );
  }
}
