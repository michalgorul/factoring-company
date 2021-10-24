import { Button, Modal, Form, ProgressBar } from "react-bootstrap";
import { useEffect, useState } from "react";
import { Folder, FolderPlus, StarFill } from "react-bootstrap-icons"
import styled from "styled-components";
import { useHistory } from "react-router-dom";
import config from "../../../services/config";
import { errorToast, infoToast, warningToast } from "../../../components/toast/makeToast";
import { Marginer } from "../../../components/marginer";
const Documents = () => {

  const [catalog, setCatalog] = useState('favourite');
  const [show, setShow] = useState(false);
  const [isPending, setIsPending] = useState(false);
  const [selectedFile, setSelectedFile] = useState(null);
  const [availableSpace, setAvailableSpace] = useState(104857600);
  const [usedSpace, setUsedSpace] = useState(null);
  const [usedSpaceInProperFormat, setUsedSpaceInProperFormat] = useState(false);
  const [percentage, setPercentage] = useState(usedSpace / availableSpace * 100);
  const history = useHistory();

  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);
  const handleSelect = (e) => setCatalog(e.target.value);

  useEffect(() => {
    getUsedSpace();
    setPercentage(usedSpace / availableSpace * 100)
    handleButtonAvailability();
  }, [usedSpace])

  const formatBytes = (bytes, decimals = 2) => {
    if (bytes == 0) return '0 Bytes';
    const k = 1024;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    const i = Math.floor(Math.log(bytes) / Math.log(k));

    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
  }

  const getUsedSpace = () => {
    fetch(`${config.API_URL}/api/file/used`, {
      method: "GET",
      headers: {
        "Authorization": `Bearer ${localStorage.getItem("token")}`
      },
    })
      .then((response) => {
        if (!response.ok) {
          throw Error("could not fetch the data for that resource");
        }
        return response.text();
      })
      .then(data => {
        setUsedSpace(data);
      })
      .catch(err => {
        console.log(err.message);
      })
  }

  const handleButtonAvailability = () => {

    const button = document.querySelector('button')

    if(usedSpace > availableSpace){
      button.disabled = true;
    }
    else{
      button.disabled = false;
    }

  }

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

    if (selectedFile) {
      e.preventDefault();

      setIsPending(true);
      const formData = new FormData();
      formData.append("file", selectedFile);

      fetch(`${config.API_URL}/api/file?catalog=${catalog}`, {
        method: 'POST',
        headers: {
          "Authorization": `Bearer ${localStorage.getItem("token")}`
        },
        body: formData
      })
        .then((response) => {
          setIsPending(false);
          if (response.ok) {
            handleClose();
            return response;
          }
          else {
            return response
          }
        })
        .then((response) => {
          if (response.ok) {
            infoToast('File was uploaded')
          }
          else {
            errorToast('File was not uploaded')
          }
        })
    }
    else {
      warningToast('Please select file')
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

      <div className="bg-light me-3">
        <div className="container">
          <div className="col-12 col-lg-6">
            <div className="mb-1 mt-3" >
              <span className="display-6 fw-bold mb-2">{formatBytes(usedSpace)} </span> of <span className="display-6">{100} MB</span>
              <p class="fs-5 ms-2">Your available space for files</p>
            </div>
            <ProgressBar now={percentage} animated style={{ height: "5px" }} />
            <Marginer direction="vertical" margin={20} />
          </div>
        </div>
      </div>

      <ul class="list-group list-group-flush me-4 fs-3 ms-3">
        <li class="list-group-item mt-3"><StarFill className="text-primary mb-4 me-3" />
          <Directory href="/user/documents/list/favourite">Favourite</Directory>
        </li>
        <li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" />
          <Directory href="/user/documents/list/work">Work</Directory>
        </li>
        <li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" />
          <Directory href="/user/documents/list/bank">Bank documents</Directory>
        </li>
        <li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" />
          <Directory href="/user/documents/list/tax">Tax forms</Directory>
        </li>
        <li class="list-group-item mt-3"><FolderPlus className="text-primary mb-4 me-3" />
          <Directory href="/user/documents/list/factoring-company">Factoring Company documents</Directory>
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
          <Form.Group id="formFile" className="mb-3">
            <Form.Label>Choose file to upload</Form.Label>
            <Form.Control id="formFile" type="file" onChange={handleChange} />
            <Form.Text id="passwordHelpBlock" muted>
              Max file size: 5 MB
            </Form.Text>
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