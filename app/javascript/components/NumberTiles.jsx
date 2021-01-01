import React from 'react';

function NumberTiles(props) {
  return <div>
    {props.yValues.map((yValue) => {
      return <div key={yValue} className="number-tile number-tile-dimensions">
        <div className="number-tile-value">
          {yValue}
        </div>
      </div>
    })}
  </div>
}

export default NumberTiles;
