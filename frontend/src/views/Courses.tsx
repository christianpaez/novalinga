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
// router
import { useHistory } from "react-router-dom";
import {
  Card,
  CardBody,
  CardImg,
  CardText, Col, Container,
  Row
} from "reactstrap";
// services
import * as Appservice from '../services/App';

//  interfaces
import CourseI from '../interfaces/Courses'




function Courses() {

  const history = useHistory()

  const [courses, setCourses] = React.useState<CourseI[]>([])
  document.documentElement.classList.remove("nav-open");
  React.useEffect(() => {
    fetchAndSetCourses()
    document.body.classList.add("index");
    return function cleanup() {
      document.body.classList.remove("index");
    };
  }, []);

  const fetchAndSetCourses = async () => {
    const courses = await Appservice.getCourses();
    setCourses(courses)
  }

  const goToLesson = (courseId) => {
    history.push(`courses/${courseId}`)
  }

  return (
    <>
      <div className="main">
        <div className="section text-center">
          <Container>
            <Row className="mt-5">
              <Col className="ml-auto mr-auto" md="8">
                <h2 className="title">Cursos</h2>
                <h5 className="title">Elige un curso para continuar</h5>
              </Col>
            </Row>
            <Row className="mt-5">
              {courses.length > 0 && (
                courses.map((course) =>{
                  const {id} = course
                return(
                  <Col className="ml-auto mr-auto" md="8" key = {id}>
                    <Card 
                        style={{width: '20rem'}}
                        className='pointer'
                        onClick={()=> goToLesson(id)}
                    >
                        <CardImg top src="" alt="..." />
                        <CardBody>
                            <CardText>{course.title}</CardText>
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

export default Courses;
