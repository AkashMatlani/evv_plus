package com.app.EVVPLUS

import android.annotation.SuppressLint
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.graphics.BitmapFactory
import android.media.RingtoneManager
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.app.EVVPLUS/configuration"
    var methodChannel : MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel!!.setMethodCallHandler { call, result ->
            if (call.method.equals("notification")) {
                val contentTitle: String = call.argument("title")!!
                val contentBody: String = call.argument("detail")!!
                setNotificationSetting(contentTitle, contentBody)
                if (true) {
                    result.success("success")
                } else {
                    result.error("error", "failure", null)
                }
            }
        }
    }

    private val NOTIFICATION_CHANNEL_NAME = "EVVPLUS"
    private val NOTIFICATION_CHANNEL_ID = "com.app.EVVPLUS"
    fun setNotificationSetting(contentTitle: String, contentBody: String) {
        val pendingIntent = PendingIntent.getActivity(this, 0,
                Intent(this, MainActivity::class.java).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK), PendingIntent.FLAG_ONE_SHOT)
        val largeIcon = BitmapFactory.decodeResource(resources, R.drawable.ic_default_notification)

        val defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
        val notificationBuilder = NotificationCompat.Builder(this)
                .setContentTitle(contentTitle)
                .setContentText(contentBody)
                .setAutoCancel(true)
                .setSound(defaultSoundUri)
                .setContentIntent(pendingIntent)

        notificationBuilder.setSmallIcon(R.drawable.ic_default_notification)
        notificationBuilder.setLargeIcon(largeIcon)
        notificationBuilder.color = ContextCompat.getColor(context, R.color.colorAccent)

        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_HIGH
            val notificationChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID, NOTIFICATION_CHANNEL_NAME, importance)
            notificationChannel.enableLights(true)
            notificationChannel.enableVibration(true)
            notificationChannel.vibrationPattern = longArrayOf(100, 100, 100)
            notificationBuilder.setChannelId(NOTIFICATION_CHANNEL_ID)
            notificationBuilder.setAutoCancel(true)
            notificationManager.createNotificationChannel(notificationChannel)
        }
        notificationManager.notify(System.currentTimeMillis().toInt(), notificationBuilder.build())
    }
}
