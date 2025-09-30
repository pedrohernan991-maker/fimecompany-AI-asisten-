package com.fimemessenger.app.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.fimemessenger.app.R
import com.fimemessenger.app.databinding.ItemMessageBinding
import com.fimemessenger.app.models.Message
import java.text.SimpleDateFormat
import java.util.*

class MessageAdapter(private val currentUserId: String) : RecyclerView.Adapter<MessageAdapter.MessageViewHolder>() {
    
    private val messages = mutableListOf<Message>()
    private val dateFormat = SimpleDateFormat("HH:mm", Locale.getDefault())
    
    fun setMessages(newMessages: List<Message>) {
        messages.clear()
        messages.addAll(newMessages)
        notifyDataSetChanged()
    }
    
    fun addMessage(message: Message) {
        messages.add(message)
        notifyItemInserted(messages.size - 1)
    }
    
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MessageViewHolder {
        val binding = ItemMessageBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return MessageViewHolder(binding)
    }
    
    override fun onBindViewHolder(holder: MessageViewHolder, position: Int) {
        holder.bind(messages[position])
    }
    
    override fun getItemCount(): Int = messages.size
    
    inner class MessageViewHolder(private val binding: ItemMessageBinding) : RecyclerView.ViewHolder(binding.root) {
        
        fun bind(message: Message) {
            val isCurrentUser = message.senderId == currentUserId
            
            binding.apply {
                textMessage.text = message.content
                textTime.text = dateFormat.format(Date(message.timestamp))
                
                if (isCurrentUser) {
                    // Mensaje del usuario actual
                    layoutMessage.setBackgroundResource(R.drawable.message_sent_background)
                    layoutMessage.gravity = android.view.Gravity.END
                    textMessage.setTextColor(binding.root.context.getColor(R.color.white))
                } else {
                    // Mensaje del otro usuario
                    layoutMessage.setBackgroundResource(R.drawable.message_received_background)
                    layoutMessage.gravity = android.view.Gravity.START
                    textMessage.setTextColor(binding.root.context.getColor(R.color.black))
                }
                
                // Mostrar estado de entrega
                when {
                    message.isRead -> {
                        textStatus.text = "âœ“âœ“"
                        textStatus.setTextColor(binding.root.context.getColor(R.color.blue))
                    }
                    message.isDelivered -> {
                        textStatus.text = "âœ“âœ“"
                        textStatus.setTextColor(binding.root.context.getColor(R.color.gray))
                    }
                    else -> {
                        textStatus.text = "âœ“"
                        textStatus.setTextColor(binding.root.context.getColor(R.color.gray))
                    }
                }
                
                textStatus.visibility = if (isCurrentUser) View.VISIBLE else View.GONE
            }
        }
    }
}
