package com.sample.myapplication

import android.content.Context
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.appinsights.PanelSDK

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        initInsights(applicationContext)
    }

    private fun initInsights(context: Context) {
        val partnerId = "PUT_YOUR_PARTNER_ID"
        val partnerKey = "PUT_YOUR_KEY"
        val deviceId = "unique-1234-1234-123456-1234"
        val userId = "email@example.com"

        PanelSDK.init(
            partnerId = partnerId,
            partnerKey = partnerKey,
            userId = userId,
            deviceId = deviceId,
            context = context,
            debug = false
        )

        println("PanelSDK state: ${PanelSDK.getState()}")
    }
}