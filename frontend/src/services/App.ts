import axios from 'axios';



const getUser = (): Promise<any> => {
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

const logout = (): Promise<any> => {
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

const getCourses = (): Promise<any> => {
  // Send a GET request
  return new Promise((resolve, reject) => {

axios({
  method: 'get',
  url: `${process.env.REACT_APP_SERVER_URL}/courses`,
  headers:{
    'Accept':'*/*',
    'Content-type':'application/json'
  },
  withCredentials: true
})
.then((response) => {
    // Simulate an HTTP redirect:
    console.log(response)
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

const getLessons = (id: string): Promise<any> => {
  // Send a GET request
  return new Promise((resolve, reject) => {

axios({
  method: 'get',
  url: `${process.env.REACT_APP_SERVER_URL}/lessons?course_id=${id}`,
  withCredentials: true
})
.then((response) => {
    // Simulate an HTTP redirect:
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

const getPhrases = (lessonId: string): Promise<any> => {
  // Send a GET request
  return new Promise((resolve, reject) => {

axios({
  method: 'get',
  url: `${process.env.REACT_APP_SERVER_URL}/phrases?lesson_id=${lessonId}`,
  withCredentials: true
})
.then((response) => {

  // Simulate an HTTP redirect:
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
  logout,
  getCourses,
  getLessons,
  getPhrases
};

