import 'package:flutter/material.dart';

class CtaButtonWidget extends StatelessWidget {
  const CtaButtonWidget({
    required this.text,
    required this.color,
    super.key,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () {
          // Acción del botón
          debugPrint('Botón CTA presionado: $text');
        },
        child: Text(text),
      ),
    );
  }
}
