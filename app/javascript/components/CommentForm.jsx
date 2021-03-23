import React, { useState } from "react";
import axios from "axios";

function CommentForm(props) {
  const [input, setInput] = useState('');

  const submitComment = (formData) => {
    axios.post(`${props.root_url}games/${props.game.id}/comments`, formData)
    .catch((err) => console.log(err.response.data));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    submitComment({ content: input });
    setInput('');
  };

  const inputButton = () => {
    return <input
      type="submit"
      value="Submit"
      className="btn btn-primary"
    />
  };

  const inputElement = () => {
    return <input
      type="text"
      placeholder="Add a comment"
      id="input-element"
      size="30"
      value={input}
      onChange={e => setInput(e.target.value)}
      className="field"
    />
  };

  return <form className="comment-form-placement" onSubmit={handleSubmit}>
    {inputElement()}
    <br/><br/>
    {inputButton()}
  </form>
}

export default CommentForm;
