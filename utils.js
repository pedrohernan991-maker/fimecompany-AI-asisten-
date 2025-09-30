// Funciones adicionales para FimeTech
class FimeTechUtils {
    // FunciÃ³n para mostrar notificaciones
    static showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = 
otification notification-;
        notification.textContent = message;
        notification.style.cssText = 
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1rem 2rem;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            z-index: 10000;
            animation: slideIn 0.3s ease;
        ;
        
        // Colores segÃºn tipo
        const colors = {
            info: '#00e5e5',
            success: '#10b981',
            warning: '#f59e0b',
            error: '#ef4444'
        };
        
        notification.style.background = colors[type] || colors.info;
        document.body.appendChild(notification);
        
        // Remover despuÃ©s de 3 segundos
        setTimeout(() => {
            notification.style.animation = 'slideOut 0.3s ease';
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }
    
    // FunciÃ³n para formatear precios
    static formatPrice(price, currency = 'USD') {
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currency
        }).format(price);
    }
    
    // FunciÃ³n para validar email
    static validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }
    
    // FunciÃ³n para generar ID Ãºnico
    static generateId() {
        return Date.now().toString(36) + Math.random().toString(36).substr(2);
    }
    
    // FunciÃ³n para debounce
    static debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
}

// Exportar para uso global
window.FimeTechUtils = FimeTechUtils;
