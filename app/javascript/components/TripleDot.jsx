import React, { useState, useEffect } from 'react';

export default function TripleDot({ message }) {
  const [dots, setDots] = useState("");

  useEffect(() => {
    const interval = setInterval(() => {
      handleSettingDots();
    }, 750);
    return () => clearInterval(interval);
  });

  const handleSettingDots = () => {
    if(dots.length < 6) {
      setDots(`${dots} .`);
    } else {
      setDots("");
    }
  };

  return <div>
    {message}{dots}
  </div>  
}
