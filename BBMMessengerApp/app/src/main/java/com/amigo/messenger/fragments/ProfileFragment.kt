package com.amigo.messenger.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.amigo.messenger.R
import com.amigo.messenger.databinding.FragmentProfileBinding

class ProfileFragment : Fragment() {
    
    private var _binding: FragmentProfileBinding? = null
    private val binding get() = _binding!!
    
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentProfileBinding.inflate(inflater, container, false)
        return binding.root
    }
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        // Implementar perfil de usuario
        binding.textProfile.text = "Mi Perfil\n\n👤 Usuario: Amigo User\n📱 Estado: En línea\n🔔 Notificaciones: Activadas\n🌙 Modo: Claro"
    }
    
    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
