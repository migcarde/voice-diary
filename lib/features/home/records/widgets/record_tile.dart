import 'package:flutter/widgets.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/features/home/records/models/record_view_model.dart';

class RecordTile extends StatelessWidget {
  const RecordTile({
    super.key,
    required this.recordViewModel,
  });

  final RecordViewModel recordViewModel;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(
        AppDimens.m,
      ),
      decoration: ContainerDecorators.card(
        color: theme.colorScheme.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recordViewModel.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimens.m,
            ),
            child: Wrap(
              spacing: AppDimens.s,
              runSpacing: AppDimens.s,
              children: recordViewModel.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.s,
                        vertical: AppDimens.xs,
                      ),
                      decoration: ContainerDecorators.circular(
                        color: theme.colorScheme.primaryContainer,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tag,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
