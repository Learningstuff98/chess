import React from 'react';

function Comments(props) {

  const sortedComments = props.sortInstancesByID(
    props.cloneInstances(props.comments)
  );

  return <div className="message-box chat-box-dimensions">
    {sortedComments.map((comment) => {
      return <h5 className="green" key={comment.id}>
        <div>{comment.username}</div>
        {comment.content}
        <br/><br/>
      </h5>
    })}
  </div>
}

export default Comments;
