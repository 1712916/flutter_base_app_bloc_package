import 'package:flutter/material.dart';
import 'package:flutter_base_app_bloc_package/resources/view_size/spacing.dart';

class OverlayView extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool>? onToggle;
  final BorderRadius? borderRadius;
  final Color bgColor;
  final Color? borderColor;
  final double? elevation;
  final WidgetBuilder? builder;
  final EdgeInsetsGeometry padding;
  final ValueNotifier<bool>? isOpen;
  final BoxConstraints? constraints;

  const OverlayView({
    Key? key,
    required this.child,
    this.onToggle,
    this.borderRadius,
    this.bgColor = const Color(0xFFFFFFFF),
    this.borderColor,
    this.elevation,
    this.builder,
    this.isOpen,
    this.constraints,
    this.padding = const EdgeInsets.all(Spacing.sm),
  }) : super(key: key);

  @override
  State<OverlayView> createState() => _OverlayViewState();
}

class _OverlayViewState extends State<OverlayView> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimation;
  late final LayerLink _layerLink;
  OverlayEntry? _overlayEntry;
  late final ValueNotifier<bool> isOpen;

  @override
  void initState() {
    _layerLink = LayerLink();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    isOpen = widget.isOpen ?? ValueNotifier(false);
    isOpen.addListener(() {
      if (isOpen.value) {
        _overlayEntry = _createOverlayEntry(context);
        Overlay.of(context)?.insert(_overlayEntry!);
        _animationController.forward();
      } else {
        _overlayEntry?.remove();
        _animationController.reverse();
      }
      widget.onToggle?.call(isOpen.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _toggle(),
        child: widget.child,
      ),
    );
  }

  void _toggle() {
    isOpen.value = !isOpen.value;
  }

  @override
  void dispose() {
    _animationController.reverse();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OverlayView oldWidget) {
    if (widget.isOpen != isOpen) {
      print("...");
      //   _toggle();
    }
    super.didUpdateWidget(oldWidget);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox?.size ?? const Size(0, 0);
    final offset = renderBox?.localToGlobal(Offset.zero) ?? const Offset(0, 0);
    final topOffset = offset.dy + size.height + 5;
    final sz = MediaQuery.of(context).size;
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggle(),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: sz.height,
          width: sz.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  offset: Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: ClipRRect(
                    borderRadius: widget.borderRadius ?? BorderRadius.zero,

                    child: Material(
                      color: widget.bgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: widget.borderRadius ?? BorderRadius.zero,
                        side: BorderSide(color: widget.borderColor ?? widget.bgColor, width: 1),
                      ),
                      elevation: widget.elevation ?? 0,
                      child: SizeTransition(
                        axisAlignment: 1,
                        sizeFactor: _expandAnimation,
                        child: Container(
                          padding: widget.padding,
                          constraints: widget.constraints ??
                              BoxConstraints(
                                minHeight: ViewSize.size_40,
                                maxHeight: sz.height - topOffset - 15,
                              ),
                          child: SingleChildScrollView(
                            child: widget.builder?.call(context) ?? const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
