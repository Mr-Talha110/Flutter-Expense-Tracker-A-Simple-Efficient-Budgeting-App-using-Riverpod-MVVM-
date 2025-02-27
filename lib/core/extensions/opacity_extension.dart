import 'dart:ui';

extension CustomOpacity on Color {
  Color withCustomOpacity(double opacity) {
    return withAlpha((opacity * 255).round());
  }
}
