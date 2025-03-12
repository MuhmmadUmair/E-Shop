pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localPropertiesFile = file("local.properties")

        require(localPropertiesFile.exists()) { "Error: local.properties file is missing!" }

        localPropertiesFile.inputStream().use { properties.load(it) }
        val sdkPath = properties.getProperty("flutter.sdk")

        require(!sdkPath.isNullOrEmpty()) { "Error: 'flutter.sdk' is not set in local.properties!" }

        println("Using Flutter SDK at: $sdkPath")  // Debugging output
        sdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.3.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
}

include(":app")
