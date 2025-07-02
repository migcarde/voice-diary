import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/widgets/primary_circular_icon_button.dart';

class VoiceRecordEntryStoppedButtons extends StatelessWidget {
  const VoiceRecordEntryStoppedButtons({
    super.key,
    required this.onTapDelete,
    required this.onTapSave,
  });

  final VoidCallback onTapDelete;
  final VoidCallback onTapSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryCircularIconButton(
          icon: PhosphorIcons.trash(),
          onTap: onTapDelete,
        ),
        PrimaryCircularIconButton(
          icon: PhosphorIcons.check(),
          onTap: onTapSave,
        ),
      ],
    );
  }
}
