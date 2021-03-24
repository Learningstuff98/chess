import React from 'react';

function Comments(props) {
  return <div className="chat-box chat-box-dimensions">
    {props.comments.map((comment) => {
      return <div className="green" key={comment.id}>
        <div>
          {`By ${comment.username}`}
        </div>
        {comment.content}
        <br/><br/>
      </div>
    })}
  </div>
}

export default Comments;
