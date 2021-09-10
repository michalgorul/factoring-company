import { Button, Modal, Form } from "react-bootstrap";
import { useState } from "react";
import { Folder, FolderPlus, StarFill } from "react-bootstrap-icons"
import styled from "styled-components";
import { useHistory } from "react-router-dom";
import config from "../../../services/config";
import { errorToast, infoToast, warningToast } from "../../../components/toast/makeToast";
import axios from "axios";
const https = require('https');
const Documents = () => {

  const [catalog, setCatalog] = useState('favourite');
  const [show, setShow] = useState(false);
  const [isPending, setIsPending] = useState(false);
  const [selectedFile, setSelectedFile] = useState(null);
  const history = useHistory();

  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);
  const handleSelect = (e) => setCatalog(e.target.value);



  // On file select (from the pop up)
  const handleChange = event => {

    // Update the state
    setSelectedFile(event.target.files[0]);

  };

  const handleSubmit = (e) => {

    // Create an object of formData
    const formData = new FormData();
    
    // Update the formData object
    formData.append(
      "myFile",
      selectedFile,
      selectedFile.name
    );
  
    // Details of the uploaded file
    console.log(selectedFile);
  

    if(selectedFile){
      e.preventDefault();

      setIsPending(true);
      const formData = new FormData();
      formData.append("file", selectedFile);

      const agent = new https.Agent({  
        rejectUnauthorized: false
      });

      let configAxios = {
        headers: {
          "Authorization": `Bearer ${localStorage.getItem("token")}`
        },
        httpsAgent: agent
      }

      axios.post(`${config.API_URL}/api/file?catalog=${catalog}`, formData, configAxios);

    //   fetch(`${config.API_URL}/api/file?catalog=${catalog}`, {
    //     method: 'POST',
    //     headers: {
    //       "Authorization": `Bearer ${localStorage.getItem("token")}`
    //     },
    //     body: formData
    //   })
    //     .then((response) => {
    //       setIsPending(false);
    //       if (response.ok) {
    //         history.push('/user/documents');
    //         return response;
    //       }
    //       else {
    //         return response
    //       }
    //     })
    //     .then((response) => {
    //       if (response.ok) {
    //         infoToast('File was uploaded')
    //       }
    //       else {
    //         errorToast('File was not uploaded')
    //       }
    //     })
    // }
    // else{
    //   warningToast('Please select file')
    }

  }

  return (
    <>
      <div class="media align-items-center py-3">
        <div class="media-body ml-4">
          <h4 class="font-weight-bold display-2">Your documents</h4>
          <button onClick={handleShow} class="btn btn-primary rounded-pill fs-4 float-end me-5">Add files + </button>
        </div>
      </div>

      <ul class="list-group list-group-flush me-4 fs-3 ms-3">
        <li class="list-group-item mt-3"><StarFill className="text-primary mb-4 me-3" />
          <Directory href="#">Favourite</Directory>
        </li>
        <li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" />
          <Directory href="#">Work</Directory>
        </li>
        <li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" />
          <Directory href="#">Bank documents</Directory>
        </li>
        <li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" />
          <Directory href="#">Tax forms</Directory>
        </li>
        <li class="list-group-item mt-3"><FolderPlus className="text-primary mb-4 me-3" />
          <Directory href="#">Factoring Company documents</Directory>
        </li>
      </ul>


      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Upload files</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          Select catalog name
          <Form.Select aria-label="Default select example" onChange={handleSelect}>
            <option value="favourite">Favourite</option>
            <option value="work">Work</option>
            <option value="bank">Bank documents</option>
            <option value="tax">Tax forms</option>
            <option value="fc">Factoring Company documents</option>
          </Form.Select>
          <br />
          <Form.Group id="formFile" controlId="formFile" className="mb-3">
            <Form.Label>Choose file to upload</Form.Label>
            <Form.Control id="formFile" type="file" onChange={handleChange} />
          </Form.Group>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={handleClose}>
            Cancel
          </Button>
          <Button variant="primary" onClick={handleSubmit}>
            Upload
          </Button>
        </Modal.Footer>
      </Modal>

    </>
  );
}

const Directory = styled.a`
  position: relative;
  display: inline-block;
  overflow: hidden;
  background: linear-gradient(to right, #0d6efd, #0d6efd 50%, black 50%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-size: 200% 100%;
  background-position: 100%;
  transition: background-position 275ms ease;
  text-decoration: none; // text decorations are clipped in WebKit browsers
  &:hover {
    background-position: 0 100%;
  }
`

export default Documents;