// animations.js - Animations élégantes pour le gestionnaire de tâches

document.addEventListener('DOMContentLoaded', function() {
    // Initialiser les animations sur le tableau de bord
    initDashboardAnimations();
    
    // Initialiser les animations de notification
    initNotificationAnimations();
    
    // Initialiser les animations pour les actions de tâches
    initTaskActionAnimations();
    
    // Initialiser les animations des éléments d'interface
    initUIAnimations();
});

// Animations du tableau de bord 
function initDashboardAnimations() {
    // Animation d'entrée séquentielle des cartes du tableau de bord
    const dashboardCards = document.querySelectorAll('.card');
    if (dashboardCards.length === 0) return;
    
    dashboardCards.forEach((card, index) => {
        // Masquer toutes les cartes initialement
        card.style.opacity = '0';
        card.style.transform = 'translateY(40px)';
        card.style.transition = 'opacity 0.8s cubic-bezier(0.19, 1, 0.22, 1), transform 0.8s cubic-bezier(0.19, 1, 0.22, 1)';
        
        // Afficher les cartes avec effet séquentiel
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, 100 + (index * 120));
        
        // Ajouter des animations d'interaction
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-10px) scale(1.02)';
            this.style.boxShadow = '0 15px 30px rgba(0, 0, 0, 0.1)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
            this.style.boxShadow = '0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -2px rgba(0,0,0,0.05)';
        });
    });
}

// Animations pour les notifications
function initNotificationAnimations() {
    const notificationBadges = document.querySelectorAll('.badge.bg-danger');
    
    notificationBadges.forEach(badge => {
        badge.classList.add('notification-badge');
        
        // Effet de highlight lors de la réception d'une nouvelle notification
        // (simulation pour démo)
        if (Math.random() > 0.7) {
            setTimeout(() => {
                highlightNotification(badge);
            }, 3000);
        }
    });
}

function highlightNotification(badge) {
    // Cloner le badge pour créer une animation de pulse
    const highlight = document.createElement('span');
    highlight.className = 'notification-highlight';
    highlight.style.position = 'absolute';
    highlight.style.width = '100%';
    highlight.style.height = '100%';
    highlight.style.backgroundColor = 'var(--primary)';
    highlight.style.borderRadius = '50%';
    highlight.style.zIndex = '-1';
    highlight.style.opacity = '0.8';
    highlight.style.transform = 'scale(1)';
    highlight.style.transition = 'transform 1s cubic-bezier(0.19, 1, 0.22, 1), opacity 1s cubic-bezier(0.19, 1, 0.22, 1)';
    
    // Positionner correctement
    badge.style.position = 'relative';
    badge.appendChild(highlight);
    
    // Animation
    requestAnimationFrame(() => {
        highlight.style.transform = 'scale(3)';
        highlight.style.opacity = '0';
        
        // Nettoyer après l'animation
        setTimeout(() => {
            highlight.remove();
        }, 1000);
    });
}

// Animations pour les actions sur les tâches
function initTaskActionAnimations() {
    // Animer le statut des tâches
    const completeButtons = document.querySelectorAll('button[data-status="completed"], input[value="completed"]');
    
    completeButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Effet élégant pour la complétion des tâches
            const buttonRect = this.getBoundingClientRect();
            const centerX = buttonRect.left + buttonRect.width / 2;
            const centerY = buttonRect.top + buttonRect.height / 2;
            
            // Créer l'effet d'onde
            createRippleEffect(centerX, centerY);
            
            // Créer l'icône de succès avec animation
            createSuccessIcon(centerX, centerY);
            
            // Effet de confetti plus élégant
            createMinimalistConfetti();
        });
    });
}

function createRippleEffect(x, y) {
    const ripple = document.createElement('div');
    ripple.className = 'success-ripple';
    ripple.style.position = 'fixed';
    ripple.style.left = `${x}px`;
    ripple.style.top = `${y}px`;
    ripple.style.width = '10px';
    ripple.style.height = '10px';
    ripple.style.backgroundColor = 'var(--success)';
    ripple.style.borderRadius = '50%';
    ripple.style.transform = 'translate(-50%, -50%) scale(0)';
    ripple.style.opacity = '0.6';
    ripple.style.zIndex = '9998';
    ripple.style.transition = 'transform 1s cubic-bezier(0.19, 1, 0.22, 1), opacity 1s cubic-bezier(0.19, 1, 0.22, 1)';
    
    document.body.appendChild(ripple);
    
    // Animer l'onde
    requestAnimationFrame(() => {
        ripple.style.transform = 'translate(-50%, -50%) scale(100)';
        ripple.style.opacity = '0';
        
        // Supprimer après l'animation
        setTimeout(() => {
            ripple.remove();
        }, 1000);
    });
}

