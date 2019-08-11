import React, { Component } from 'react';

class Navbar extends Component {
  render() {
    return(
        <nav className="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
    <div className="container">
        <a className="navbar-brand js-scroll-trigger" href="#page-top">Nuovalinga</a>
        <button className="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menú
            <i className="fas fa-bars ml-2" />
        </button>
        <div className="collapse navbar-collapse" id="navbarResponsive">
            <ul className="navbar-nav text-uppercase ml-auto">
                <li className="nav-item">
                    <a className="nav-link js-scroll-trigger" href="#services">Inicio</a>
                </li>
                <li className="nav-item">
                    <a className="nav-link js-scroll-trigger" href="#portfolio">Guía</a>
                </li>
                <li className="nav-item">
                    <a className="nav-link js-scroll-trigger" href="#about">Alfabeto Fonético</a>
                </li>
                <li className="nav-item">
                    <a className="nav-link js-scroll-trigger" href="#team">Cursos</a>
                </li>
                <li className="nav-item">
                    <a className="nav-link js-scroll-trigger" href="#contact">Más</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
    );
  }
}
export default Navbar;