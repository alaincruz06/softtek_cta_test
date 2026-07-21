import 'package:flutter/material.dart' show Color, immutable;

@immutable
class CtaConfig {
  const CtaConfig({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CtaConfig && other.text == text && other.color == color;
  }

  @override
  int get hashCode => Object.hash(text, color);
}
