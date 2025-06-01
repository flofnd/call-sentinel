plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.callsentinel_clean"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.callsentinel_clean"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("org.jetbrains.kotlin:kotlin-bom:1.8.0")) // Example, align with your Kotlin plugin version
    implementation("androidx.core:core-ktx:1.9.0") // Common core Kotlin extensions
    implementation("androidx.appcompat:appcompat:1.6.1") // For AppCompat activities and themes
    implementation("com.google.android.material:material:1.10.0") // For Material Design components

    // Add the Telecom dependency for CallScreeningService
    implementation("androidx.core:core-telecom:1.0.0") // Or the latest stable version

    // You might also have dependencies related to Flutter if this is a Flutter project's
    // android module, though those are often handled by the Flutter plugin.
    // For example, if you were using platform channels, you might not see explicit
    // Flutter dependencies here as they are managed by the `flutter` block and plugin.

    // Test dependencies
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}
