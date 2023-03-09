import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognitionApi{
  static Future<String?> recogonizeText(InputImage inputImage) async{
    try{
      final textRecognize = TextRecognizer();
      final recognizedText = await textRecognize.processImage(inputImage);
      return recognizedText.text.toString();
    }catch(e){
      return null;
    }
  }
}