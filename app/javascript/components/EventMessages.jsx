import React from 'react';

function EventMessages(props) {

  const sortedEventMessages = props.sortInstancesByID(
    props.cloneInstances(props.eventMessages)
  );

  return <div className="green message-box event-box-dimensions">
    {sortedEventMessages.map((eventMessage) => {
      return <h5 key={eventMessage.id}>
        {eventMessage.content}
      </h5>
    })}
  </div>
}

export default EventMessages;
