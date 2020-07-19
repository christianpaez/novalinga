import React from "react";
import {userContext} from './context/userContext';
import Main from './views/Main'

// services
import * as AppService from './services/App.js'
// helpers
import * as AppHelper from './helpers/App.js'

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        user: {}
    };
  }

  async componentDidMount() {
    try {
      console.log("component did mount")
      console.log(document.location.pathname)
      if(!document.location.pathname.includes("auth")){

        const user = await AppService.getUser()
        console.log(user)
        this.setState({
          user: {
            email: user.email,
            image: user.image,
            logged: true
          }
        })
      }
      } catch (error) {
      
    }
  }

  render() {
    return (
      // Pass user state as value to context.Provider so it can be consumed by context.Consumer
      <userContext.Provider value={this.state.user}>
        <Main/>
      </userContext.Provider>
    );
  }
}

export default App
