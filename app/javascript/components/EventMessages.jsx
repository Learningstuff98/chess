import React from 'react';

function EventMessages(props) {
  return <div className="green message-box event-box-dimensions">
    {props.eventMessages.map((eventMessage) => {
      return <h5 key={eventMessage.id}>
        {eventMessage.content}
      </h5>
    })}
  </div>
}

export default EventMessages;
