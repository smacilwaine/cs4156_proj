{/*video call code followed using https://blog.usejournal.com/videochat-in-under-30-a-rails-react-tutorial-534930c6cd96*/}

import React from 'react';
import VideoCall from './components/VideoCall';
import ReactDOM from 'react-dom';
document.addEventListener("DOMContentLoaded", () => {
    const root = document.getElementById("root");
    ReactDOM.render(<VideoCall />, root)
});
