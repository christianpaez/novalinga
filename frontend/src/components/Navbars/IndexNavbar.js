/*!

=========================================================
* Paper Kit React - v1.2.0
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-kit-react

* Copyright 2020 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://github.com/creativetimofficial/paper-kit-react/blob/master/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*/
import React from "react";
// nodejs library that concatenates strings
import classnames from "classnames";
// reactstrap components
// css
import './styles.css'
import {
  Button,
  Collapse,
  NavbarBrand,
  Navbar,
  NavItem,
  NavLink,
  Nav,
  Container,
} from "reactstrap";
import { servicesVersion } from "typescript";

// services
import { logout } from '../../services/App'

function IndexNavbar(props) {
  const { user } = props
  const [navbarColor, setNavbarColor] = React.useState("navbar-primary");
  const [navbarCollapse, setNavbarCollapse] = React.useState(false);

  const toggleNavbarCollapse = () => {
    setNavbarCollapse(!navbarCollapse);
    document.documentElement.classList.toggle("nav-open");
  };

  React.useEffect(() => {
    const updateNavbarColor = () => {
      if (
        document.documentElement.scrollTop > 299 ||
        document.body.scrollTop > 299
      ) {
        setNavbarColor("");
      } else if (
        document.documentElement.scrollTop < 300 ||
        document.body.scrollTop < 300
      ) {
        setNavbarColor("navbar-transparent");
      }
    };

    window.addEventListener("scroll", updateNavbarColor);

    return function cleanup() {
      window.removeEventListener("scroll", updateNavbarColor);
    };
  });
  return (
    <Navbar className={classnames("fixed-top", navbarColor)} expand="lg">
      <Container>
        <div className="navbar-translate">
        <img  className = "ml-4 ml-sm-0" src={require("assets/img/logo.png")} height = {40} alt="logo" />
          <NavbarBrand
            data-placement="bottom"
            href="/index"
            title="Novalinga"
            className="text-primary mr-auto"
          >
            Novalinga<br/>
            Aprende Idiomas
          </NavbarBrand>
          <button
            aria-expanded={navbarCollapse}
            className={classnames("navbar-toggler navbar-toggler", {
              toggled: navbarCollapse,
            })}
            onClick={toggleNavbarCollapse}
          >
            <span className="navbar-toggler-bar bar1" />
            <span className="navbar-toggler-bar bar2" />
            <span className="navbar-toggler-bar bar3" />
          </button>
        </div>
        <Collapse
          className="justify-content-end"
          navbar
          isOpen={navbarCollapse}
        >
          <Nav navbar>
            <NavItem>
              <NavLink
                href="/phonetic-guide"
              >
                <i className="fa fa-commenting" /> Guía Fonética
              </NavLink>
            </NavItem>
            <NavItem>
              <NavLink
                href="/courses"
              >
                <i className="fa fa-book" /> Cursos
              </NavLink>
            </NavItem>
            {user.logged && 
            <NavItem>
            <NavLink
                  className="btn btn-round btn-danger text-white d-inline-block"
                  onClick={()=> logout()}
                >
                  Cerrar sesión
                </NavLink>
            </NavItem>}
          </Nav>
         
        </Collapse>
      </Container>
    </Navbar>
  );
}

export default IndexNavbar;
