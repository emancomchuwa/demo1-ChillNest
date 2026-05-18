<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ page import="Model.User" %>
<%
    User loggedIn = (User) session.getAttribute("user");
    long defaultAgentId = 1; // Default to Admin
    String defaultAgentName = "Chill Nest Admin";
    if (loggedIn != null) {
        defaultAgentId = loggedIn.getId();
        defaultAgentName = loggedIn.getFullName();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chill Nest - Support & Architecture Console</title>
    <!-- Google Fonts & FontAwesome -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #2c5282;
            --primary-dark: #1a365d;
            --slate-900: #0f172a;
            --slate-800: #1e293b;
            --slate-700: #334155;
            --slate-100: #f1f5f9;
            --emerald: #10b981;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: var(--slate-700);
            height: 100vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* 1. Header */
        .cn-admin-header {
            background: linear-gradient(135deg, var(--slate-900) 0%, var(--slate-800) 100%);
            padding: 16px 30px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            z-index: 10;
        }

        .cn-header-logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .cn-header-logo i {
            font-size: 1.8rem;
            color: #3b82f6;
            text-shadow: 0 0 12px rgba(59, 130, 246, 0.5);
        }

        .cn-header-logo h2 {
            font-family: 'Outfit', sans-serif;
            font-weight: 800;
            font-size: 1.3rem;
            letter-spacing: -0.5px;
        }

        .cn-header-logo span {
            font-size: 0.72rem;
            background: rgba(59, 130, 246, 0.2);
            color: #93c5fd;
            border: 1px solid rgba(59, 130, 246, 0.4);
            padding: 2px 8px;
            border-radius: 12px;
            text-transform: uppercase;
            font-weight: 700;
        }

        .cn-simulator-selector {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 6px 14px;
            border-radius: 20px;
        }

        .cn-simulator-selector label {
            font-size: 0.75rem;
            font-weight: 700;
            color: #94a3b8;
        }

        .cn-simulator-selector select {
            background: transparent;
            border: none;
            color: white;
            font-size: 0.8rem;
            font-weight: 600;
            outline: none;
            cursor: pointer;
        }

        .cn-simulator-selector select option {
            background: var(--slate-800);
            color: white;
        }

        /* Main Workspace Wrapper */
        .cn-admin-workspace {
            display: flex;
            flex-grow: 1;
            height: calc(100vh - 65px);
            overflow: hidden;
        }

        /* 2. Left Panel: Client List */
        .cn-admin-list-panel {
            width: 320px;
            background: white;
            border-right: 1px solid #e2e8f0;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
        }

        .cn-panel-title {
            padding: 24px 20px 12px 20px;
        }

        .cn-panel-title h3 {
            font-family: 'Outfit', sans-serif;
            font-weight: 800;
            font-size: 1.2rem;
            color: var(--slate-900);
            letter-spacing: -0.3px;
        }

        .cn-panel-search {
            margin: 0 20px 15px 20px;
            background: var(--slate-100);
            border-radius: 12px;
            padding: 10px 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cn-panel-search i {
            color: #94a3b8;
            font-size: 0.85rem;
        }

        .cn-panel-search input {
            border: none;
            background: transparent;
            font-size: 0.8rem;
            outline: none;
            width: 100%;
            font-family: inherit;
        }

        .cn-client-items {
            flex-grow: 1;
            overflow-y: auto;
            padding: 0 10px 20px 10px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .cn-client-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px;
            border-radius: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
            border-left: 3px solid transparent;
            background: #fff;
        }

        .cn-client-item:hover {
            background: var(--slate-100);
        }

        .cn-client-item.active {
            background: #f1f5f9;
            border-left-color: var(--primary);
        }

        .cn-client-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--slate-100);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-weight: 700;
            font-size: 1.1rem;
            border: 2px solid white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            flex-shrink: 0;
        }

        .cn-client-details {
            flex-grow: 1;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .cn-client-name {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--slate-900);
        }

        .cn-client-meta {
            font-size: 0.74rem;
            color: #64748b;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .cn-client-badge {
            background: var(--emerald);
            color: white;
            font-size: 0.65rem;
            font-weight: 700;
            border-radius: 10px;
            padding: 2px 6px;
        }

        /* 3. Center/Right Panel: Chat Interface */
        .cn-admin-chat-panel {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            background: #f8fafc;
            position: relative;
        }

        /* Active Client Details Header */
        .cn-active-header {
            background: white;
            border-bottom: 1px solid #e2e8f0;
            padding: 16px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .cn-active-info {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .cn-active-title {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--slate-900);
            margin-bottom: 3px;
        }

        .cn-active-status {
            font-size: 0.72rem;
            color: var(--emerald);
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: 600;
        }

        /* Message Area */
        .cn-admin-chat-body {
            flex-grow: 1;
            padding: 30px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 18px;
            background: #f1f5f9;
        }

        .cn-chat-msg {
            display: flex;
            flex-direction: column;
            max-width: 65%;
            animation: cnSlideUp 0.3s ease;
        }

        @keyframes cnSlideUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .cn-chat-msg.client {
            align-self: flex-start;
        }

        .cn-chat-msg.agent {
            align-self: flex-end;
        }

        .cn-chat-bubble {
            padding: 14px 18px;
            border-radius: 18px;
            font-size: 0.88rem;
            line-height: 1.45;
            word-wrap: break-word;
        }

        .cn-chat-msg.client .cn-chat-bubble {
            background: white;
            color: var(--slate-900);
            border-bottom-left-radius: 4px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.02);
            border: 1px solid rgba(0,0,0,0.03);
        }

        .cn-chat-msg.agent .cn-chat-bubble {
            background: var(--primary);
            color: white;
            border-bottom-right-radius: 4px;
            box-shadow: 0 6px 15px rgba(44, 82, 130, 0.25);
        }

        .cn-chat-time {
            font-size: 0.68rem;
            color: #94a3b8;
            margin-top: 5px;
            align-self: flex-start;
        }

        .cn-chat-msg.agent .cn-chat-time {
            align-self: flex-end;
        }

        /* Empty state view */
        .cn-empty-chat-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex-grow: 1;
            color: #94a3b8;
            gap: 15px;
            background: #f8fafc;
        }

        .cn-empty-chat-state i {
            font-size: 3rem;
            color: #cbd5e1;
        }

        /* Footer Input Area */
        .cn-admin-footer {
            background: white;
            border-top: 1px solid #e2e8f0;
            padding: 18px 30px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .cn-admin-input-wrapper {
            flex-grow: 1;
            background: var(--slate-100);
            border-radius: 26px;
            padding: 4px 20px;
            display: flex;
            align-items: center;
            border: 1.5px solid transparent;
            transition: all 0.2s;
        }

        .cn-admin-input-wrapper:focus-within {
            border-color: rgba(44, 82, 130, 0.5);
            background: white;
            box-shadow: 0 0 0 4px rgba(44, 82, 130, 0.1);
        }

        .cn-admin-input {
            width: 100%;
            background: transparent;
            border: none;
            outline: none;
            font-size: 0.9rem;
            color: var(--slate-900);
            padding: 10px 0;
            font-family: inherit;
        }

        .cn-admin-send-btn {
            background: var(--primary);
            border: none;
            color: white;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 10px rgba(44, 82, 130, 0.3);
        }

        .cn-admin-send-btn:hover:not(:disabled) {
            background: var(--primary-dark);
            transform: scale(1.05);
        }

        .cn-admin-send-btn:disabled {
            background: #cbd5e1;
            color: #94a3b8;
            cursor: not-allowed;
            box-shadow: none;
        }
    </style>
</head>
<body>

    <!-- 1. HEADER BAR -->
    <header class="cn-admin-header">
        <div class="cn-header-logo">
            <i class="fa-solid fa-network-wired"></i>
            <h2>Chill Nest Support Console</h2>
            <span>Console v2.0</span>
        </div>
        
        <!-- Support Channel Simulator Selector -->
        <div class="cn-simulator-selector">
            <label for="agentSelect"><i class="fa-solid fa-user-tie"></i> SIMULATE AS:</label>
            <select id="agentSelect" onchange="switchAgentSimulator()">
                <option value="1" <%= defaultAgentId == 1 ? "selected" : "" %>>System Administrator (Chill Nest Admin)</option>
                <option value="3" <%= defaultAgentId == 3 ? "selected" : "" %>>Đối tác thiết kế (Trần Thị Đối Tác)</option>
            </select>
        </div>
    </header>

    <!-- MAIN WORKSPACE -->
    <div class="cn-admin-workspace">
        
        <!-- 2. LEFT PANEL: Active Clients List -->
        <aside class="cn-admin-list-panel">
            <div class="cn-panel-title">
                <h3>Active Client Chats</h3>
            </div>
            <div class="cn-panel-search">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Search clients...">
            </div>
            <div class="cn-client-items" id="clientItemsContainer">
                <!-- Dynamically populated chatting clients list -->
            </div>
        </aside>

        <!-- 3. RIGHT PANEL: Chat Workspace Thread -->
        <main class="cn-admin-chat-panel">
            
            <div id="chatPaneActive" style="display: none; flex-direction: column; height: 100%;">
                <!-- Header detail -->
                <div class="cn-active-header">
                    <div class="cn-active-info">
                        <div class="cn-client-avatar" id="activeClientLetter">C</div>
                        <div>
                            <div class="cn-active-title" id="activeClientName">Guest User</div>
                            <div class="cn-active-status">
                                <i class="fa-solid fa-circle" style="font-size: 0.4rem;"></i> Online
                            </div>
                        </div>
                    </div>
                    <div>
                        <span class="cn-client-badge" id="activeClientTag">GUEST</span>
                    </div>
                </div>

                <!-- Messages area -->
                <div class="cn-admin-chat-body" id="chatBody">
                    <!-- Text message bubbles dynamically loaded here -->
                </div>

                <!-- Input controls -->
                <div class="cn-admin-footer">
                    <div class="cn-admin-input-wrapper">
                        <input type="text" class="cn-admin-input" id="chatInput" placeholder="Type your official reply..." autocomplete="off">
                    </div>
                    <button class="cn-admin-send-btn" id="sendBtn" disabled>
                        <i class="fa-solid fa-paper-plane"></i>
                    </button>
                </div>
            </div>

            <!-- Empty chat details state -->
            <div class="cn-empty-chat-state" id="chatPaneEmpty">
                <i class="fa-solid fa-comments"></i>
                <p>Select an active client from the left panel to begin support</p>
            </div>

        </main>
    </div>

    <!-- JavaScript logic -->
    <script>
        let myAgentId = <%= defaultAgentId %>;
        let selectedClientId = null;
        let socket = null;
        let clientList = [];

        // Load chatting client lists
        function loadChattingClients() {
            fetch('ChattingClientsController?agentId=' + myAgentId)
                .then(res => res.json())
                .then(data => {
                    clientList = data;
                    renderClientList();
                })
                .catch(err => console.error("Error loading chatting clients:", err));
        }

        function renderClientList() {
            const container = document.getElementById('clientItemsContainer');
            container.innerHTML = '';
            
            if (clientList.length === 0) {
                container.innerHTML = `
                    <div style="padding: 30px; text-align: center; color: #94a3b8; font-size: 0.8rem;">
                        <i class="fa-solid fa-circle-exclamation" style="font-size: 1.5rem; margin-bottom: 8px;"></i>
                        <p>No active chat channels found for this agent.</p>
                    </div>
                `;
                return;
            }

            clientList.forEach(client => {
                const itemDiv = document.createElement('div');
                itemDiv.className = `cn-client-item ${client.id === selectedClientId ? 'active' : ''}`;
                itemDiv.onclick = () => selectClient(client);

                const letter = client.fullName.substring(0,1).toUpperCase();
                const isGuest = client.fullName.toLowerCase().includes("khách");

                itemDiv.innerHTML = `
                    <div class="cn-client-avatar">${letter}</div>
                    <div class="cn-client-details">
                        <span class="cn-client-name">${client.fullName}</span>
                        <span class="cn-client-meta">${isGuest ? 'Guest Session' : client.email}</span>
                    </div>
                `;
                container.appendChild(itemDiv);
            });
        }

        // Select Client
        function selectClient(client) {
            selectedClientId = client.id;
            
            // Highlight selected in list
            renderClientList();

            // Toggle screens
            document.getElementById('chatPaneEmpty').style.display = 'none';
            document.getElementById('chatPaneActive').style.display = 'flex';

            // Update header details
            document.getElementById('activeClientName').textContent = client.fullName;
            document.getElementById('activeClientLetter').textContent = client.fullName.substring(0,1).toUpperCase();
            
            const isGuest = client.fullName.toLowerCase().includes("khách");
            const tag = document.getElementById('activeClientTag');
            if (isGuest) {
                tag.textContent = "GUEST";
                tag.style.background = "#e2e8f0";
                tag.style.color = "#64748b";
            } else {
                tag.textContent = "CUSTOMER";
                tag.style.background = "#dbeafe";
                tag.style.color = "#2563eb";
            }

            // Load persistent chat history
            loadChatHistory();
        }

        // Fetch History
        function loadChatHistory() {
            const body = document.getElementById('chatBody');
            body.innerHTML = `
                <div style="display:flex; align-items:center; justify-content:center; flex-grow:1; color:#94a3b8; font-size:0.8rem;">
                    <i class="fa-solid fa-spinner fa-spin" style="margin-right:8px;"></i> Loading chat logs...
                </div>
            `;

            // Request ChatHistoryController simulating senderId = selectedClientId
            // Because history retrieves all messages exchanged, this maps perfectly!
            fetch('ChatHistoryController?receiverId=' + myAgentId + '&agentId=' + selectedClientId)
                .then(res => res.json())
                .then(history => {
                    body.innerHTML = '';
                    if (history.length === 0) {
                        body.innerHTML = `
                            <div style="display:flex; align-items:center; justify-content:center; flex-grow:1; color:#94a3b8; font-size:0.8rem; flex-direction:column; gap:10px;">
                                <i class="fa-solid fa-ghost" style="font-size:1.5rem;"></i> No previous chat logs found.
                            </div>
                        `;
                        return;
                    }
                    history.forEach(m => {
                        // If senderId equals selectedClientId, it is from 'client'
                        const senderType = m.senderId === selectedClientId ? 'client' : 'agent';
                        appendMessageMarkup(m.text, senderType, m.createdAt);
                    });
                })
                .catch(err => {
                    console.error("Error loading history:", err);
                    body.innerHTML = `<div style="padding:20px; color:#ef4444; font-size:0.8rem; text-align:center;">Failed to load chat history logs.</div>`;
                });
        }

        function appendMessageMarkup(text, senderType, createdAtStr) {
            const body = document.getElementById('chatBody');
            const msgDiv = document.createElement('div');
            msgDiv.className = `cn-chat-msg ${senderType}`;

            let timeStr = "";
            if (createdAtStr) {
                // simple parse
                const parts = createdAtStr.split(" ");
                if (parts.length > 1) {
                    timeStr = parts[1].substring(0, 5); // HH:mm
                } else {
                    timeStr = new Date(createdAtStr).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                }
            } else {
                timeStr = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            }

            msgDiv.innerHTML = `
                <div class="cn-chat-bubble">${text}</div>
                <div class="cn-chat-time">${timeStr}</div>
            `;
            body.appendChild(msgDiv);
            body.scrollTop = body.scrollHeight;
        }

        // Establish WebSocket Connection
        function connectWebSocket() {
            if (socket) {
                socket.close();
            }

            const loc = window.location;
            let new_uri = loc.protocol === "https:" ? "wss:" : "ws:";
            
            // Tomcat Context Path detection
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

            new_uri += "//" + loc.host + contextPath + "/chat/" + myAgentId;

            console.log(">>> Admin WebSocket connecting to: " + new_uri);
            socket = new WebSocket(new_uri);

            socket.onopen = function() {
                console.log(">>> Admin support socket online!");
            };

            socket.onmessage = function(event) {
                const msg = JSON.parse(event.data);
                console.log(">>> Live message received in admin dashboard:", msg);

                // If message is from the client currently open
                if (msg.senderId === selectedClientId) {
                    appendMessageMarkup(msg.text, 'client', msg.createdAt);
                } else {
                    // Update lists to show notification/new chatter
                    loadChattingClients();
                }
            };

            socket.onclose = function() {
                console.log(">>> Admin socket closed. Reconnecting in 3s...");
                setTimeout(connectWebSocket, 3000);
            };

            socket.onerror = function(err) {
                console.error(">>> Admin socket error:", err);
            };
        }

        // Send Reply Message
        function sendReply() {
            const input = document.getElementById('chatInput');
            const text = input.value.trim();
            if (text === '' || !selectedClientId) return;

            if (socket && socket.readyState === WebSocket.OPEN) {
                // Send reply payload
                socket.send(JSON.stringify({
                    receiverId: selectedClientId,
                    text: text
                }));

                appendMessageMarkup(text, 'agent');
                input.value = '';
                document.getElementById('sendBtn').disabled = true;
            } else {
                alert("WebSocket is not active. Attempting to reconnect...");
                connectWebSocket();
            }
        }

        // Handle active simulator change
        function switchAgentSimulator() {
            const select = document.getElementById('agentSelect');
            myAgentId = parseInt(select.value);
            
            // Reset active pane
            selectedClientId = null;
            document.getElementById('chatPaneActive').style.display = 'none';
            document.getElementById('chatPaneEmpty').style.display = 'flex';

            console.log(">>> Switched support simulation view to Agent ID: " + myAgentId);
            
            // Reconnect WebSocket & reload chatting users
            connectWebSocket();
            loadChattingClients();
        }

        // Keyboard bindings
        document.getElementById('chatInput').addEventListener('input', function() {
            document.getElementById('sendBtn').disabled = this.value.trim() === '';
        });

        document.getElementById('chatInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter' && this.value.trim() !== '') {
                sendReply();
            }
        });

        document.getElementById('sendBtn').addEventListener('click', sendReply);

        // Initial launch sequence
        connectWebSocket();
        loadChattingClients();

        // Refresh client list every 10 seconds to detect new chat requests
        setInterval(loadChattingClients, 10000);
    </script>
</body>
</html>
