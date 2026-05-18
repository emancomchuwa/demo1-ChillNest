(function() {
    // 1. Create and inject CSS Styles for Messenger UI
    const styleElement = document.createElement('style');
    styleElement.innerHTML = `
        /* Chill Nest Premium Desktop Messenger Chat CSS */
        .cn-chat-container {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 999999;
            font-family: 'Inter', 'Outfit', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        .cn-chat-trigger {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2c5282 0%, #1a365d 100%);
            box-shadow: 0 8px 30px rgba(44, 82, 130, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: none;
            outline: none;
            position: relative;
        }

        .cn-chat-trigger:hover {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 12px 35px rgba(44, 82, 130, 0.6);
        }

        .cn-chat-trigger .cn-icon-close {
            display: none;
            font-size: 1.3rem;
        }

        .cn-chat-trigger.active .cn-icon-msg {
            display: none;
        }

        .cn-chat-trigger.active .cn-icon-close {
            display: block;
        }

        /* Notification Dot */
        .cn-chat-badge-dot {
            position: absolute;
            top: 2px;
            right: 2px;
            width: 14px;
            height: 14px;
            background-color: #ef4444;
            border-radius: 50%;
            border: 2px solid white;
            animation: cnPulse 2s infinite;
        }

        @keyframes cnPulse {
            0% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.7); }
            70% { box-shadow: 0 0 0 8px rgba(239, 68, 68, 0); }
            100% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
        }

        /* Desktop-Class Messenger Chat Window (3 Panels) */
        .cn-chat-window {
            position: absolute;
            bottom: 75px;
            right: 0;
            width: 950px;
            max-width: calc(100vw - 60px);
            height: 580px;
            max-height: calc(100vh - 120px);
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid rgba(226, 232, 240, 0.8);
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(15, 23, 42, 0.15);
            display: flex;
            overflow: hidden;
            transform: scale(0.8) translateY(50px);
            opacity: 0;
            pointer-events: none;
            transition: all 0.45s cubic-bezier(0.175, 0.885, 0.32, 1.15);
            transform-origin: bottom right;
        }

        .cn-chat-window.open {
            transform: scale(1) translateY(0);
            opacity: 1;
            pointer-events: auto;
        }

        /* 3-Panel Wrapper */
        .cn-messenger-wrapper {
            display: flex;
            width: 100%;
            height: 100%;
        }

        /* 1. Left Sidebar */
        .cn-messenger-sidebar {
            width: 70px;
            background: #0f172a;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            padding: 20px 0;
            color: white;
            flex-shrink: 0;
            border-top-left-radius: 24px;
            border-bottom-left-radius: 24px;
        }

        .cn-sidebar-logo {
            font-size: 1.6rem;
            color: #3b82f6;
            margin-bottom: 25px;
            cursor: pointer;
            text-shadow: 0 0 10px rgba(59, 130, 246, 0.4);
            animation: cnFloat 3s ease-in-out infinite;
        }

        @keyframes cnFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-4px); }
        }

        .cn-sidebar-menu {
            display: flex;
            flex-direction: column;
            gap: 16px;
            align-items: center;
            width: 100%;
            flex-grow: 1;
        }

        .cn-sidebar-item {
            font-size: 1.2rem;
            color: #94a3b8;
            padding: 10px;
            border-radius: 12px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            height: 42px;
            position: relative;
        }

        .cn-sidebar-item:hover {
            color: white;
            background: rgba(255,255,255,0.08);
        }

        .cn-sidebar-item.active {
            color: white;
            background: #2c5282;
            box-shadow: 0 4px 15px rgba(44, 82, 130, 0.4);
        }

        .cn-sidebar-item-tooltip {
            position: absolute;
            left: 80px;
            background: #1e293b;
            color: white;
            font-size: 0.7rem;
            padding: 4px 8px;
            border-radius: 6px;
            opacity: 0;
            pointer-events: none;
            transition: all 0.2s;
            white-space: nowrap;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transform: translateX(-5px);
        }

        .cn-sidebar-item:hover .cn-sidebar-item-tooltip {
            opacity: 1;
            transform: translateX(0);
        }

        /* 2. Middle Panel: Conversation List */
        .cn-messenger-list {
            width: 270px;
            background: white;
            border-right: 1px solid #e2e8f0;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
        }

        .cn-list-header {
            padding: 20px 18px 12px 18px;
        }

        .cn-list-header h3 {
            font-size: 1.25rem;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 12px 0;
            letter-spacing: -0.3px;
        }

        .cn-list-search-wrapper {
            background: #f1f5f9;
            border-radius: 10px;
            padding: 8px 12px;
            display: flex;
            align-items: center;
            gap: 8px;
            border: 1px solid transparent;
            transition: all 0.2s;
        }

        .cn-list-search-wrapper:focus-within {
            border-color: #cbd5e1;
            background: white;
            box-shadow: 0 0 0 3px rgba(44, 82, 130, 0.05);
        }

        .cn-list-search-wrapper i {
            color: #94a3b8;
            font-size: 0.85rem;
        }

        .cn-list-search {
            border: none;
            background: transparent;
            font-size: 0.8rem;
            outline: none;
            width: 100%;
            font-family: inherit;
        }

        .cn-list-tabs {
            display: flex;
            gap: 6px;
            margin-top: 10px;
        }

        .cn-list-tab {
            font-size: 0.72rem;
            padding: 6px 12px;
            border-radius: 20px;
            border: none;
            background: #f1f5f9;
            color: #64748b;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .cn-list-tab.active {
            background: #2c5282;
            color: white;
            box-shadow: 0 2px 8px rgba(44, 82, 130, 0.2);
        }

        /* Conversational Items List */
        .cn-list-items {
            flex-grow: 1;
            overflow-y: auto;
            padding: 8px;
            display: flex;
            flex-direction: column;
            gap: 4px;
            scrollbar-width: none;
        }

        .cn-list-items::-webkit-scrollbar {
            display: none;
        }

        .cn-list-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-radius: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
            border-left: 3px solid transparent;
            position: relative;
        }

        .cn-list-item:hover {
            background: #f8fafc;
        }

        .cn-list-item.active {
            background: #f1f5f9;
            border-left-color: #2c5282;
        }

        .cn-item-avatar-wrapper {
            position: relative;
            width: 44px;
            height: 44px;
            flex-shrink: 0;
        }

        .cn-item-avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .cn-item-status-dot {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 11px;
            height: 11px;
            border-radius: 50%;
            background: #10b981;
            border: 2px solid white;
            box-shadow: 0 0 6px #10b981;
        }

        .cn-item-status-dot.offline {
            background: #cbd5e1;
            box-shadow: none;
        }

        .cn-item-details {
            flex-grow: 1;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .cn-item-name-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3px;
        }

        .cn-item-name {
            font-size: 0.85rem;
            font-weight: 700;
            color: #1e293b;
        }

        .cn-item-time {
            font-size: 0.68rem;
            color: #94a3b8;
        }

        .cn-item-snippet-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cn-item-snippet {
            font-size: 0.74rem;
            color: #64748b;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
        }

        .cn-item-badge {
            background: #ef4444;
            color: white;
            font-size: 0.65rem;
            font-weight: 700;
            border-radius: 10px;
            padding: 1px 6px;
            line-height: 1.3;
        }

        /* 3. Right Panel: Active Chat Thread */
        .cn-messenger-main {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            height: 100%;
            position: relative;
        }

        /* Active Chat Header */
        .cn-chat-header {
            background: linear-gradient(135deg, #2c5282 0%, #1a365d 100%);
            padding: 16px 20px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            z-index: 10;
        }

        .cn-chat-agent {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .cn-chat-avatar-wrapper {
            position: relative;
            width: 44px;
            height: 44px;
        }

        .cn-chat-avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid rgba(255,255,255,0.8);
        }

        .cn-chat-status {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #10B981;
            border: 2px solid #2c5282;
            box-shadow: 0 0 6px #10B981;
        }

        .cn-chat-agent-info h4 {
            font-size: 0.95rem;
            font-weight: 700;
            margin: 0 0 2px 0;
            color: white;
        }

        .cn-chat-agent-info span {
            font-size: 0.72rem;
            opacity: 0.95;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .cn-chat-header-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cn-header-icon-btn {
            background: transparent;
            border: none;
            color: rgba(255,255,255,0.8);
            font-size: 1.1rem;
            cursor: pointer;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .cn-header-icon-btn:hover {
            color: white;
            background: rgba(255,255,255,0.1);
        }

        .cn-chat-close-btn {
            background: transparent;
            border: none;
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 5px;
            border-radius: 50%;
            width: 36px;
            height: 36px;
        }

        .cn-chat-close-btn:hover {
            color: white;
            background: rgba(255,255,255,0.1);
        }

        /* Message Area */
        .cn-chat-body {
            flex-grow: 1;
            padding: 20px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: #f8fafc;
            scrollbar-width: thin;
            scrollbar-color: #cbd5e1 transparent;
        }

        .cn-chat-body::-webkit-scrollbar {
            width: 5px;
        }
        .cn-chat-body::-webkit-scrollbar-thumb {
            background-color: #cbd5e1;
            border-radius: 4px;
        }

        .cn-message {
            display: flex;
            flex-direction: column;
            max-width: 80%;
            animation: cnFadeIn 0.3s ease forwards;
        }

        @keyframes cnFadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .cn-message.bot {
            align-self: flex-start;
        }

        .cn-message.user {
            align-self: flex-end;
        }

        .cn-message-bubble {
            padding: 12px 16px;
            border-radius: 16px;
            font-size: 0.88rem;
            line-height: 1.45;
            word-break: break-word;
        }

        .cn-message.bot .cn-message-bubble {
            background: white;
            color: #334155;
            border-bottom-left-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
            border: 1px solid rgba(0,0,0,0.03);
        }

        .cn-message.user .cn-message-bubble {
            background: #2c5282;
            color: white;
            border-bottom-right-radius: 4px;
            box-shadow: 0 4px 12px rgba(44, 82, 130, 0.2);
        }

        .cn-message-time {
            font-size: 0.68rem;
            color: #94a3b8;
            margin-top: 4px;
            align-self: flex-start;
        }

        .cn-message.user .cn-message-time {
            align-self: flex-end;
        }

        /* Quick Options Section as Grid */
        .cn-chat-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 10px;
            margin-top: 5px;
            animation: cnFadeIn 0.4s ease forwards;
            width: 100%;
        }

        .cn-option-btn {
            background: white;
            border: 1px solid rgba(44, 82, 130, 0.15);
            color: #2c5282;
            padding: 10px 14px;
            border-radius: 30px;
            font-size: 0.82rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.01);
        }

        .cn-option-btn:hover {
            background: #f0f4f8;
            border-color: #2c5282;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(44, 82, 130, 0.08);
        }

        /* Typing indicator animation */
        .cn-typing-indicator {
            display: flex;
            align-items: center;
            gap: 4px;
            padding: 12px 18px;
            background: white;
            border-radius: 16px;
            border-bottom-left-radius: 4px;
            width: fit-content;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
            border: 1px solid rgba(0,0,0,0.03);
            animation: cnFadeIn 0.2s ease forwards;
        }

        .cn-typing-dot {
            width: 6px;
            height: 6px;
            background: #94a3b8;
            border-radius: 50%;
            animation: cnBounce 1.4s infinite ease-in-out both;
        }

        .cn-typing-dot:nth-child(1) { animation-delay: -0.32s; }
        .cn-typing-dot:nth-child(2) { animation-delay: -0.16s; }

        @keyframes cnBounce {
            0%, 80%, 100% { transform: scale(0.2); opacity: 0.5; }
            40% { transform: scale(1); opacity: 1; }
        }

        /* Input Footer */
        .cn-chat-footer {
            padding: 15px;
            background: white;
            border-top: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cn-chat-input-wrapper {
            flex-grow: 1;
            background: #f1f5f9;
            border-radius: 24px;
            padding: 4px 16px;
            display: flex;
            align-items: center;
            border: 1px solid transparent;
            transition: all 0.2s;
        }

        .cn-chat-input-wrapper:focus-within {
            border-color: rgba(44, 82, 130, 0.4);
            background: white;
            box-shadow: 0 0 0 3px rgba(44, 82, 130, 0.1);
        }

        .cn-chat-input {
            width: 100%;
            background: transparent;
            border: none;
            outline: none;
            font-size: 0.88rem;
            color: #334155;
            padding: 8px 0;
            font-family: inherit;
        }

        .cn-chat-input::placeholder {
            color: #94a3b8;
        }

        .cn-chat-send-btn {
            background: #2c5282;
            border: none;
            color: white;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 0.9rem;
            box-shadow: 0 3px 8px rgba(44, 82, 130, 0.25);
            padding: 0;
        }

        .cn-chat-send-btn:hover {
            background: #1a365d;
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(44, 82, 130, 0.4);
        }

        .cn-chat-send-btn:disabled {
            background: #cbd5e1;
            color: #94a3b8;
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }

        /* Responsive Mobile styles */
        @media (max-width: 768px) {
            .cn-chat-window {
                width: calc(100vw - 40px);
                max-width: 100vw;
                height: 80vh;
                max-height: 550px;
                bottom: 70px;
            }
            .cn-messenger-sidebar {
                display: none;
            }
            .cn-messenger-list {
                display: none;
            }
        }
    `;
    document.head.appendChild(styleElement);

    // 2. Define conversations state machine with Dynamic DB fetch, WebSockets, & Fallback
    let conversations = {};
    let currentAgent = 'admin';
    let isChatOpen = false;
    let myUserId = null;
    let myFullName = "Guest";
    let myIsGuest = true;
    let myRoleName = "";
    let socket = null;

    function loadUserContext() {
        return fetch('ChatUserController')
            .then(res => res.json())
            .then(data => {
                myUserId = data.userId;
                myFullName = data.fullName;
                myIsGuest = data.isGuest;
                myRoleName = data.roleName || "";
                console.log(">>> Chat client active: " + myFullName + " (ID = " + myUserId + ", Role = " + myRoleName + ")");
            })
            .catch(err => console.error("Error loading user context:", err));
    }

    function connectWebSocket() {
        if (!myUserId) return;
        
        // Build robust URL using current location
        const loc = window.location;
        let new_uri;
        if (loc.protocol === "https:") {
            new_uri = "wss:";
        } else {
            new_uri = "ws:";
        }
        
        // Find Tomcat Context Path correctly
        let contextPath = "";
        const firstSlash = loc.pathname.indexOf('/', 1);
        if (firstSlash !== -1) {
            contextPath = loc.pathname.substring(0, firstSlash);
        } else {
            contextPath = loc.pathname;
        }
        if (contextPath === "" || contextPath.endsWith(".jsp") || contextPath.endsWith(".html")) {
            contextPath = "";
        }
        
        new_uri += "//" + loc.host + contextPath + "/chat/" + myUserId;
        
        console.log(">>> Connecting WebSocket to: " + new_uri);
        socket = new WebSocket(new_uri);
        
        socket.onopen = function(e) {
            console.log(">>> WebSocket connection active!");
        };
        
        socket.onmessage = function(e) {
            const msg = JSON.parse(e.data);
            console.log(">>> WebSocket message received in homepage widget:", msg);
            
            let senderKey = null;
            const isAgent = myRoleName === 'ROLE_ADMIN' || myRoleName === 'ROLE_PARTNER';

            if (isAgent) {
                // If logged in as an Agent, the incoming messages are from client IDs
                senderKey = 'client_' + msg.senderId;
                
                // If client not in list yet, reload the list dynamically to fetch details
                if (!conversations[senderKey]) {
                    loadChatChannels();
                    
                    // Trigger sound/alert notification
                    const badge = document.getElementById('cnChatBadge');
                    if (badge) badge.style.display = 'block';
                    return;
                }
            } else {
                // Customer matches against agent database IDs
                Object.keys(conversations).forEach(key => {
                    if (conversations[key].dbId === msg.senderId) {
                        senderKey = key;
                    }
                });
            }
            
            if (senderKey && conversations[senderKey]) {
                // Save to that conversation's local message stack
                conversations[senderKey].messages.push({
                    text: msg.text,
                    sender: 'bot' // left side bubble
                });
                
                conversations[senderKey].lastTime = new Date(msg.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                
                if (senderKey === currentAgent) {
                    appendMessageMarkup(msg.text, 'bot');
                } else {
                    conversations[senderKey].unread++;
                    renderAgentList();
                    
                    // Show notification dot on trigger button
                    if (!isChatOpen) {
                        const badge = document.getElementById('cnChatBadge');
                        if (badge) badge.style.display = 'block';
                    }
                }
            }
        };
        
        socket.onclose = function(e) {
            console.log(">>> WebSocket closed. Reconnecting in 3s...");
            setTimeout(connectWebSocket, 3000);
        };
        
        socket.onerror = function(err) {
            console.error(">>> WebSocket observed error:", err);
        };
    }

    function loadFallbackStaticAgents() {
        conversations = {
            admin: {
                dbId: 1,
                name: "Quản trị viên (Admin)",
                role: "System Administrator",
                avatar: "img/chat_consultant_avatar.png",
                avatarFallback: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=150",
                status: "online",
                state: "idle",
                hasWelcomed: false,
                messages: [],
                lastTime: "01:52 PM",
                unread: 0,
                welcomeText: "Hello! Welcome to <strong>Chill Nest Support</strong>. 🏡<br><br>I am the system **Admin**. I am here to help you with accounts, payments, technical issues, or order policies. How can I help you today?",
                options: [
                    { text: '📦 Track Order Status', value: 'track_order' },
                    { text: '💳 Payment & Order Policy', value: 'price' },
                    { text: '📞 Talk to Live Admin', value: 'talk_staff' }
                ]
            },
            partner: {
                dbId: 3,
                name: "Đối tác thiết kế (Partner)",
                role: "Interior Architect",
                avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=150",
                avatarFallback: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=150",
                status: "online",
                state: "idle",
                hasWelcomed: false,
                messages: [],
                lastTime: "12:05 PM",
                unread: 1,
                welcomeText: "Hi there! I am your <strong>Chill Nest Design Partner</strong>. 📐<br><br>Let's collaborate on premium room layouts, custom furniture projects, or bespoke architectural designs!",
                options: [
                    { text: '📐 Custom Furniture Request', value: 'custom_furniture' },
                    { text: '🛋️ Premium Design Advice', value: 'design_advice' },
                    { text: '🤝 Partner Cooperation', value: 'talk_staff' }
                ]
            }
        };
        currentAgent = 'admin';
        if (isChatOpen) {
            renderAgentList();
            switchAgent(currentAgent);
        }
    }

    function loadChatChannels() {
        const isAgent = myRoleName === 'ROLE_ADMIN' || myRoleName === 'ROLE_PARTNER';

        if (isAgent) {
            // DUAL MODE: SUPPORT AGENT VIEW (Load client tickets)
            fetch('ChattingClientsController?agentId=' + myUserId)
                .then(res => {
                    if (!res.ok) throw new Error("HTTP error " + res.status);
                    return res.json();
                })
                .then(data => {
                    conversations = {};
                    if (data && data.length > 0) {
                        data.forEach((u, index) => {
                            const key = 'client_' + u.id;
                            const isGuest = u.fullName.toLowerCase().includes("khách");

                            conversations[key] = {
                                dbId: u.id,
                                name: u.fullName,
                                role: isGuest ? "Guest Session" : "Registered Customer",
                                avatar: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&q=80&w=150",
                                avatarFallback: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&q=80&w=150",
                                status: "online",
                                state: "idle",
                                hasWelcomed: true, // skip consultant welcoming bot flow
                                messages: [],
                                lastTime: "Just now",
                                unread: 0,
                                welcomeText: `Direct support chat opened with client <strong>${u.fullName}</strong>.`,
                                options: []
                            };

                            if (index === 0 && !conversations[currentAgent]) {
                                currentAgent = key;
                            }
                        });

                        if (isChatOpen) {
                            renderAgentList();
                            switchAgent(currentAgent);
                        }
                    } else {
                        // Empty State Fallback
                        listItemsContainer.innerHTML = `
                            <div style="padding: 30px; text-align: center; color: #94a3b8; font-size: 0.8rem;">
                                <i class="fa-solid fa-folder-open" style="font-size: 1.5rem; margin-bottom: 8px; display:block;"></i>
                                <p>No active client conversations.</p>
                            </div>
                        `;
                    }
                })
                .catch(err => {
                    console.error("Error loading client list for Agent:", err);
                });

        } else {
            // DUAL MODE: STANDARD CLIENT VIEW (Load support agents)
            fetch('ChatAgentsController')
                .then(res => {
                    if (!res.ok) throw new Error("HTTP error " + res.status);
                    return res.json();
                })
                .then(data => {
                    if (data && data.length > 0) {
                        conversations = {};
                        
                        data.forEach(u => {
                            const isRoleAdmin = u.roleName === 'ROLE_ADMIN';
                            const key = isRoleAdmin ? 'admin' : 'partner';
                            
                            conversations[key] = {
                                dbId: u.id, // Store database User ID
                                name: isRoleAdmin ? `${u.fullName} (Admin)` : `${u.fullName} (Đối tác)`,
                                role: isRoleAdmin ? "System Administrator" : "Interior Architect",
                                avatar: isRoleAdmin ? "img/chat_consultant_avatar.png" : "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=150",
                                avatarFallback: isRoleAdmin ? "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=150" : "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=150",
                                status: "online",
                                state: "idle",
                                hasWelcomed: false,
                                messages: [],
                                lastTime: isRoleAdmin ? "01:52 PM" : "12:05 PM",
                                unread: isRoleAdmin ? 0 : 0,
                                welcomeText: isRoleAdmin 
                                    ? `Hello! Welcome to <strong>Chill Nest Support</strong>. 🏡<br><br>I am <strong>${u.fullName}</strong>, your system administrator. I am here to help you with accounts, payments, technical issues, or order policies.` 
                                    : `Hi there! I am <strong>${u.fullName}</strong>, your design partner. 📐<br><br>Let's collaborate on premium room layouts, custom furniture projects, or bespoke architectural designs!`,
                                options: isRoleAdmin ? [
                                    { text: '📦 Track Order Status', value: 'track_order' },
                                    { text: '💳 Payment & Order Policy', value: 'price' },
                                    { text: '📞 Talk to Live Admin', value: 'talk_staff' }
                                ] : [
                                    { text: '📐 Custom Furniture Request', value: 'custom_furniture' },
                                    { text: '🛋️ Premium Design Advice', value: 'design_advice' },
                                    { text: '🤝 Partner Cooperation', value: 'talk_staff' }
                                ]
                            };
                        });
                        
                        if (conversations['admin']) {
                            currentAgent = 'admin';
                        } else if (Object.keys(conversations).length > 0) {
                            currentAgent = Object.keys(conversations)[0];
                        }
                        
                        if (isChatOpen) {
                            renderAgentList();
                            switchAgent(currentAgent);
                        }
                    } else {
                        loadFallbackStaticAgents();
                    }
                })
                .catch(err => {
                    console.warn("Failed to load real agents, using fallback:", err);
                    loadFallbackStaticAgents();
                });
        }
    }

    // Initialize user context and WebSocket
    loadUserContext().then(() => {
        connectWebSocket();
        loadChatChannels();
    });

    // 3. Build HTML Structure with 3 Panels
    const container = document.createElement('div');
    container.className = 'cn-chat-container';
    container.id = 'cn-chat-widget';

    container.innerHTML = `
        <div class="cn-chat-window" id="cnChatWindow">
            <div class="cn-messenger-wrapper">
                
                <!-- 1. LEFT PANEL: Sidebar -->
                <div class="cn-messenger-sidebar">
                    <div style="display: flex; flex-direction: column; align-items: center; width: 100%;">
                        <div class="cn-sidebar-logo" title="Chill Nest Messenger">
                            <i class="fa-solid fa-comment-dots"></i>
                        </div>
                        <div class="cn-sidebar-menu">
                            <div class="cn-sidebar-item active" title="Chats">
                                <i class="fa-solid fa-message"></i>
                                <span class="cn-sidebar-item-tooltip">Chats</span>
                            </div>
                            <div class="cn-sidebar-item" title="Contacts">
                                <i class="fa-solid fa-address-book"></i>
                                <span class="cn-sidebar-item-tooltip">Contacts</span>
                            </div>
                            <div class="cn-sidebar-item" title="Calls">
                                <i class="fa-solid fa-phone"></i>
                                <span class="cn-sidebar-item-tooltip">Calls</span>
                            </div>
                            <div class="cn-sidebar-item" title="Profile">
                                <i class="fa-solid fa-circle-user"></i>
                                <span class="cn-sidebar-item-tooltip">Profile</span>
                            </div>
                            <div class="cn-sidebar-item" title="Settings">
                                <i class="fa-solid fa-gear"></i>
                                <span class="cn-sidebar-item-tooltip">Settings</span>
                            </div>
                        </div>
                    </div>
                    <div class="cn-sidebar-item" title="Help">
                        <i class="fa-solid fa-circle-info"></i>
                        <span class="cn-sidebar-item-tooltip">Help</span>
                    </div>
                </div>

                <!-- 2. MIDDLE PANEL: Conversation List -->
                <div class="cn-messenger-list">
                    <div class="cn-list-header">
                        <h3>Conversations</h3>
                        <div class="cn-list-search-wrapper">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="text" class="cn-list-search" placeholder="Search chats...">
                        </div>
                        <div class="cn-list-tabs">
                            <button class="cn-list-tab active">All</button>
                            <button class="cn-list-tab">Unread</button>
                            <button class="cn-list-tab">Groups</button>
                        </div>
                    </div>
                    <div class="cn-list-items" id="cnListItems">
                        <!-- Dynamic list of agents will render here -->
                    </div>
                </div>

                <!-- 3. RIGHT PANEL: Conversation Space -->
                <div class="cn-messenger-main">
                    <div class="cn-chat-header">
                        <div class="cn-chat-agent">
                            <div class="cn-chat-avatar-wrapper">
                                <img src="" alt="" class="cn-chat-avatar" id="cnActiveAvatar" onerror="this.src='https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=150'">
                                <div class="cn-chat-status" id="cnActiveStatus"></div>
                            </div>
                            <div class="cn-chat-agent-info">
                                <h4 id="cnActiveName">Sophia</h4>
                                <span><i class="fa-solid fa-circle" style="font-size: 0.35rem; color: #10B981;"></i> <span id="cnActiveRole">Interior Consultant</span></span>
                            </div>
                        </div>
                        <div class="cn-chat-header-actions">
                            <button class="cn-header-icon-btn" title="Start Voice Call">
                                <i class="fa-solid fa-phone"></i>
                            </button>
                            <button class="cn-header-icon-btn" title="Start Video Call">
                                <i class="fa-solid fa-video"></i>
                            </button>
                            <button class="cn-chat-close-btn" id="cnCloseChatBtn" title="Minimize Chat">
                                <i class="fa-solid fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="cn-chat-body" id="cnChatBody">
                        <!-- Dynamic message bubbles will appear here -->
                    </div>
                    <div class="cn-chat-footer">
                        <div class="cn-chat-input-wrapper">
                            <input type="text" class="cn-chat-input" id="cnChatInput" placeholder="Type your message..." autocomplete="off">
                        </div>
                        <button class="cn-chat-send-btn" id="cnSendBtn" disabled>
                            <i class="fa-solid fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <button class="cn-chat-trigger" id="cnChatTrigger" title="Chat with us">
            <i class="fa-solid fa-comment-dots cn-icon-msg"></i>
            <i class="fa-solid fa-xmark cn-icon-close"></i>
            <div class="cn-chat-badge-dot" id="cnChatBadge"></div>
        </button>
    `;

    document.body.appendChild(container);

    // 4. Variables & Elements
    const chatTrigger = document.getElementById('cnChatTrigger');
    const chatWindow = document.getElementById('cnChatWindow');
    const closeChatBtn = document.getElementById('cnCloseChatBtn');
    const chatBody = document.getElementById('cnChatBody');
    const chatInput = document.getElementById('cnChatInput');
    const sendBtn = document.getElementById('cnSendBtn');
    const chatBadge = document.getElementById('cnChatBadge');
    const listItemsContainer = document.getElementById('cnListItems');

    const activeAvatar = document.getElementById('cnActiveAvatar');
    const activeName = document.getElementById('cnActiveName');
    const activeRole = document.getElementById('cnActiveRole');
    const activeStatus = document.getElementById('cnActiveStatus');

    // 5. Render Agent List in Middle Panel
    function renderAgentList() {
        listItemsContainer.innerHTML = '';
        Object.keys(conversations).forEach(key => {
            const agent = conversations[key];
            const itemDiv = document.createElement('div');
            itemDiv.className = 'cn-list-item' + (key === currentAgent ? ' active' : '');
            itemDiv.onclick = () => switchAgent(key);

            // Get last message snippet
            let snippetText = "Select this chat to consult...";
            if (agent.messages.length > 0) {
                const lastMsg = agent.messages[agent.messages.length - 1];
                snippetText = lastMsg.text.replace(/<[^>]*>/g, ''); // strip HTML tags
            } else {
                snippetText = agent.welcomeText.replace(/<[^>]*>/g, '').substring(0, 30) + '...';
            }

            const unreadBadge = agent.unread > 0 ? `<span class="cn-item-badge">${agent.unread}</span>` : '';

            itemDiv.innerHTML = `
                <div class="cn-item-avatar-wrapper">
                    <img src="${agent.avatar}" alt="${agent.name}" class="cn-item-avatar" onerror="this.src='${agent.avatarFallback}'">
                    <div class="cn-item-status-dot ${agent.status === 'offline' ? 'offline' : ''}"></div>
                </div>
                <div class="cn-item-details">
                    <div class="cn-item-name-row">
                        <span class="cn-item-name">${agent.name}</span>
                        <span class="cn-item-time">${agent.lastTime}</span>
                    </div>
                    <div class="cn-item-snippet-row">
                        <span class="cn-item-snippet">${snippetText}</span>
                        ${unreadBadge}
                    </div>
                </div>
            `;
            listItemsContainer.appendChild(itemDiv);
        });
    }

    // 6. Switching active agent/conversation & Sync history
    function switchAgent(agentKey) {
        currentAgent = agentKey;
        conversations[agentKey].unread = 0; // mark as read

        // Update active UI details
        const agent = conversations[agentKey];
        activeAvatar.src = agent.avatar;
        activeAvatar.onerror = function() { this.src = agent.avatarFallback; };
        activeName.textContent = agent.name;
        activeRole.textContent = agent.role;
        
        if (agent.status === 'online') {
            activeStatus.style.background = '#10B981';
            activeStatus.style.boxShadow = '0 0 6px #10B981';
        } else {
            activeStatus.style.background = '#cbd5e1';
            activeStatus.style.boxShadow = 'none';
        }

        // Fetch actual chat history from the SQL Server Database
        fetch('ChatHistoryController?receiverId=' + agent.dbId + '&agentId=' + myUserId)
            .then(res => res.json())
            .then(history => {
                chatBody.innerHTML = '';
                agent.messages = [];
                
                if (history && history.length > 0) {
                    agent.hasWelcomed = true; // skip greeting
                    history.forEach(m => {
                        const sender = m.senderId === myUserId ? 'user' : 'bot';
                        agent.messages.push({ text: m.text, sender: sender });
                        appendMessageMarkup(m.text, sender);
                    });
                } else {
                    // Trigger welcome greeting if fresh empty chat
                    if (!agent.hasWelcomed) {
                        triggerWelcomeMessage(agentKey);
                    }
                }
                
                // Update list highlight
                renderAgentList();
            })
            .catch(err => {
                console.warn("Failed to load DB history, using offline backup:", err);
                chatBody.innerHTML = '';
                agent.messages.forEach(msg => {
                    appendMessageMarkup(msg.text, msg.sender);
                });
                renderAgentList();
            });

        // Focus text bar
        chatInput.value = '';
        sendBtn.disabled = true;
        chatInput.focus();
    }

    // 7. Toggle Chat Window
    function openChat() {
        chatWindow.classList.add('open');
        chatTrigger.classList.add('active');
        chatBadge.style.display = 'none';
        isChatOpen = true;
        
        if (Object.keys(conversations).length === 0) {
            loadChatChannels();
        } else {
            renderAgentList();
            switchAgent(currentAgent);
        }
    }

    function closeChat() {
        chatWindow.classList.remove('open');
        chatTrigger.classList.remove('active');
        isChatOpen = false;
    }

    chatTrigger.addEventListener('click', function() {
        if (isChatOpen) {
            closeChat();
        } else {
            openChat();
        }
    });

    closeChatBtn.addEventListener('click', closeChat);

    // 8. Enable/Disable Send Button
    chatInput.addEventListener('input', function() {
        sendBtn.disabled = chatInput.value.trim() === '';
    });

    chatInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter' && chatInput.value.trim() !== '') {
            sendMessage();
        }
    });

    sendBtn.addEventListener('click', sendMessage);

    // 9. Hook into "CONTACT" navigation items globally
    function initContactLinks() {
        const anchors = document.querySelectorAll('a');
        anchors.forEach(a => {
            const text = a.textContent.trim().toUpperCase();
            if (text === 'CONTACT' || text === 'CONTACT US' || text === 'LIÊN HỆ') {
                a.addEventListener('click', function(e) {
                    e.preventDefault();
                    openChat();
                });
            }
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initContactLinks);
    } else {
        initContactLinks();
    }
    setTimeout(initContactLinks, 1000);

    // 10. Messaging Markup Rendering
    function appendMessageMarkup(text, sender) {
        const msgDiv = document.createElement('div');
        msgDiv.className = `cn-message ${sender}`;

        const now = new Date();
        const timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        msgDiv.innerHTML = `
            <div class="cn-message-bubble">${text}</div>
            <div class="cn-message-time">${timeStr}</div>
        `;

        chatBody.appendChild(msgDiv);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    function appendMessage(text, sender) {
        // Save message in state machine
        conversations[currentAgent].messages.push({ text, sender });
        appendMessageMarkup(text, sender);
        renderAgentList(); // Update snippet on list panel
    }

    function showTypingIndicator() {
        const indicator = document.createElement('div');
        indicator.className = 'cn-typing-indicator';
        indicator.id = 'cnTypingIndicator';
        indicator.innerHTML = `
            <div class="cn-typing-dot"></div>
            <div class="cn-typing-dot"></div>
            <div class="cn-typing-dot"></div>
        `;
        chatBody.appendChild(indicator);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    function removeTypingIndicator() {
        const indicator = document.getElementById('cnTypingIndicator');
        if (indicator) {
            indicator.remove();
        }
    }

    function appendQuickOptions(options) {
        const optionsDiv = document.createElement('div');
        optionsDiv.className = 'cn-chat-options';
        optionsDiv.id = 'cnChatOptions';

        options.forEach(opt => {
            const btn = document.createElement('button');
            btn.className = 'cn-option-btn';
            btn.innerHTML = opt.text;
            btn.onclick = function() {
                optionsDiv.remove();
                handleOptionClick(opt.value, opt.text);
            };
            optionsDiv.appendChild(btn);
        });

        chatBody.appendChild(optionsDiv);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    // 11. Custom Welcome Flows
    function triggerWelcomeMessage(agentKey) {
        const agent = conversations[agentKey];
        agent.hasWelcomed = true;
        showTypingIndicator();

        setTimeout(() => {
            removeTypingIndicator();
            appendMessage(agent.welcomeText, 'bot');

            setTimeout(() => {
                if (agent.options && agent.options.length > 0) {
                    appendQuickOptions(agent.options);
                }
            }, 600);

        }, 1000);
    }

    // 12. Handle Option Click Trigger
    function handleOptionClick(value, text) {
        // Send choice to WebSocket so it's logged in DB history
        if (socket && socket.readyState === WebSocket.OPEN) {
            socket.send(JSON.stringify({
                receiverId: conversations[currentAgent].dbId,
                text: text
            }));
        }
        
        appendMessage(text, 'user');
        showTypingIndicator();

        setTimeout(() => {
            removeTypingIndicator();

            let replyText = "";
            let newOpts = [];

            if (value === 'design_advice') {
                conversations[currentAgent].state = 'design_advice_flow';
                replyText = "Redecorating a space is so exciting! To give you custom recommendations, could you tell me:<br><br>1. <strong>What room</strong> are you decorating? (e.g. Living Room, Bedroom, Workspace)<br>2. <strong>What style</strong> do you like? (Minimalist, Japandi, Modern Luxury, Scandinavian)";
            } else if (value === 'track_order') {
                conversations[currentAgent].state = 'track_order_flow';
                replyText = "I can certainly track that for you! 🔍 Please reply with your <strong>Order ID</strong> (e.g., CN-87392) or the <strong>Email Address</strong> associated with your purchase.";
            } else if (value === 'custom_furniture') {
                conversations[currentAgent].state = 'custom_furniture_flow';
                replyText = "We specialize in customizing premium sofas, shelves, and dining tables to perfectly fit your home! 📐<br><br>Please let me know the item type and your desired dimensions (Length x Width x Height), and our design team will generate a quote and 3D sketch for you.";
            } else if (value === 'talk_staff') {
                conversations[currentAgent].state = 'talk_staff_flow';
                replyText = "Connecting you to a Live Support Specialist... 📞<br><br>A member of our design team will join this chat in about 1-2 minutes. Please describe your request in detail so they can help you immediately!";
            } else if (value === 'price') {
                replyText = "All our standard item pricing is transparently listed on the product cards. We offer flexible payment options including Credit Cards, Bank Transfer, and secure Cash on Delivery (COD) with <strong>free shipping on orders over 2,000,000đ</strong>! 💳✨";
                newOpts = conversations[currentAgent].options;
            }

            if (replyText !== "") {
                // Send simulated assistant reply to DB as well
                if (socket && socket.readyState === WebSocket.OPEN) {
                    socket.send(JSON.stringify({
                        receiverId: myUserId, // swap sender/receiver context so it saves correctly
                        text: replyText
                    }));
                }
                appendMessage(replyText, 'bot');
                if (newOpts.length > 0) {
                    appendQuickOptions(newOpts);
                }
            }
        }, 1000);
    }

    // 13. Real-Time Message Send
    function sendMessage() {
        const text = chatInput.value.trim();
        if (text === '') return;

        const agent = conversations[currentAgent];

        // 1. Deliver message through WebSocket (which saves it to SQL Server automatically)
        if (socket && socket.readyState === WebSocket.OPEN) {
            socket.send(JSON.stringify({
                receiverId: agent.dbId,
                text: text
            }));
        }

        // 2. Draw user text on screen
        appendMessage(text, 'user');
        chatInput.value = '';
        sendBtn.disabled = true;

        // Remove options
        const existingOptions = document.getElementById('cnChatOptions');
        if (existingOptions) existingOptions.remove();

        // 3. Simulated Assistant Response Fallback (only for normal customer accounts, skip for support agents)
        const isAgent = myRoleName === 'ROLE_ADMIN' || myRoleName === 'ROLE_PARTNER';
        if (!isAgent) {
            showTypingIndicator();
            setTimeout(() => {
                removeTypingIndicator();
                handleSimulatedAssistantResponse(text);
            }, 1200);
        }
    }

    // 14. Intelligent Simulated Assistant Fallback
    function handleSimulatedAssistantResponse(userMsg) {
        const msg = userMsg.toLowerCase();
        const agent = conversations[currentAgent];
        let reply = "";
        let newOpts = [];

        // Flow-specific handling
        if (agent.state === 'track_order_flow') {
            agent.state = 'idle';
            reply = "Searching our warehouse database... 🖥️<br><br>✨ <strong>Found!</strong> Your package containing your ordered Chill Nest premium decor pieces is currently <strong>In Transit</strong> and out for delivery! 🚚<br><br>The local carrier is scheduled to arrive at your address <strong>tomorrow between 2:00 PM and 5:00 PM</strong>. They will call you 30 minutes before arrival.";
        } else if (agent.state === 'design_advice_flow') {
            agent.state = 'idle';
            let advice = "That sounds absolutely beautiful! 💙<br><br>Based on your input, our architects recommend combining our <strong>White Oak Minimalist Sofa</strong> with a warm blue accent pillow and dynamic soft lighting. This creates the signature <em>Chill Nest peaceful ambiance</em>.";
            
            if (msg.includes('living') || msg.includes('khách')) {
                advice = "A luxury living room is all about creating a focal point! 🛋️ We recommend our signature <strong>Chill Nest Luxury Fabric Sofa</strong> in Navy Blue, paired with a white travertine coffee table. It creates a stunning modern contrast while feeling spacious and extremely premium.";
            } else if (msg.includes('bed') || msg.includes('ngủ')) {
                advice = "For bedrooms, tranquility is key. 😴 We suggest a light-toned oak bedframe, soft blue bedding, and warm ambient decor lamps. Our signature <strong>Nordic Glow Lamp</strong> would be the perfect addition to your nightstand to create a calm, restful sleep environment.";
            } else if (msg.includes('work') || msg.includes('làm việc') || msg.includes('gaming')) {
                advice = "An ergonomic yet artistic workspace boosts focus! 📐 We recommend our solid walnut <strong>Chill Nest Architect Desk</strong>, complete with custom cable management. Combine it with our sleek artificial potted eucalyptus for a touch of lively greenery.";
            }

            reply = advice + "<br><br>Would you like me to show you our catalog items matching this style?";
            newOpts = [
                { text: '🛍️ View Collection Catalog', value: 'go_catalog' },
                { text: '🏡 Speak to an architect', value: 'talk_staff' }
            ];
        } else if (agent.state === 'custom_furniture_flow') {
            agent.state = 'idle';
            reply = "Excellent specifications! 📐 I have recorded your sizing requirements and passed them to our lead carpenter and designers. <br><br>We will review the wood type, structure, and spacing requirements and send an official price estimate & 3D render to your registered email address within 2 hours! 🌳✨";
        } else {
            // Keyword handling
            if (msg.includes('go_catalog')) {
                reply = "Excellent choice! Redirecting you to our curated premium collections... 🛍️";
                setTimeout(() => { window.location.href = 'search'; }, 1000);
            } else if (msg.includes('hello') || msg.includes('hi') || msg.includes('chào')) {
                reply = "Hello! Hope you are having a wonderful day. How can I help you choose the perfect decor today? 😊";
                newOpts = agent.options;
            } else if (msg.includes('price') || msg.includes('giá') || msg.includes('bao nhiêu')) {
                reply = "All our standard item pricing is transparently listed on the product cards. We offer flexible payment options including Credit Cards, Bank Transfer, and secure Cash on Delivery (COD) with <strong>free shipping on orders over 2,000,000đ</strong>! 💳✨";
                newOpts = agent.options;
            } else if (msg.includes('shipping') || msg.includes('vận chuyển') || msg.includes('ship')) {
                reply = "🚚 <strong>Shipping Policy:</strong><br>- Free shipping nationwide for orders over 2,000,000đ.<br>- Fast metropolitan delivery (Hanoi & HCMC) in 24-48 hours.<br>- Standard nationwide shipping takes 3-5 business days.<br>All furniture is double-wrapped with protective foam padding to guarantee flawless arrival!";
                newOpts = agent.options;
            } else {
                // Generic feedback
                reply = "Thank you so much for your message! 💙 I have forwarded your request directly to our customer support queue. <br><br>A Chill Nest consultant will review this chat transcript and reply to your account email shortly. Is there anything else I can help you with in the meantime?";
                newOpts = agent.options;
            }
        }

        if (reply !== "") {
            // Log virtual bot reply in database WebSocket thread
            if (socket && socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    receiverId: myUserId, // logged in client is the receiver in database perspective
                    text: reply
                }));
            }
            appendMessage(reply, 'bot');
            if (newOpts.length > 0) {
                appendQuickOptions(newOpts);
            }
        }
    }
})();
