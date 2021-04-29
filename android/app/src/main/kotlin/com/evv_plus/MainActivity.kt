package com.app.EVVPLUS

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
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
        val pendingIntent = PendingIntent.getActivity(context, 0,
                Intent(this, MainActivity::class.java).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK), PendingIntent.FLAG_ONE_SHOT)

        val defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
        val notificationBuilder = NotificationCompat.Builder(context, NOTIFICATION_CHANNEL_ID)
                .setChannelId(NOTIFICATION_CHANNEL_ID)
                .setDefaults(Notification.DEFAULT_ALL)
                .setContentTitle(contentTitle)
                .setContentText(contentBody)
                .setAutoCancel(true)
                .setColorized(true)
                .setSound(defaultSoundUri)
                .setContentIntent(pendingIntent)
                .setSmallIcon(R.drawable.ic_default_notification)
                .setColor(ContextCompat.getColor(context, R.color.colorAccent))

        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_HIGH
            val notificationChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID, NOTIFICATION_CHANNEL_NAME, importance)
            notificationChannel.enableLights(true)
            notificationChannel.enableVibration(true)
            notificationChannel.setShowBadge(true)
            notificationChannel.vibrationPattern = longArrayOf(100, 100, 100)
            notificationChannel.lockscreenVisibility = Notification.VISIBILITY_PUBLIC
            notificationManager.createNotificationChannel(notificationChannel)
        }
        notificationManager.notify(1, notificationBuilder.build())
    }
}
