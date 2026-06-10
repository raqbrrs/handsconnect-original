import 'package:flutter/material.dart';
import '../models/sign_model.dart';
import '../theme/app_theme.dart';

class SignCard extends StatelessWidget {
  final SignModel sign;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const SignCard({
    super.key,
    required this.sign,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(sign.imageUrl, style: const TextStyle(fontSize: 24)),
        ),
        title: Text(sign.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        subtitle: Text(sign.category, style: const TextStyle(color: AppTheme.textLight)),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : AppTheme.textLight,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
