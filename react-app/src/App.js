import React, { useEffect, useState } from 'react';
import io from 'socket.io-client';

const socket = io('http://localhost:5000');

function App() {
  const [orders, setOrders] = useState([]);

  useEffect(() => {
    socket.on('orders', (initialOrders) => setOrders(initialOrders));
    socket.on('newOrder', (order) => setOrders((prev) => [...prev, order]));

    return () => socket.off();
  }, []);

  return (
    <div>
      <h1>Real-Time Orders</h1>
      <ul>
        {orders.map((order, index) => (
          <li key={index}>
            {order.productName} - {order.quantity} units @ ${order.price}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
