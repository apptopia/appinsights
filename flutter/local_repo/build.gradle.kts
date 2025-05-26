plugins {
    `maven-publish`
}

publishing {
    publications {
        create<MavenPublication>("aar") {
            groupId = "com.example"                     // You define this
            artifactId = "appinsights"                  // You define this
            version = "1.0.0"                           // Version for your plugin

            artifact(file("appinsights-release.aar")) {
                extension = "aar"
            }
        }
    }

    repositories {
        maven {
            url = uri("${rootProject.projectDir}/repo") // Local folder for output
        }
    }
}