function createSuccessIcon(x, y) {
    const icon = document.createElement('i');
    icon.className = 'bi bi-check-circle-fill task-completed-icon';
    icon.style.position = 'fixed';
    icon.style.left = `${x}px`;
    icon.style.top = `${y}px`;
    icon.style.color = 'white';
    icon.style.fontSize = '3rem';
    icon.style.transform = 'translate(-50%, -50%) scale(0)';
    icon.style.opacity = '0';
    icon.style.zIndex = '9999';
    icon.style.transition = 'transform 0.5s cubic-bezier(0.19, 1, 0.22, 1) 0.3s, opacity 0.5s cubic-bezier(0.19, 1, 0.22, 1) 0.3s';
    
    document.body.appendChild(icon);
    
    // Animer l'icône
    requestAnimationFrame(() => {
        icon.style.transform = 'translate(-50%, -50%) scale(1)';
        icon.style.opacity = '1';
        
        // Supprimer après l'animation
        setTimeout(() => {
            icon.style.transform = 'translate(-50%, -50%) scale(1.5)';
            icon.style.opacity = '0';
            setTimeout(() => {
                icon.remove();
            }, 500);
        }, 1000);
    });
}

function createMinimalistConfetti() {
    const confettiContainer = document.createElement('div');
    confettiContainer.className = 'confetti-container';
    confettiContainer.style.position = 'fixed';
    confettiContainer.style.top = '0';
    confettiContainer.style.left = '0';
    confettiContainer.style.width = '100%';
    confettiContainer.style.height = '100%';
    confettiContainer.style.pointerEvents = 'none';
    confettiContainer.style.zIndex = '9997';
    
    document.body.appendChild(confettiContainer);
    
    // Créer des confettis minimalistes
    const colors = ['var(--primary)', 'var(--success)', 'var(--warning)', 'white'];
    const shapes = ['circle', 'square', 'triangle'];
    
    for (let i = 0; i < 30; i++) {
        const confetti = document.createElement('div');
        const color = colors[Math.floor(Math.random() * colors.length)];
        const shape = shapes[Math.floor(Math.random() * shapes.length)];
        const size = Math.random() * 10 + 5;
        
        confetti.style.position = 'absolute';
        confetti.style.width = `${size}px`;
        confetti.style.height = `${size}px`;
        
        // Position aléatoire centrée autour du milieu de l'écran
        const centerX = window.innerWidth / 2;
        const centerY = window.innerHeight / 2;
        const spread = 200;
        confetti.style.left = `${centerX + (Math.random() - 0.5) * spread}px`;
        confetti.style.top = `${centerY + (Math.random() - 0.5) * spread}px`;
        
        // Style en fonction de la forme
        if (shape === 'circle') {
            confetti.style.borderRadius = '50%';
        } else if (shape === 'triangle') {
            confetti.style.width = '0';
            confetti.style.height = '0';
            confetti.style.borderLeft = `${size/2}px solid transparent`;
            confetti.style.borderRight = `${size/2}px solid transparent`;
            confetti.style.borderBottom = `${size}px solid ${color}`;
            confetti.style.backgroundColor = 'transparent';
        }
        
        confetti.style.backgroundColor = shape === 'triangle' ? 'transparent' : color;
        confetti.style.opacity = '0';
        confetti.style.transform = 'scale(0) rotate(0deg)';
        
        // Animation unique pour chaque confetti
        const duration = Math.random() * 1 + 1.5;
        const delay = Math.random() * 0.5;
        const rotationDir = Math.random() > 0.5 ? 1 : -1;
        
        confetti.style.transition = `
            opacity ${duration}s cubic-bezier(0.19, 1, 0.22, 1) ${delay}s,
            transform ${duration}s cubic-bezier(0.19, 1, 0.22, 1) ${delay}s
        `;
        
        confettiContainer.appendChild(confetti);
        
        // Animer les confettis
        requestAnimationFrame(() => {
            confetti.style.opacity = '0.9';
            const moveX = (Math.random() - 0.5) * 200;
            const moveY = (Math.random() - 0.5) * 200;
            const rotate = Math.random() * 360 * rotationDir;
            confetti.style.transform = `translate(${moveX}px, ${moveY}px) rotate(${rotate}deg) scale(1)`;
            
            // Faire disparaître
            setTimeout(() => {
                confetti.style.opacity = '0';
                confetti.style.transform = `translate(${moveX*1.5}px, ${moveY*1.5}px) rotate(${rotate*1.5}deg) scale(0.5)`;
            }, (duration + delay) * 800);
        });
    }
    
    // Supprimer le conteneur après les animations
    setTimeout(() => {
        confettiContainer.remove();
    }, 3500);
}

