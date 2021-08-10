import React from 'react';
import { ChatRightDotsFill, EnvelopeFill, PersonFill, QuestionCircle } from "react-bootstrap-icons"
import {Tooltip, OverlayTrigger} from 'react-bootstrap';
import { Marginer } from '../../components/marginer';

const Contact = () => {

  const renderTooltipEmail = props => (
    <Tooltip {...props}>Enter an email address we can reply to.</Tooltip>
  );
  const renderTooltipName = props => (
    <Tooltip {...props}>Pretty self explanatory...</Tooltip>
  );

    return ( 

      <div class="container-lg">
        <div class="text-center">
        <Marginer direction="vertical" margin={35} />
            <h2>Get in Touch</h2>
            <p class="lead">Questions to ask? Fill out the form to contact me directly...</p>
        </div>
        <div class="row my-4 align-items-center justify-content-center container-fluid">
          <div class="col-11 col-lg-8">
            <form>
                <label for="email" class="form-label">Email address:</label>
                  <div class="input-group mb-4">
                      <span class="input-group-text">
                        <EnvelopeFill className="text-secondary" />
                      </span>
                      <input type="text" id="email" class="form-control" placeholder="e.g. john@xyz.com" />
                      <span class="input-group-text">
                      <OverlayTrigger placement="bottom" overlay={renderTooltipEmail}>
                        <QuestionCircle className="text-muted" />
                      </OverlayTrigger>
                      </span>
                  </div>
                <label for="name" class="form-label">Name:</label>
                  <div class="mb-4 input-group">
                      <span class="input-group-text">
                        <PersonFill className="text-secondary" />
                      </span>
                      <input type="text" id="name" class="form-control" placeholder="e.g. Mario" />
                      <span class="input-group-text">
                        <OverlayTrigger placement="bottom" overlay={renderTooltipName}>
                          <QuestionCircle className="text-muted" />
                        </OverlayTrigger>
                      </span>
                  </div>
                <label for="subject" class="form-label">What is your question about?</label>
                <div class="mb-4 input-group">
                    <span class="input-group-text">
                      <ChatRightDotsFill className="text-secondary" />
                    </span>
                    <select class="form-select" id="subject">
                      <option value="pricing" selected>Pricing query</option>
                      <option value="content">Content query</option>
                      <option value="other">Other query</option>
                    </select>
                </div>
                <div class="mb-4 mt-5 form-floating">
                    <textarea class="form-control" id="query" style={{height: "140px"}} placeholder="query"></textarea>
                    <label for="query">Your query...</label>
                </div>
                <div class="mb-4 text-center">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
          </div>
      </div>
  </div>


  
     );
}
 
export default Contact;