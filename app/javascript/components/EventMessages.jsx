import React from 'react';

function EventMessages(props) {

  const sortEventMessagesByID = (eventMessages) => {
    return eventMessages.sort((x, y) => {
      return y.id - x.id;
    })
  };

  const cloneEventMessages = () => {
    return props.eventMessages.map((eventMessage) => {
      return eventMessage;
    });
  };

  return <div className="green message-box event-box-dimensions">
    {sortEventMessagesByID(cloneEventMessages()).map((eventMessage) => {
      return <h5 key={eventMessage.id}>
        {eventMessage.content}
      </h5>
    })}
  </div>
}

export default EventMessages;
