
import 'package:firebase_auth/firebase_auth.dart';

Future<String> googleSignIn() async {
try {
await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
return null;
} on FirebaseAuthException catch (ex) {
return "${ex.code}: ${ex.message}";
} on UnimplementedError catch (ex) {
return ex.message;
}
}