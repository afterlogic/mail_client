package com.afterlogic.aurora.mail.aurora_mail

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import vn.hunghd.flutterdownloader.FlutterDownloaderPlugin
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import com.afterlogic.alarm_service.WithAlarm

internal class MailApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback, WithAlarm {
    override val clazzService = AppService::class.java

    override fun registerWith(registry: PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(registry)
    }

    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "sample"
            val descriptionText = "chanel for sample"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val mChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID, name, importance)
            mChannel.description = descriptionText
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(mChannel)
        }
    }

    companion object {
        const val NOTIFICATION_CHANNEL_ID = "main"
    }
}