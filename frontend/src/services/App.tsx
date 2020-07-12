import axios from 'axios'

const getUser = async () => {
    // Send a POST request
axios({
    method: 'get',
    url: `${process.env.REACT_APP_SERVER_URL}/get_user`,
    withCredentials: true
  })
  .then((response) => {
      console.log(response)
  })
  .catch(function (error) {
    console.log(error)
    if (error.response) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx
      console.log(error.response.data);
      console.log(error.response.status);
      console.log(error.response.headers);
    } else if (error.request) {
      // The request was made but no response was received
      // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
      // http.ClientRequest in node.js
      console.log(error.request);
    } else {
      // Something happened in setting up the request that triggered an Error
      console.log('Error', error.message);
    }
    console.log(error.config);
  });
} 

export {
    getUser
}
