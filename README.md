# **AppInsight SDK** 
*By Apptopia*

## **Overview**

The Appinsight SDK monitors how users interact with mobile applications by tracking time spent across all installed apps on their device. This data provides valuable insights into user engagement patterns and app usage behavior.

**Core functionality:**

* Collects de-identified usage statistics 
* Performs efficient background data collection every 2 hours  
* Securely stores data locally and transmits when connected

With the PACKAGE_USAGE_STATS permission, the Appinsight SDK collects and transmits device-level usage statistics. It focuses solely on high-level metrics like time spent and des not collects in-app content. The SDK is designed to not collect personal information.  The SDK employs WorkManager for optimized background collection, ensuring consistent data gathering while conserving system resources. For data integrity and efficiency, the SDK securely stores usage data locally and only transmits them to backend servers when a stable internet connection is available.

## **System Requirements**

* Android 7 or higher (minSdk=24)  
* Required Permissions:  
  * PACKAGE\_USAGE\_STATS  
  * INTERNET  
  * ACCESS\_NETWORK\_STATE
  * RECEIVE\_BOOT\_COMPLETED

## **Installation**

Add our Maven repo to the list of repositories in the Gradle script:

```Groovy
repositories {
   google()
   mavenCentral()
   maven {
         url = uri("https://repo.apptopia.com/maven")
   }
}
```


**Add the following dependencies to your project:**

```
implementation 'com.appinsights:appinsights:1.0.0' // primary SDK
 
// dependencies
implementation 'android.work:work-runtime-ktx:2.7.1' 
implementation 'androidx.core:core-ktx:1.10.1'
implementation 'com.google.android.gms:play-services-ads-identifier:18.2.0'
```



## **Implementation**

Initialize the SDK at application launch by calling PanelSDK.init() in your application's onCreate() method:

```
import com.appinsights.PanelSDK

PanelSDK.init(
    applicationContext,
    partnerId,    // Provided by our business unit
    partnerKey,   // Provided by our business unit
)

```

### UserId
Often, the unique user ID isn't available early in the app's lifecycle, so you can share it with the SDK when you're ready. Simply call `PanelSDK.setUserId(id)`


### **Best Practices for Initialization**

* Initialize Early: Call PanelSDK.init() as early as possible in your application lifecycle, preferably in Application.onCreate()

* Handle Permissions: Request `PACKAGE_USAGE_STATS` permission before initialization to ensure smooth operation

* Verify Installation: Always check the return state using `PanelSDK.getState()` after initialization

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

**Legal & License Information**

The Appinsight SDK is licensed under the following terms:

* **Usage License:** Apptopia grants you a license to access and use the SDK subject to the terms of the SDK License Agreement between you and Apptopia. 

* **Data Collection:** By implementing this SDK, you agree to comply with all applicable data protection and privacy laws in the jurisdictions in which you operate.

* **Restrictions:** You shall not:

  1. Access, use, distribute, or deploy the SDK, or any applications incorporating the SDK, outside the jurisdiction of the United States;

  2. Use the SDK to develop software, products or services that: (A) constitute, promote or are used primarily for activities which are illegal, violate the rights of third parties, are fraudulent or misleading, (B) could harm the name or reputation of Apptopia, (C) are directed to individuals under the age of 18; or (D) could harm, modify or misappropriate software or data on an end user’s computer, including but not limited to spyware, or other malicious programs or code, sends unsolicited email (“spam”), multi-level marketing proposals, hate materials, or contains content which is libelous, defamatory, obscene, pornographic, abusive or otherwise offensive; 

  3. Use the SDK in a manner that infringes third party intellectual property rights;

  4. Modify, create derivative works of, reverse engineer, reverse compile, or disassemble the SDK;

  5. Distribute, sell, lease, rent, lend, sublicense, or transfer any part of the SDK to any third party except as expressly provided herein;

  6. Use the SDK to create or facilitate the creation of any product or service that is competitive with the Services or Apptopia;

  7. Combine the SDK with other technology such that you restrict, impede, circumvent, compromise, impact the functionality of or charge for access to the SDK;

  8. Use the SDK to develop software to upload or otherwise transmit any material containing SDK viruses or other computer code, files, or programs designed to interrupt, destroy, or limit the functionality of any software or hardware

For detailed license terms or questions about usage rights, please see our Terms of Service, Data Usage Policy, or the SDK License Agreement between you and Apptopia. 

**Privacy Compliance**

* **Data Retention:** Usage data is retained according to our standard data retention policies and can be deleted upon request.

**User Consent:** Implementers must ensure proper user consent is obtained before enabling usage statistics collection.For additional information about our privacy practices, please refer to our Privacy Policy.

