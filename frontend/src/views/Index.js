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

import {
  Button,
  Container,
  Row,
  Col,
} from "reactstrap";

function Index() {
  document.documentElement.classList.remove("nav-open");
  React.useEffect(() => {
    document.body.classList.add("index");
    return function cleanup() {
      document.body.classList.remove("index");
    };
  });
  return (
    <>
      <div className="main">
        <div className="section text-center">
          <Container>
            <Row className="mt-5">
              <Col className="ml-auto mr-auto" md="8">
                <h2 className="title">Aprenda las frases mas importantes de cualquier idioma</h2>
                <h5 className="description font-weight-normal">
                  En esta plataforma tendrá acceso a las frases mas populares utilizadas
                  en nuestra vida cotidiana en varios idiomas de forma GRATUITA.
                </h5>
                <br />
                <Button
                  className="btn-round"
                  color="primary"
                  onClick={(e) => e.preventDefault()}
                >
                  Iniciar
                </Button>
              </Col>
            </Row>
            
            
            <Row className="mt-5">
              <Col className="ml-auto mr-auto" md="8">
                <h2 className="title">¿Cómo usar este sitio?</h2>
                <h5 className="description font-weight-normal">
                Este sitio está diseñado para aprender lo mas importante de idiomas populares y a las vez servir de diccionario de frases  
                </h5>
              </Col>
            </Row>

            
            <Row className="mt-4">
              <Col md="6">
                <div className="info">
                  <div className="icon icon-secondary">
                  <i class="fa fa-volume-up" aria-hidden="true"></i>
                  </div>
                  <div className="description">
                    <h4 className="info-title">Alfabeto fonético</h4>
                    <p className="font-weight-normal mt-2">
                    Esta sección posee la información necesaria para
                     entender la pronunciación de cada idioma aplicada
                      a tu lengua nativa.
                      <span className = "d-lg-none d-xl-block"><br/></span>
                      <span className = "d-none d-md-block d-lg-none"><br/></span>
                    </p>
                  </div>
                  <Button
                    className="btn-round mt-4"
                    color="primary"
                    href="/phonetic-guide"
                  >
                    Ver guía fonética
                  </Button>
                </div>
              </Col>
              <Col md="6">
                <div className="info">
                  <div className="icon icon-secondary">
                    <i class="fa fa-book" aria-hidden="true"></i>
                  </div>
                  <div className="description">
                    <h4 className="info-title">Cursos/Guías</h4>
                    <p className="font-weight-normal mt-2">
                    Aquí encontrarás las frases mas comunes que puedes necesitar a la hora de aprender el idioma, donde se utilizan y su correcta pronunciación.
                    </p>
                  </div>
                  <Button
                    className="btn-round mt-4"
                    color="primary"
                    href="/phonetic-guide"
                  >
                    Ver Cursos
                  </Button>
                </div>
              </Col>
               </Row>
         
           

            </Container>
            </div>
            </div>
    </>
  );
}

export default Index;
