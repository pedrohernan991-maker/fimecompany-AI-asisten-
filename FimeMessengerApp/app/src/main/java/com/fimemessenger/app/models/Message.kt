package com.fimemessenger.app.models

import java.util.*

data class Message(
    val id: String,
    val senderId: String,
    val receiverId: String,
    val content: String,
    val timestamp: Long,
    val type: MessageType,
    val isRead: Boolean = false,
    val isDelivered: Boolean = false
)

enum class MessageType {
    TEXT,
    IMAGE,
    AUDIO,
    VIDEO,
    FILE,
    LOCATION
}

data class User(
    val id: String,
    val name: String,
    val email: String,
    val profileImage: String,
    val isOnline: Boolean = false,
    val lastSeen: Long = 0
)

data class Chat(
    val id: String,
    val participants: List<String>,
    val lastMessage: Message?,
    val unreadCount: Int = 0,
    val isGroup: Boolean = false,
    val groupName: String? = null,
    val groupImage: String? = null
)
