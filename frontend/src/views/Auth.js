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
import { useHistory } from "react-router-dom";
import {
  Col, Container,
  Row
} from "reactstrap";





function Auth(props) {
  const history = useHistory();

  React.useEffect(() => {
    setCookie()
  });
  const setCookie = async () => {
    document.cookie = `jwt=${props.match.params.token}; path=/`
    props.user.setUser()
    history.push("/courses")
  }
  return (
    <>
    
      <div className="main">
        <div className="section text-center">
          <Container>
            <Row className="mt-5">
              <Col className="ml-auto mr-auto" md="8">
                <p className="title">Redirecting...</p>
              </Col>
            </Row>
            </Container>
            </div>
            </div>
    </>
  );
}

export default Auth;
