import React from 'react';

function Comments(props) {

  const sortCommentsByID = (comments) => {
    return comments.sort((x, y) => {
      return y.id - x.id;
    })
  };

  const cloneComments = () => {
    return props.comments.map((comment) => {
      return comment;
    });
  };

  return <div className="message-box chat-box-dimensions">
    {sortCommentsByID(cloneComments()).map((comment) => {
      return <div className="green" key={comment.id}>
        <h5>
          <div>{comment.username}</div>
          {comment.content}
        </h5>
        <br/>
      </div>
    })}
  </div>
}

export default Comments;
