package com.fimemessenger.app.activities

import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.fimemessenger.app.R
import com.fimemessenger.app.adapters.MessageAdapter
import com.fimemessenger.app.databinding.ActivityChatBinding
import com.fimemessenger.app.models.Message
import com.fimemessenger.app.models.User
import java.util.*

class ChatActivity : AppCompatActivity() {
    
    private lateinit var binding: ActivityChatBinding
    private lateinit var messageAdapter: MessageAdapter
    private lateinit var currentUser: User
    private lateinit var chatUser: User
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityChatBinding.inflate(layoutInflater)
        setContentView(binding.root)
        
        setupToolbar()
        setupRecyclerView()
        setupClickListeners()
        
        // Obtener datos del intent
        chatUser = intent.getSerializableExtra("user") as User
        currentUser = getCurrentUser() // Implementar metodo
        
        supportActionBar?.title = chatUser.name
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }
    
    private fun setupToolbar() {
        setSupportActionBar(binding.toolbar)
    }
    
    private fun setupRecyclerView() {
        messageAdapter = MessageAdapter(getCurrentUser().id)
        binding.recyclerViewMessages.apply {
            layoutManager = LinearLayoutManager(this@ChatActivity)
            adapter = messageAdapter
        }
        
        // Cargar mensajes
        loadMessages()
    }
    
    private fun setupClickListeners() {
        binding.btnSend.setOnClickListener {
            sendMessage()
        }
        
        binding.btnAttach.setOnClickListener {
            // Implementar adjuntar archivo
        }
        
        binding.btnCamera.setOnClickListener {
            // Implementar camara
        }
    }
    
    private fun sendMessage() {
        val messageText = binding.editMessage.text.toString().trim()
        if (messageText.isNotEmpty()) {
            val message = Message(
                id = UUID.randomUUID().toString(),
                senderId = currentUser.id,
                receiverId = chatUser.id,
                content = messageText,
                timestamp = System.currentTimeMillis(),
                type = MessageType.TEXT
            )
            
            // Enviar mensaje
            sendMessageToServer(message)
            
            // Agregar a la lista local
            messageAdapter.addMessage(message)
            
            // Limpiar input
            binding.editMessage.text?.clear()
            
            // Scroll al final
            binding.recyclerViewMessages.scrollToPosition(messageAdapter.itemCount - 1)
        }
    }
    
    private fun loadMessages() {
        // Implementar carga de mensajes desde base de datos
        val messages = getMessagesForChat(chatUser.id)
        messageAdapter.setMessages(messages)
    }
    
    private fun sendMessageToServer(message: Message) {
        // Implementar envio al servidor
    }
    
    private fun getCurrentUser(): User {
        // Implementar obtencion del usuario actual
        return User("1", "Usuario Actual", "usuario@fimecompany.com", "", true)
    }
    
    private fun getMessagesForChat(userId: String): List<Message> {
        // Implementar obtencion de mensajes
        return emptyList()
    }
    
    override fun onSupportNavigateUp(): Boolean {
        onBackPressed()
        return true
    }
}
