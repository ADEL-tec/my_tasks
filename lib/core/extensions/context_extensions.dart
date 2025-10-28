import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
