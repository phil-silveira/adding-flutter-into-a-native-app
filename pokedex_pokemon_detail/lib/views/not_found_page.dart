import 'package:flutter/cupertino.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Ops, page not found... But take this meme'),
          const SizedBox(height: 16),
          Image.network(
              'http://www.quickmeme.com/img/5f/5f4d250ca8f640d91572207253aa4134942d5d96b60652a55478d2c9698e79ed.jpg'),
        ],
      ),
    );
  }
}