// Animations pour les éléments d'interface
function initUIAnimations() {
    // Animation pour l'horloge
    const dateTimeElement = document.getElementById('currentDateTime');
    if (dateTimeElement) {
        dateTimeElement.style.transition = 'all 0.5s cubic-bezier(0.19, 1, 0.22, 1)';
    }
    
    // Animation pour les transitions de page
    const mainContent = document.querySelector('main');
    if (mainContent) {
        mainContent.style.transition = 'opacity 0.5s cubic-bezier(0.19, 1, 0.22, 1)';
    }
    
    // Animation pour les éléments de liste
    animateListItems();
    
    // Animation pour les barres de progression
    initProgressBars();
}

// Animation pour les items de liste avec séquence
function animateListItems() {
    const listItems = document.querySelectorAll('.list-group-item');
    
    listItems.forEach((item, index) => {
        item.style.opacity = '0';
        item.style.transform = 'translateX(20px)';
        item.style.transition = 'opacity 0.5s cubic-bezier(0.19, 1, 0.22, 1), transform 0.5s cubic-bezier(0.19, 1, 0.22, 1)';
        
        setTimeout(() => {
            item.style.opacity = '1';
            item.style.transform = 'translateX(0)';
        }, 100 + (index * 50));
        
        // Animation au survol
        item.addEventListener('mouseenter', function() {
            this.style.transform = 'translateX(5px)';
            this.style.borderLeftWidth = '3px';
            this.style.borderLeftColor = 'var(--primary)';
        });
        
        item.addEventListener('mouseleave', function() {
            this.style.transform = 'translateX(0)';
            this.style.borderLeftWidth = '3px';
            this.style.borderLeftColor = 'transparent';
        });
    });
}

// Animation des barres de progression
function initProgressBars() {
    const progressBars = document.querySelectorAll('.progress-bar');
    
    progressBars.forEach(bar => {
        const value = parseInt(bar.getAttribute('aria-valuenow'));
        
        // Animation élégante de la progression
        bar.style.width = '0%';
        bar.style.transition = 'width 1.5s cubic-bezier(0.19, 1, 0.22, 1)';
        
        setTimeout(() => {
            bar.style.width = value + '%';
        }, 300);
    });
}

// Fonctions globales pour être utilisées par les handlers d'événements
window.showSuccessMessage = function(message) {
    const toast = document.createElement('div');
    toast.className = 'success-toast';
    toast.style.position = 'fixed';
    toast.style.top = '30px';
    toast.style.right = '30px';
    toast.style.backgroundColor = 'var(--success)';
    toast.style.color = 'white';
    toast.style.padding = '15px 25px';
    toast.style.borderRadius = '8px';
    toast.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.1)';
    toast.style.zIndex = '9999';
    toast.style.transform = 'translateY(-20px)';
    toast.style.opacity = '0';
    toast.style.transition = 'transform 0.5s cubic-bezier(0.19, 1, 0.22, 1), opacity 0.5s cubic-bezier(0.19, 1, 0.22, 1)';
    
    toast.innerHTML = `
        <div style="display: flex; align-items: center;">
            <i class="bi bi-check-circle-fill" style="margin-right: 10px; font-size: 1.2rem;"></i>
            <span>${message}</span>
        </div>
    `;
    
    document.body.appendChild(toast);
    
    // Animation d'entrée
    requestAnimationFrame(() => {
        toast.style.transform = 'translateY(0)';
        toast.style.opacity = '1';
        
        // Disparition automatique
        setTimeout(() => {
            toast.style.transform = 'translateY(-20px)';
            toast.style.opacity = '0';
            setTimeout(() => {
                toast.remove();
            }, 500);
        }, 3000);
    });
};

window.showConfetti = createMinimalistConfetti; 