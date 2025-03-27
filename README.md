# AppInsight SDK
*By Apptopia*

## Overview

The Appinsight SDK monitors how users interact with mobile applications by tracking time spent across all installed apps on their device. This data provides valuable insights into user engagement patterns and app usage behavior.

### Core functionality:
- Collects anonymous usage statistics with privacy protection
- Performs efficient background data collection every 2 hours
- Securely stores data locally and transmits when connected

With the PACKAGE_USAGE_STATS permission, the Appinsight SDK collects and transmits device-level usage statistics. It focuses solely on high-level metrics like time spent, never accessing in-app content or personal data. The SDK employs WorkManager for optimized background collection, ensuring consistent data gathering while conserving system resources. For data integrity and efficiency, the SDK securely stores usage statistics locally and only transmits them to backend servers when a stable internet connection is available.

## System Requirements

- Android 7 or higher (minSdk=24)
- Required Permissions:
  - PACKAGE_USAGE_STATS
  - INTERNET
  - ACCESS_NETWORK_STATE

## Installation

Add the following dependencies to your project:
```gradle
implementation 'android.work:work-runtime-ktx:2.7.1'
implementation 'androidx.core:core-ktx:1.10.1'
```

Include the SDK:

Add the appinsights-release.aar file to your project's app/libs/ directory and include:
```gradle
implementation files('libs/appinsights-release.aar')
```

## Implementation Guide

Initialize the SDK at application launch:
```kotlin
import com.appinsights.PanelSDK

PanelSDK.init(
    partnerId,    // Provided by our business unit
    partnerKey,   // Provided by our business unit
    userId,       // Your system's unique user identifier
    deviceId,     // Your system's unique device identifier (preferably GAID)
    applicationContext,
    debugMode     // Controls log verbosity only
)
```

### Best Practices for Initialization
- Initialize Early: Call PanelSDK.init() in Application.onCreate()
- Handle Permissions: Request PACKAGE_USAGE_STATS permission before initialization
- Verify Installation: Check return state using PanelSDK.getState()
- Device ID Management: Use GAID (Google Advertising ID) when possible
- Error Recovery: Validate arguments before calling init

## Configuration
Only debug mode configuration available, controlling log verbosity.

## SDK Monitoring
Monitor SDK state using:
```kotlin
data class PanelSDKState(
    val initCompleted: Boolean,     // SDK initialization status
    val jobScheduled: Boolean,      // Background job scheduling status
    val permissionAcquired: Boolean // Required permissions status
)
```

## Backend API Integration testing <todo>
Monitor device statistics through our REST API:
```
#Proposed / Todo 
GET <https://api.example.com/getStats?partnerId=123&deviceId=543>

Response:
{
    "lastDataDelivered": "timestamp",
    "lastHeartbeat": "timestamp"
}

```


## Legal & License Information
- Usage License: Proprietary software, requires valid partner credentials
- Data Collection: Must comply with applicable data protection laws
- Restrictions: No modification or redistribution without permission

### Privacy Compliance
- Data Retention: According to standard policies, deletable upon request
- User Consent: Required before enabling usage statistics collection
