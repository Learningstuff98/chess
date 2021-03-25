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

  return <div className="chat-box chat-box-dimensions">
    {sortByID(cloneComments()).map((comment) => {
      return <div className="green" key={comment.id}>
        <div>{comment.username}</div>
        {comment.content}
        <br/><br/>
      </div>
    })}
  </div>
}

export default Comments;
