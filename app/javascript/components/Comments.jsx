import React from 'react';

function Comments(props) {
  return <div className="container chat-box chat-box-dimensions">
    {props.comments.map((comment) => {
      return <div key={comment.id}>
        {comment.content}
        <br/><br/>
      </div>
    })}
  </div>
}

export default Comments;
