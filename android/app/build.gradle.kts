plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.shopping_app_su"

    // Load Flutter SDK version details from local.properties
    val localProperties = java.util.Properties()
    val localPropertiesFile = rootProject.file("../local.properties")

    if (localPropertiesFile.exists()) {
        localPropertiesFile.inputStream().use { localProperties.load(it) }
    }

    val compileSdkVersion = localProperties.getProperty("flutter.compileSdkVersion")?.toIntOrNull() ?: 34
    val ndkVersion = localProperties.getProperty("flutter.ndkVersion") ?: "27.0.12077973"
    val minSdkVersion = localProperties.getProperty("flutter.minSdkVersion")?.toIntOrNull() ?: 21
    val targetSdkVersion = localProperties.getProperty("flutter.targetSdkVersion")?.toIntOrNull() ?: 34
    val versionCode = localProperties.getProperty("flutter.versionCode")?.toIntOrNull() ?: 1
    val versionName = localProperties.getProperty("flutter.versionName") ?: "1.0.0"

    compileSdk = compileSdkVersion
    ndkVersion = ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.shopping_app_su"
        minSdk = minSdkVersion
        targetSdk = targetSdkVersion
        versionCode = versionCode
        versionName = versionName
    }

    buildTypes {
        release {
            // Use debug keys only if no custom signing is configured
            signingConfig = signingConfigs.findByName("release") ?: signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
