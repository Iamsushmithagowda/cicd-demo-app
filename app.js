// app.js
const http = require('http');
const port = process.env.PORT || 3000;

// Simple in-memory data store
const users = [
  { id: 1, name: 'Alice', email: 'alice@example.com' },
  { id: 2, name: 'Bob', email: 'bob@example.com' },
];

const server = http.createServer((req, res) => {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  res.setHeader('Content-Type', 'application/json');

  // Health check
  if (req.url === '/health' && req.method === 'GET') {
    res.writeHead(200);
    res.end(JSON.stringify({ status: 'ok', timestamp: new Date().toISOString() }));
    return;
  }

  // Get all users
  if (req.url === '/api/users' && req.method === 'GET') {
    res.writeHead(200);
    res.end(JSON.stringify({ success: true, data: users }));
    return;
  }

  // Get user by ID
  if (req.url.match(/^\/api\/users\/\d+$/) && req.method === 'GET') {
    const id = parseInt(req.url.split('/')[3]);
    const user = users.find(u => u.id === id);
    
    if (user) {
      res.writeHead(200);
      res.end(JSON.stringify({ success: true, data: user }));
    } else {
      res.writeHead(404);
      res.end(JSON.stringify({ success: false, error: 'User not found' }));
    }
    return;
  }

  // Create user
  if (req.url === '/api/users' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const newUser = JSON.parse(body);
        if (!newUser.name || !newUser.email) {
          res.writeHead(400);
          res.end(JSON.stringify({ success: false, error: 'Name and email required' }));
          return;
        }
        newUser.id = Math.max(...users.map(u => u.id)) + 1;
        users.push(newUser);
        res.writeHead(201);
        res.end(JSON.stringify({ success: true, data: newUser }));
      } catch (err) {
        res.writeHead(400);
        res.end(JSON.stringify({ success: false, error: 'Invalid JSON' }));
      }
    });
    return;
  }

  // Welcome endpoint
  if (req.url === '/' && req.method === 'GET') {
    res.writeHead(200);
    res.end(JSON.stringify({
      message: '🚀 Welcome to CI/CD Demo API!',
      version: '1.0.0',
      endpoints: {
        'GET /': 'This message',
        'GET /health': 'Health check',
        'GET /api/users': 'Get all users',
        'GET /api/users/:id': 'Get user by ID',
        'POST /api/users': 'Create new user'
      }
    }));
    return;
  }

  // 404
  res.writeHead(404);
  res.end(JSON.stringify({ success: false, error: 'Endpoint not found' }));
});

server.listen(port, () => {
  console.log(`✅ Server running on http://localhost:${port}`);
  console.log(`📝 Try: curl http://localhost:${port}/api/users`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('🛑 Server shutting down...');
  server.close(() => {
    console.log('✅ Server closed');
    process.exit(0);
  });
});

module.exports = server;
