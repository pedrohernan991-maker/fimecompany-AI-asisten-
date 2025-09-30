package com.amigo.messenger.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.amigo.messenger.R
import com.amigo.messenger.databinding.FragmentContactsBinding

class ContactsFragment : Fragment() {
    
    private var _binding: FragmentContactsBinding? = null
    private val binding get() = _binding!!
    
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentContactsBinding.inflate(inflater, container, false)
        return binding.root
    }
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        // Implementar lista de contactos
        binding.textContacts.text = "Lista de Contactos\n\n• Juan Pérez (Online)\n• María García (Offline)\n• Carlos López (Online)\n• Ana Martínez (Offline)"
    }
    
    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
