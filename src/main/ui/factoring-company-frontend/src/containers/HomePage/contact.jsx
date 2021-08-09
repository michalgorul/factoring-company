import React from 'react';
import { ChatLeftDotsFill, EnvelopeFill, PersonFill, QuestionCircle } from "react-bootstrap-icons"
import {Form, Button, Col, Row, InputGroup, FormControl} from 'react-bootstrap';
import { Marginer } from '../../components/marginer';

const Contact = () => {
    return ( 

        <div class="container-lg">
                <div class="text-center">
                <Marginer direction="vertical" margin={35} />
                    <h2>Get in Touch</h2>
                    <p class="lead">Questions to ask? Fill out the form to contact me directly...</p>
                </div>
                <div class="row justify-content-center my-5">
                <Form>
  <Row className="align-items-center">
    <Col xs="auto">
      <Form.Label htmlFor="inlineFormInput" visuallyHidden>
        Name
      </Form.Label>
      <Form.Control
        className="mb-2"
        id="inlineFormInput"
        placeholder="Jane Doe"
      />
    </Col>
    <Col xs="auto">
      <Form.Label htmlFor="inlineFormInputGroup" visuallyHidden>
        Username
      </Form.Label>
      <InputGroup className="mb-2">
        <InputGroup.Text>@</InputGroup.Text>
        <FormControl id="inlineFormInputGroup" placeholder="Username" />
      </InputGroup>
    </Col>
    <Col xs="auto">
      <Form.Check
        type="checkbox"
        id="autoSizingCheck"
        className="mb-2"
        label="Remember me"
      />
    </Col>
    <Col xs="auto">
      <Button type="submit" className="mb-2">
        Submit
      </Button>
    </Col>
  </Row>
</Form>
                </div>
            </div>
  
     );
}
 
export default Contact;