package com.amigo.messenger.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.amigo.messenger.R
import com.amigo.messenger.databinding.ItemChatBinding
import com.amigo.messenger.models.Chat
import java.text.SimpleDateFormat
import java.util.*

class ChatAdapter : RecyclerView.Adapter<ChatAdapter.ChatViewHolder>() {
    
    private val chats = mutableListOf<Chat>()
    private val dateFormat = SimpleDateFormat("HH:mm", Locale.getDefault())
    
    fun setChats(newChats: List<Chat>) {
        chats.clear()
        chats.addAll(newChats)
        notifyDataSetChanged()
    }
    
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ChatViewHolder {
        val binding = ItemChatBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ChatViewHolder(binding)
    }
    
    override fun onBindViewHolder(holder: ChatViewHolder, position: Int) {
        holder.bind(chats[position])
    }
    
    override fun getItemCount(): Int = chats.size
    
    inner class ChatViewHolder(private val binding: ItemChatBinding) : RecyclerView.ViewHolder(binding.root) {
        
        fun bind(chat: Chat) {
            binding.apply {
                textName.text = chat.name
                textLastMessage.text = chat.lastMessage
                textTime.text = dateFormat.format(Date(chat.timestamp))
                
                // Mostrar contador de mensajes no leídos
                if (chat.unreadCount > 0) {
                    textUnreadCount.text = chat.unreadCount.toString()
                    textUnreadCount.visibility = View.VISIBLE
                } else {
                    textUnreadCount.visibility = View.GONE
                }
                
                // Mostrar estado online
                if (chat.isOnline) {
                    indicatorOnline.visibility = View.VISIBLE
                } else {
                    indicatorOnline.visibility = View.GONE
                }
            }
        }
    }
}
