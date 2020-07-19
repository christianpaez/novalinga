import axios from 'axios'
import { useHistory } from "react-router-dom";



const getUser = () => {
    // Send a POST request
    return new Promise((resolve, reject) => {

axios({
    method: 'get',
    url: `${process.env.REACT_APP_SERVER_URL}/get_user`,
    withCredentials: true
  })
  .then((response) => {
      resolve(response.data.data)
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
    reject(error)
  });
  
})
} 

const logout = () => {
  // Send a POST request
  return new Promise((resolve, reject) => {

axios({
  method: 'delete',
  url: `${process.env.REACT_APP_SERVER_URL}/logout`,
  withCredentials: true
})
.then((response) => {
    console.log(response)
    document.cookie = "jwt=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
    // Simulate an HTTP redirect:
    window.location.replace(`${process.env.REACT_APP_HOST}`);
    resolve(response.data.data)
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
  reject(error)
});

})
} 

export {
    getUser,
    logout
}
