
class ScaleHelper {
  final double figmaWidth;
  final double screenWidth;

  ScaleHelper({required this.figmaWidth, required this.screenWidth});

  double scaleFactor() {
    return screenWidth / figmaWidth;
  }

  double scaleWidth(double inputWidth) {
    return (inputWidth / figmaWidth) * screenWidth;
  }

  double scaleHeight(double inputHeight) {
    return (inputHeight / figmaWidth) * screenWidth;
  }

  double scaleText(double inputTextSize) {
    return scaleFactor() * inputTextSize;
  }
}
