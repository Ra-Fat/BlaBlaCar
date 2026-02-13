import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_icon_button.dart';


// / A reusable form picker row widget to display an icon, label/value
class FormPicker extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final bool isPlaceHolder;
  final IconData? rightIcon;
  final VoidCallback onTab;
  final VoidCallback? onRightIconTab;

  const FormPicker({
    super.key,
    required this.title,
    required this.onTab,
    required this.leftIcon,
    this.rightIcon,
    this.onRightIconTab,
    this.isPlaceHolder = false,
  });

  Color get textColor => isPlaceHolder
        ? BlaColors.neutralLight
        : BlaColors.neutralDark;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: onTab,
      title: Text(
        title,
        style: BlaTextStyles.button.copyWith(fontSize: 14, color: textColor),
      ),
      leading: Icon(leftIcon, size: BlaSize.icon, color: BlaColors.iconLight),
      trailing: rightIcon != null
          ? BlaIconButton(icon: rightIcon, onPressed: onRightIconTab)
          : null,
    );
  }
}

