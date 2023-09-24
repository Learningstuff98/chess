import React from 'react';

function Comments(props) {

  const sortByID = (comments) => {
    return comments.sort((x, y) => {
      return x.id - y.id;
    })
  };

  const cloneComments = () => {
    let newComments = [];
    for(const comment of props.comments) {
      newComments.push(comment);
    }
    return newComments;
  };

  return <div className="message-box chat-box-dimensions">
    {sortByID(cloneComments()).map((comment) => {
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
