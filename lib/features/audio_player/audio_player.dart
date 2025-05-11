import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/extensions/duration_extensions.dart';
import 'package:voice_diary/features/audio_player/cubit/audio_player_cubit.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.status.isReady || state.status.isInitialized) ...[
              Row(
                children: [
                  Text(
                    state.position.toFormattedString,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  Expanded(
                    child: Slider(
                      value: state.position.inSeconds.toDouble(),
                      max: state.recordDuration.inSeconds.toDouble(),
                      divisions: state.recordDuration.inSeconds,
                      onChanged: (duration) {
                        if (duration >= 0.0 || duration <= 5.0) {
                          context.read<AudioPlayerCubit>().updateDuration(
                                Duration(
                                  seconds: duration.toInt(),
                                ),
                              );
                        }
                      },
                    ),
                  ),
                  Text(
                    state.recordDuration.toFormattedString,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (state.status.isPlaying) {
                    context.read<AudioPlayerCubit>().pause();
                  } else if (state.status.isPaused) {
                    context.read<AudioPlayerCubit>().resume();
                  } else {
                    context.read<AudioPlayerCubit>().start();
                  }
                },
                child: Icon(
                  state.status.isPlaying
                      ? PhosphorIcons.pause()
                      : PhosphorIcons.play(),
                  size: AppDimens.iconButtonSize,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
            if (state.status.isInitial)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
