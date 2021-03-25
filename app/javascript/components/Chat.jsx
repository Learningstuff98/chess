import React from 'react';
import CommentForm from './CommentForm';
import Comments from './Comments';

function Chat(props) {

  return <div>
    <Comments
      comments={props.comments}
    />
    <CommentForm
      root_url={props.root_url}
      game={props.game}
    />
  </div>
}

export default Chat;
