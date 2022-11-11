import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherForSmsAndEmail extends StatelessWidget {
  UrlLauncherForSmsAndEmail({Key? key}) : super(key: key);

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: '19sw37@gmail.com',
    // query:
    //     '${Uri.encodeComponent('subject')}=${Uri.encodeComponent('please improve the performance of application and fix bugs')}',
    queryParameters: <String, String>{
      'body': Uri.encodeComponent(
          'please improve the performance of application and fix bugs'),
    },
  );

  final Uri smsLaunchUri = Uri(
    scheme: 'sms',
    path: '0118 999 881 999 119 7253',
    query:
        '${Uri.encodeComponent('subject')}=${Uri.encodeComponent('please improve the performance of application and fix bugs')}',
    // queryParameters: <String, String>{
    //   'body': Uri.encodeComponent(
    //       'please improve the performance of application and fix bugs'),
    // },
  );

  void _sendSms() async {
    await launchUrl(smsLaunchUri);
  }

  void _sendEmail() async {
    await launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Launcher'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Lab 10',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              'For sending SMS',
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton(
              onPressed: _sendSms,
              child: const Text('Send SMS'),
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              'For sending Email',
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton(
              onPressed: _sendEmail,
              child: const Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}
