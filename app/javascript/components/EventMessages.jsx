import React from 'react';

function EventMessages(props) {
  return <div className="green">
    {props.eventMessages.map((eventMessage) => {
      return <h3 key={eventMessage.id}>
        {eventMessage.content}
      </h3>
    })}
  </div>
}

export default EventMessages;
