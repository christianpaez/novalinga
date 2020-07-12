import React from "react";
import {userContext} from './context/userContext';
import Main from './views/Main'

// services
import * as AppService from './services/App.tsx'
// helpers
import * as AppHelper from './helpers/App.tsx'

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        user: {}
    };
  }

  componentDidMount() {
    AppService.getUser()
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
