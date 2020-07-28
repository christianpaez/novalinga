import React from "react";
import { userContext } from './context/userContext';
// services
import * as AppService from './services/App.ts';
import Main from './views/Main';



class App extends React.Component {
  constructor(props) {
    super(props);

    // set User
    this.setUser = async () => {
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

    this.state = {
        user: {},
        setUser: this.setUser
    };
  }

  async componentDidMount() {
    try {
      if(!document.location.pathname.includes("auth")){

        const user = await AppService.getUser()
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
      <userContext.Provider value={this.state}>
        <Main/>
      </userContext.Provider>
    );
  }
}

export default App
