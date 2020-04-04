/*video call code followed using https://blog.usejournal.com/videochat-in-under-30-a-rails-react-tutorial-534930c6cd96*/

export const JOIN_CALL = "JOIN_CALL";
export const EXCHANGE = "EXCHANGE";
export const LEAVE_CALL = "LEAVE_CALL";
export const ice = { iceServers: [
   { 
      urls: "stun:stun2.l.google.com:19302" 
   }
]};
export const broadcastData = data => {
   fetch("calls", {
                    method: "POST",
                    body: JSON.stringify(data),
                    headers: {"content-type": "application/json"}
                  }
   );
};
