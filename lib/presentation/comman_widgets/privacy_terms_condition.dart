import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsPrivacyDialog extends StatelessWidget {
  TermsPrivacyDialog({super.key, required this.mdFileName})
      : assert(mdFileName.contains('.md'));

  final String mdFileName;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: Future.delayed(const Duration(microseconds: 150))
                      .then((value) =>
                          rootBundle.loadString('asset/$mdFileName')),
                  builder: (context, snapshot) {
                    // print(snapshot.data);
                    if (snapshot.hasData) {
                      return Markdown(
                          styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                              textTheme: const TextTheme(
                                  bodyMedium: TextStyle(
                                      fontSize: 15.0, color: Colors.black)))),
                          data: snapshot.data.toString());
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    );
                  })),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
