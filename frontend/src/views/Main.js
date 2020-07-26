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
import { BrowserRouter, Route, Redirect, Switch } from "react-router-dom";

// components
import IndexNavbar from "components/Navbars/IndexNavbar.js";
// pages
import Index from "views/Index.js";
import PhoneticGuide from "views/PhoneticGuide.js";
import Courses from "views/Courses.js";
import Auth from "views/Auth.js";
import Lessons from "views/Lessons.js";
import Phrases from "views/Phrases.js";

//context 
import {userContext} from '../context/userContext'

const Main = () =>{
  return(
  <>
    <userContext.Consumer>
      {(value) => (<IndexNavbar user={value.user}/>)}
    </userContext.Consumer>
  {/* <IndexNavbar/> */}
  <BrowserRouter>
    <Switch>
      <Route path="/index" render={(props) => <Index {...props} />} />
      <Route path="/phonetic-guide" render={(props) => <PhoneticGuide {...props} />} />
      <Route path="/courses/:courseId/:lessonId" render={(props) => <Phrases {...props} />} />
      <Route path="/courses/:courseId" render={(props) => <Lessons {...props} />} />
      <Route path="/courses" render={(props) => <Courses {...props} />} />
      <Route path="/auth/:token" render={(props) => {
        return(
          <userContext.Consumer>
            {(value) => (<Auth user={value} {...props}/>  )}
          </userContext.Consumer>
        )      
      }} />
      <Redirect to="/index" />
    </Switch>
  </BrowserRouter>
  </>
  )
}

export default Main


