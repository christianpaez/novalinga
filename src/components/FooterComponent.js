import React, { Component } from 'react';

class Footer extends Component {
  render() {
    return(
        <footer className="footer">
            <div className="container">
      <div className="row align-items-center">
        <div className="col-md-4">
          <span className="copyright text-white">Copyright &copy; Nuovalinga 2019</span>
        </div>
        <div className="col-md-4">
          <ul className="list-inline social-buttons">
            <li className="list-inline-item">
              <a href="./">
                <i className="fab fa-youtube fa-lg text-dark"></i>
              </a>
            </li>
            <li className="list-inline-item">
              <a href="./">
                <i className="fab fa-facebook-f fa-lg text-dark"></i>
              </a>
            </li>
            <li className="list-inline-item">
              <a href="./">
                <i className="fab fa-instagram fa-lg text-dark"></i>
              </a>
            </li>
          </ul>
        </div>
        <div className="col-md-4">
        </div>
      </div>
    </div>
  </footer>


    );
  }
}
export default Footer;
