import React, { Component } from 'react';
import Navbar from './NavbarComponent';
import Footer from './FooterComponent';
import Start from './StartComponent';


class Main extends Component {
  render() {
    return (
      <div>
       <Navbar />
       <Start />
       <Footer />
      </div>
    );
  }
}
export default Main;
