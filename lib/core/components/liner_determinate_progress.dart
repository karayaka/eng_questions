import 'package:flutter/material.dart';

class LinerDeterminateProgress extends StatefulWidget {
  double progress = 0.00;
  bool showProgres = true;
  LinerDeterminateProgress({
    this.progress = 0.00,
    Key? key,
    this.showProgres = true,
  }) : super(key: key);

  @override
  _LinerDeterminateProgressState createState() =>
      _LinerDeterminateProgressState();
}

class _LinerDeterminateProgressState extends State<LinerDeterminateProgress>
    with TickerProviderStateMixin {
  late AnimationController controller;

  double progressAnime = 0.00;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {
          progressAnime = controller.value;
          if (controller.value >= widget.progress) {
            progressAnime = widget.progress;
            controller.stop(canceled: false);
          }
        });
      });
    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var progressPercent = (progressAnime * 100).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.showProgres) ? Text("$progressPercent %") : Container(),
        (widget.showProgres)
            ? const SizedBox(
                height: 3,
              )
            : Container(),
        LinearProgressIndicator(
          value: progressAnime,
          minHeight: 7,
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
