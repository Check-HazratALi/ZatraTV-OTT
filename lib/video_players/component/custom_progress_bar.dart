import 'package:flutter/material.dart';
import 'package:zatra_tv/utils/colors.dart';

class CustomProgressBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final List<Duration> adBreaks;
  final bool isAdPlaying;
  final void Function(Duration)? onSeek;
  final List<DurationRange>? buffered;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final Color? adMarkerColor;
  final double height;

  const CustomProgressBar({
    super.key,
    required this.position,
    required this.duration,
    required this.adBreaks,
    this.isAdPlaying = false,
    this.onSeek,
    this.buffered,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.adMarkerColor,
    this.height = 32,
  });

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  bool _isDragging = false;
  double _dragValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final progress = widget.duration.inSeconds == 0
        ? 0
        : widget.position.inSeconds / widget.duration.inSeconds;

    final displayValue = _isDragging ? _dragValue : progress;
    final activeColor = widget.activeColor ?? appColorPrimary;
    final inactiveColor = widget.inactiveColor ?? borderColorDark;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: widget.isAdPlaying
          ? null
          : (details) {
              _startDrag(details, context);
            },
      onHorizontalDragUpdate: widget.isAdPlaying
          ? null
          : (details) {
              _updateDrag(details, context);
            },
      onHorizontalDragEnd: widget.isAdPlaying
          ? null
          : (_) {
              _endDrag();
            },
      onHorizontalDragCancel: widget.isAdPlaying
          ? null
          : () {
              _endDrag();
            },
      onTapDown: widget.isAdPlaying
          ? null
          : (details) {
              _handleTap(details, context);
            },
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            // Background track
            _buildBackgroundTrack(inactiveColor),

            // Buffered progress
            if (widget.buffered != null && widget.buffered!.isNotEmpty)
              _buildBufferedTrack(),

            // Played progress
            _buildActiveTrack(displayValue.toDouble(), activeColor),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundTrack(Color color) {
    return Positioned.fill(
      child: Center(
        child: Container(
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildBufferedTrack() {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: widget.buffered!.map((range) {
              final start = widget.duration.inMilliseconds == 0
                  ? 0
                  : range.start.inMilliseconds / widget.duration.inMilliseconds;
              final end = widget.duration.inMilliseconds == 0
                  ? 0
                  : range.end.inMilliseconds / widget.duration.inMilliseconds;
              final width = (end - start).clamp(0.0, 1.0);

              return Positioned(
                left: start * constraints.maxWidth,
                child: Container(
                  width: width * constraints.maxWidth,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildActiveTrack(double progress, Color color) {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: progress.clamp(0.0, 1.0) * constraints.maxWidth,
              height: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        },
      ),
    );
  }

  void _startDrag(DragStartDetails details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final width = box.size.width;

    setState(() {
      _isDragging = true;
      _dragValue = (localPosition.dx / width).clamp(0.0, 1.0);
    });
  }

  void _updateDrag(DragUpdateDetails details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final width = box.size.width;

    setState(() {
      _dragValue = (localPosition.dx / width).clamp(0.0, 1.0);
    });
  }

  void _endDrag() {
    if (widget.onSeek != null && _isDragging) {
      final newPosition = Duration(
        seconds: (_dragValue * widget.duration.inSeconds).round(),
      );
      widget.onSeek!(newPosition);
    }

    setState(() {
      _isDragging = false;
    });
  }

  void _handleTap(TapDownDetails details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final width = box.size.width;
    final tapValue = (localPosition.dx / width).clamp(0.0, 1.0);

    if (widget.onSeek != null) {
      final newPosition = Duration(
        seconds: (tapValue * widget.duration.inSeconds).round(),
      );
      widget.onSeek!(newPosition);
    }
  }
}

// DurationRange class definition (if not already defined)
class DurationRange {
  final Duration start;
  final Duration end;

  const DurationRange(this.start, this.end);
}
