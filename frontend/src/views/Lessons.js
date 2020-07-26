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
import { useHistory, useLocation, useParams } from 'react-router-dom';
import {
  Card,
  CardBody,
  CardImg,
  CardText, Col, Container,
  Row
} from "reactstrap";
// services
import * as Appservice from '../services/App';

function Lessons() {

  let { courseId } = useParams();
  let location = useLocation();
  let history = useHistory();

  const [lessons, setLessons] = React.useState([])
  document.documentElement.classList.remove("nav-open");

  const fetchAndSetLessons = useCallback(async ()=>{
    
      const lessons = await Appservice.getLessons(courseId);
      setLessons(lessons)
    }, [courseId],
  )


  React.useEffect(() => {
    fetchAndSetLessons()
    document.body.classList.add("index");
    return function cleanup() {
      document.body.classList.remove("index");
    };
  }, [fetchAndSetLessons]);

  const goToPhrases = (lessonId) => {
    history.push(`${location.pathname}/${lessonId}`)
  }


  return (
    <>
      <div className="main">
        <div className="section text-center">
          <Container>
            <Row className="mt-5">
              <Col className="ml-auto mr-auto" md="8">
                <h2 className="title">Lecciones</h2>
                <h5 className="title">Elige una lección para continuar</h5>
              </Col>
            </Row>
            <Row className="mt-5">
              {lessons.length > 0 && (
                lessons.map((lesson) =>{
                  let { id } = lesson
                return(
                  <Col className="ml-auto mr-auto" md="8" key = {id}>
                    <Card 
                        style={{width: '20rem'}} 
                        className='pointer'
                        onClick={()=>goToPhrases(id)}
                        >
                        <CardImg top src="" alt="..." />
                        <CardBody>
                            <CardText>{lesson.title}</CardText>
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

export default Lessons;
