import React, { Component } from 'react';
import Navbar from './NavbarComponent';
import Footer from './FooterComponent';
import Content from './ContentComponent';


class Main extends Component {
  render() {
    return (
      <div>
       <Navbar />
       <Content />
       <Footer />
      </div>
    );
  }
}
export default Main;
