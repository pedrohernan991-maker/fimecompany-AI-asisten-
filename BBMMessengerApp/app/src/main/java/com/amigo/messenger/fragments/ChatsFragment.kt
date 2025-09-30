package com.amigo.messenger.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.amigo.messenger.R
import com.amigo.messenger.adapters.ChatAdapter
import com.amigo.messenger.databinding.FragmentChatsBinding
import com.amigo.messenger.models.Chat

class ChatsFragment : Fragment() {
    
    private var _binding: FragmentChatsBinding? = null
    private val binding get() = _binding!!
    private lateinit var chatAdapter: ChatAdapter
    
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentChatsBinding.inflate(inflater, container, false)
        return binding.root
    }
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        setupRecyclerView()
        loadChats()
    }
    
    private fun setupRecyclerView() {
        chatAdapter = ChatAdapter()
        binding.recyclerViewChats.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = chatAdapter
        }
    }
    
    private fun loadChats() {
        // Datos de ejemplo
        val chats = listOf(
            Chat(
                id = "1",
                name = "Juan Pérez",
                lastMessage = "Hola, ¿cómo estás?",
                timestamp = System.currentTimeMillis() - 3600000,
                unreadCount = 2,
                isOnline = true
            ),
            Chat(
                id = "2",
                name = "María García",
                lastMessage = "Nos vemos mañana",
                timestamp = System.currentTimeMillis() - 7200000,
                unreadCount = 0,
                isOnline = false
            ),
            Chat(
                id = "3",
                name = "Carlos López",
                lastMessage = "Gracias por la información",
                timestamp = System.currentTimeMillis() - 86400000,
                unreadCount = 1,
                isOnline = true
            )
        )
        
        chatAdapter.setChats(chats)
    }
    
    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
