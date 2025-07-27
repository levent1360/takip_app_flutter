import 'package:flutter/material.dart';
import 'package:takip/features/onboarding/onboarding_screen.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  void _continueToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => OnboardingScreen(),
      ), // HomePage'i import etmeyi unutma
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İzin Gerekli')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 80, color: Colors.orangeAccent),
            SizedBox(height: 24),
            Text(
              'Devam edebilmek için Bildirimlere İzin Vermeniz gerekiyor',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),

            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _continueToHome(context),
                child: Text('Devam Et'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateColor.resolveWith((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors
                          .grey; // disabled durumu için arka plan rengi
                    }
                    return Colors.teal; // normal durumda arka plan rengi
                  }),
                  foregroundColor: WidgetStateColor.resolveWith((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors
                          .black38; // disabled durumu için yazı ve ikon rengi
                    }
                    return Colors.white; // normal durumda yazı ve ikon rengi
                  }),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(vertical: 16),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
