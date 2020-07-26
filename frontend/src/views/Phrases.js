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
import React, { useCallback } from "react";
import { useParams } from 'react-router-dom';
import {
  Card,
  CardBody,
  CardImg,
  CardText, Col, Container,
  Row
} from "reactstrap";
// services
import * as Appservice from '../services/App';


function Phrases() {

  let {  lessonId } = useParams();

  const [phrases, setPhrases] = React.useState([])
  document.documentElement.classList.remove("nav-open");

  /* const fetchAndSetPhrases = async () => {
    
  } */

  const fetchAndSetPhrases = useCallback(
    async () => {
      const phrases = await Appservice.getPhrases(lessonId);
      setPhrases(phrases)
    }, [lessonId],
  );

  React.useEffect(() => {
    fetchAndSetPhrases()
    document.body.classList.add("index");
    return function cleanup() {
      document.body.classList.remove("index");
    };
  }, [fetchAndSetPhrases]);



  return (
    <>
      <div className="main">
        <div className="section text-center">
          <Container>
            <Row className="mt-5">
              <Col className="ml-auto mr-auto" md="8">
                <h2 className="title">Frases</h2>
                <h5 className="title">Elige una lección para continuar</h5>
              </Col>
            </Row>
            <Row className="mt-5">
              {phrases.length > 0 && (
                phrases.map((phrase) =>{
                  let { id, input_language } = phrase
                return(
                  <Col className="ml-auto mr-auto" md="8" key = {id}>
                    <Card 
                        style={{width: '20rem'}} 
                        className='pointer'
                        onClick={()=>{}}
                        >
                        <CardImg top src="" alt="..." />
                        <CardBody>
                            <CardText>{input_language}</CardText>
                        </CardBody>
                    </Card>
                </Col>
                ) 
                })
              )}
            </Row>
            </Container>
            </div>
            </div>
    </>
  );
}

export default Phrases;
