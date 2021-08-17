import useFetch from "../../../components/useFetch/useFetch";
import { useHistory, useParams } from "react-router-dom";
import { Spinner, Modal, Button } from 'react-bootstrap';
import { useState } from "react";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faChevronCircleLeft } from '@fortawesome/free-solid-svg-icons'
import styled from 'styled-components';

const CustomerDetails = () => {
    const { id } = useParams();
    const {data: customer, error, isPending} = useFetch('http://localhost:8000/customers/' + id);
    const history = useHistory();

    const [show, setShow] = useState(false);

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
  
    const handleDeleteRequest = () => {
        fetch('http://localhost:8000/customers/' + id, {
            method: 'DELETE'
        })
        .then(() => {
          history.push('/user/customers');
        })
    }

    const handleDelete = () =>{
        setShow(true);
    }

    return ( 
        <div className="">
        {isPending && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div>}
        {error && <div>{error}</div>}
        {customer && (
            <article class="mt-5 ms-5">
                <div class="container">
                    <div class="row justify-content-start">
                        <div class="col-8">
                        <h1 class="display-2 mb-5">{customer.firstName + ' ' + customer.lastName}</h1>
                            <p class="mb-2 fs-2">Company: <span class="fw-bold">{customer.companyName}</span></p>
                            <p class="mb-2 fs-2">Country: <span class="fw-bold">{customer.country}</span></p>
                            <p class="mb-2 fs-2">City: <span class="fw-bold">{customer.city}</span></p>
                            <p class="mb-2 fs-2">Street: <span class="fw-bold">{customer.street}</span></p>
                            <p class="mb-2 fs-2">Postal code: <span class="fw-bold">{customer.postalCode}</span></p>
                            <p class="mb-2 fs-2">Phone number: <span class="fw-bold">{customer.phone}</span></p>
                            <p class="mb-2 fs-2 mb-3">Blacklisted: <span class="fw-bold">{customer.blacklisted.toString()}</span></p>
                        </div>
                        <div class="col-2 my-auto">
                            <BackButton>
                                <FontAwesomeIcon icon={faChevronCircleLeft} onClick={history.goBack} />
                            </BackButton>
                        </div>
                    </div>
                </div>
                

                <div class="alert clearfix mt-2">
                    <button type="button" class="btn btn-lg  btn-primary rounded-pill float-center" onClick={handleDelete}>Delete customer</button>
                    <button type="button" class="btn btn-lg ms-4 btn-primary rounded-pill float-center">Edit customer</button>
                </div>
                <Modal show={show} onHide={handleClose}>
                    <Modal.Header closeButton>
                    <Modal.Title>Customer deletion</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>Are you sure you want to remove {<span class="fw-bold">{customer.firstName + ' ' + customer.lastName}</span>} from your customer list?</Modal.Body>
                    <Modal.Footer>
                    <Button variant="secondary" onClick={handleClose}>
                        Cancel
                    </Button>
                    <Button variant="primary" onClick={handleDeleteRequest}>
                        Delete
                    </Button>
                    </Modal.Footer>
                </Modal>
            </article> 
        )}
    </div>
     );
     
}

const BackButton = styled.div`
   font-size: 5rem;
   z-index: 1;
   cursor: pointer;
   color: #0d6efd;
`
 
export default CustomerDetails;