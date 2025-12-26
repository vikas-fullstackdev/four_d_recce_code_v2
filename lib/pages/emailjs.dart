import 'package:emailjs/emailjs.dart' as emailjs;

Future<void> sendTestEmail() async {
  await emailjs.send(
    'service_qencgko',
    'template_e14pxgp',
    {
      'message': 'Button clicked – email test successful',
    },
    emailjs.Options(
      publicKey: '2UEaTIwQmzWx-yLCc',
    ),
  );
}
