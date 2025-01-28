const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
const server = http.createServer(app);
const io = new Server(server, { cors: { origin: "*" } });

app.use(cors());
app.use(bodyParser.json());

const secretKey = 'secret123'; // Secret for JWT
let orders = []; // Mock order storage

// Mock login endpoint
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  if (username === 'test' && password === 'password123') {
    const token = jwt.sign({ username }, secretKey, { expiresIn: '1h' });
    return res.status(200).json({ token });
  }
  return res.status(401).json({ message: 'Invalid credentials' });
});

// Token validation endpoint
app.post('/validate-token', (req, res) => {
  const { token } = req.body;

  try {
    const decoded = jwt.verify(token, secretKey);
    res.status(200).json({ valid: true, username: decoded.username });
  } catch (err) {
    res.status(401).json({ valid: false, message: 'Invalid or expired token' });
  }
});

// Order submission endpoint
app.post('/order', (req, res) => {
  const { token, order } = req.body;

  try {
    // jwt.verify(token, secretKey);

    if (order && order.productName && order.quantity && order.price) {
      orders.push(order);
      io.emit('newOrder', order); // Broadcast new order
      return res.status(200).json({ message: 'Order submitted' });
    }
    return res.status(400).json({ message: 'Invalid order data' });
  } catch (err) {
    return res.status(401).json({ message: 'Invalid or expired token' });
  }
});

// Real-time communication with Socket.IO
io.on('connection', (socket) => {
  console.log('A user connected');
  socket.emit('orders', orders); // Send existing orders on connection
  socket.on('disconnect', () => console.log('A user disconnected'));
});

// Start server
server.listen(5000, () => {
  console.log('Server running on http://localhost:5000');
});
