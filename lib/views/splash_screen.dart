import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.6),
            ]
          )
        ),
        child: Stack(
          children: [
            const Positioned.fill(
                child: Opacity(opacity: 0.05,
                  child: GridPattern(
                    color: Colors.white,
                  ),
                )),
            //main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 1200),
                      builder: (context, value, child){
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),

                                ),
                              ]
                            ),
                            child: Icon(Icons.shopping_bag_outlined,
                            size: 48,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      },
                  ),
                  SizedBox(height: 32),

                  //animated text
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, value, child){
                      return Opacity(opacity:  value,
                      child: Transform.translate(offset: Offset(0, 20 * (1-value)),
                      child: child,
                      ),
                      );
                    },
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GridPattern extends StatelessWidget {
  final Color color;
  const GridPattern({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(color: color),
    );
  }
}

class GridPainter extends CustomPainter{
    final Color color;
    GridPainter({required this.color});
    @override
    void paint(Canvas canvas, Size size){
      final paint = Paint()
          ..color = color
          ..strokeWidth = 0.5;
      final spacing = 20.0;
      for(var i=0.0; i<size.width; i+=spacing){
        canvas.drawLine(Offset(i,0), Offset(i,size.height), paint);
      }
      for(var i=0.0; i<size.height; i+=spacing){
        canvas.drawLine(Offset(0,i), Offset(size.height,i), paint);
      }
  }
}
