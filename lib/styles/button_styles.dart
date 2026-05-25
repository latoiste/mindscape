import 'package:flutter/material.dart';

final primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFFE85AD9),
  foregroundColor: Colors.white,
  elevation: 12,
  shadowColor: const Color(0xFF9C1FA8).withValues(alpha: 0.7),
  padding: const EdgeInsets.symmetric(vertical: 12),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: const BorderSide(
      color: Color(0xFFB92AC3),
      width: 6,
    ),
  ),
);