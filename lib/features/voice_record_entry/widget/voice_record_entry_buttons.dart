import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/widgets/primary_circular_icon_button.dart';

class VoiceRecordEntryButtons extends StatelessWidget {
  const VoiceRecordEntryButtons({
    super.key,
    required this.isRecording,
    required this.onTapStop,
    required this.onTapPlayer,
  });

  final bool isRecording;
  final VoidCallback onTapStop;
  final VoidCallback onTapPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryCircularIconButton(
          icon: PhosphorIcons.stop(),
          onTap: onTapStop,
        ),
        PrimaryCircularIconButton(
          icon: isRecording ? PhosphorIcons.pause() : PhosphorIcons.play(),
          onTap: onTapPlayer,
        ),
      ],
    );
  }
}
