import React, { useState } from 'react';
import wfetch from './util/wfetch';

const submit = (email:string, password:string) => {
  wfetch.post("/login", {email, password})
    .then(json => console.log("res json: ", json))
};

const Login: React.FC = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  return (
    <div>
      <input
        type="text"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <button
        onClick={() => submit(email, password)}
      >
        Login
      </button>
    </div>
  );
};

export default Login
