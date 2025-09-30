package com.amigo.messenger.models

data class Chat(
    val id: String,
    val name: String,
    val lastMessage: String,
    val timestamp: Long,
    val unreadCount: Int = 0,
    val isOnline: Boolean = false,
    val profileImage: String? = null
)
