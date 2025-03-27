# **AppInsight SDK** 
*By Apptopia*

## **Overview**

The Appinsight SDK monitors how users interact with mobile applications by tracking time spent across all installed apps on their device. This data provides valuable insights into user engagement patterns and app usage behavior.

**Core functionality:**

* Collects anonymous usage statistics with privacy protection  
* Performs efficient background data collection every 2 hours  
* Securely stores data locally and transmits when connected

With the PACKAGE\_USAGE\_STATS permission, the Appinsight SDK collects and transmits device-level usage statistics. It focuses solely on high-level metrics like time spent, never accessing in-app content or personal data. The SDK employs WorkManager for optimized background collection, ensuring consistent data gathering while conserving system resources. For data integrity and efficiency, the SDK securely stores usage statistics locally and only transmits them to backend servers when a stable internet connection is available.

## **System Requirements**

* Android 7 or higher (minSdk=24)  
* Required Permissions:  
  * PACKAGE\_USAGE\_STATS  
  * INTERNET  
  * ACCESS\_NETWORK\_STATE
  * RECEIVE\_BOOT\_COMPLETED

## **Installation**

**Add the following dependencies to your project:**

```
implementation 'android.work:work-runtime-ktx:2.7.1'
implementation 'androidx.core:core-ktx:1.10.1'

```

**Include the SDK in your project:**

Add the appinsights-release.aar file to your project's app/libs/ directory and include it as a dependency in your Gradle script:

```
implementation files('libs/appinsights-release.aar')

```

## **Implementation**

Initialize the SDK at application launch by calling PanelSDK.init() in your application's onCreate() method:

```
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

### **Best Practices for Initialization**

* Initialize Early: Call PanelSDK.init() as early as possible in your application lifecycle, preferably in Application.onCreate()

* Handle Permissions: Request PACKAGE\_USAGE\_STATS permission before initialization to ensure smooth operation

* Verify Installation: Always check the return state using PanelSDK.getState() after initialization

* Device ID Management: Implement a reliable method to generate and persist the deviceId, preferably using GAID (Google Advertising ID)

* Error Recovery: Implement validation of arguments before calling init  


## **Configuration**

The SDK offers a single configuration option:

* **Debug Mode:** Controls log verbosity without affecting core functionality

## **Error Handling**

The SDK implements internal error handling to prevent exceptions from propagating to the host application. All errors are handled silently within the SDK.

## **SDK Monitoring & Testing**

Monitor the SDK's state using PanelSDK.getState(), which returns a PanelSDKState object with the following properties:

```
data class PanelSDKState(
    val initCompleted: Boolean,     // SDK initialization status
    val jobScheduled: Boolean,      // Background job scheduling status
    val permissionAcquired: Boolean // Required permissions status
)

```

For successful operation, all properties should return true.

## **Backend API Integration Testing\<Todo\>**

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

## **Legal & License Information**

The Appinsight SDK is licensed under the following terms:

* **Usage License:** The SDK is proprietary software, licensed for use only with valid partner credentials provided by Apptopia.  
* **Data Collection:** By implementing this SDK, you agree to comply with all applicable data protection and privacy laws in your jurisdiction.  
* **Restrictions:** Modification, reverse engineering, or redistribution of the SDK is strictly prohibited without explicit written permission.

For detailed license terms or questions about usage rights, please see our “terms of service”

### **Privacy Compliance**

* **Data Retention:** Usage data is retained according to our standard data retention policies and can be deleted upon request.  
* **User Consent:** Implementers must ensure proper user consent is obtained before enabling usage statistics collection.

For additional information about privacy compliance and data handling, please refer to our privacy policy.

