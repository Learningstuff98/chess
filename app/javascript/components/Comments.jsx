import React from 'react';

function Comments(props) {
  return <div className="chat-box chat-box-dimensions container">
    {props.comments.map((comment) => {
      return <div key={comment.id}>
        {comment.content}
        <br/><br/>
      </div>
    })}
  </div>
}

export default Comments;
