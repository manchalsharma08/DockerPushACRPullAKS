import React, { useState } from 'react';

function App() {
  const [count, setCount] = useState(0);

  return (
    <div style={{ textAlign: 'center', marginTop: '50px' }}>
      <h1>👋 Welcome to React!</h1>
      <h2>Counter: {count}</h2>
      <button onClick={() => setCount(count + 1)}>
        Click Me!
      </button>
    </div>
  );
}

export default App;
