# Keep JSON model classes
-keep class com.example.movie_app.** { *; }

# Keep Retrofit / HTTP client reflection
-keepattributes Signature
-keepattributes *Annotation*
-keep class retrofit2.** { *; }
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
-keep class com.google.gson.** { *; }
