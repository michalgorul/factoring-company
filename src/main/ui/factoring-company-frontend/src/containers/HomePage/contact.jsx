import React from 'react';
import {Form, Button, Col, Row, InputGroup, FormControl} from 'react-bootstrap';
import { EnvelopeFill, QuestionCircle } from 'react-bootstrap-icons';
import { Marginer } from '../../components/marginer';

const Contact = () => {
    return ( 
            <div class="container-lg">

                <div class="text-center">
                    <h2>Get in Touch</h2>
                    <p class="lead">Questions to ask? Fill out the form to contact me directly...</p>
                </div>
                <div class="row justify-content-center my-5">
                    <div class="col-lg-6">

                        <form>
                            <label for="email" class="form-label">Email address:</label>
                            <div class="input-group mb-4">
                                
                                <input type="text" id="email" class="form-control" placeholder="e.g. mario@example.com"></input>
                                <span class="input-group-text">
                                    <QuestionCircle className="text-muted" />
                                </span>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>
     );
}
 
export default Contact;