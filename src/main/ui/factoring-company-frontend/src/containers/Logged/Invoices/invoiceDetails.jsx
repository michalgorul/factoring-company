import useFetch from "../../../components/useFetch/useFetch";
import { useHistory, useParams } from "react-router-dom";
import { Spinner, Modal, Button } from 'react-bootstrap';
import { useState } from "react";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faChevronCircleLeft } from '@fortawesome/free-solid-svg-icons'
import styled from 'styled-components';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
toast.configure();

const InvoiceDetails = () => {
    const { id } = useParams();
    const {data: invoice, errorI, isPendingI} = useFetch('http://localhost:8000/invoices-funded/' + id);
    const {data: customer, errorC, isPendingC} = useFetch('http://localhost:8000/customers/' + id);
    const {data: payment, errorP, isPendingP} = useFetch('http://localhost:8000/payment/' + 1);
    const {data: seller, errorS, isPendingS} = useFetch('http://localhost:8000/seller/' + 1);
    const history = useHistory();

    const [show, setShow] = useState(false);

    const handleDeleteRequest = () => {
        fetch('http://localhost:8000/invoices-funded/' + id, {
            method: 'DELETE'
        })
        .then(() => {
          history.push('/user/invoices');
        })
        .then( () => {
            toast.info('Invoice was deleted', {
                position: "bottom-right",
                autoClose: 5000,
                hideProgressBar: false,
                closeOnClick: true,
                pauseOnHover: true,
                draggable: true,
                progress: undefined,
                transition: Zoom,
                className:"text-white bg-primary",
                });
        })
    }
    const handleDelete = () =>{
        setShow(true);
    }
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    return ( 
        <div className="">
        {isPendingI && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div>}
        {errorI && <div>{errorI}</div>}
        {invoice && customer && payment && seller &&(
            <article class="mt-2 ms-3">
                <div class="media align-items-center py-1">
              <div class="media-body ml-4">
                <h4 class="display-3">Invoice details</h4>
              </div>
            </div>
                <h5 class="mt-4 mb-3">General</h5>
                <div class="container">
					<div class="row align-items-start ms-2">
						<div class="col-3">
							<ul class="list-group list-group-flush">
								<li class="list-group-item list-group-item-action fw-bold">Invoice number:</li>
								<li class="list-group-item list-group-item-action fw-bold">Creation date:</li>
								<li class="list-group-item list-group-item-action fw-bold">Sale date:</li>
								<li class="list-group-item list-group-item-action fw-bold">Payment deadline:</li>
								<li class="list-group-item list-group-item-action fw-bold">To pay:</li>
								<li class="list-group-item list-group-item-action fw-bold">Paid:</li>
								<li class="list-group-item list-group-item-action fw-bold">Remarks:</li>
							</ul>
						</div>
							<div class="col-3">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action">{invoice.invoiceNumber}</li>
									<li class="list-group-item list-group-item-action">{invoice.creationDate}</li>
									<li class="list-group-item list-group-item-action">{invoice.saleDate}</li>
									<li class="list-group-item list-group-item-action">{invoice.paymentDeadline}</li>
									<li class="list-group-item list-group-item-action">{invoice.toPay}</li>
									<li class="list-group-item list-group-item-action">{invoice.paid}</li>
									<li class="list-group-item list-group-item-action">{invoice.remarks}</li>
								</ul>
							</div>
					</div>
				</div>
              
                
				<h5 class="mt-4 mb-3">Seller Information</h5>
				<div class="container">
					<div class="row align-items-start ms-2">
						<div class="col-3">
							<ul class="list-group list-group-flush">
							    <li class="list-group-item list-group-item-action fw-bold">Seller name:</li>
							    <li class="list-group-item list-group-item-action fw-bold">Company name:</li>
								<li class="list-group-item list-group-item-action fw-bold">Country:</li>
								<li class="list-group-item list-group-item-action fw-bold">City:</li>
								<li class="list-group-item list-group-item-action fw-bold">Street:</li>
								<li class="list-group-item list-group-item-action fw-bold">Postal code:</li>
								<li class="list-group-item list-group-item-action fw-bold">NIP:</li>
								<li class="list-group-item list-group-item-action fw-bold">REGON:</li>
							</ul>
						</div>
							<div class="col-3">
								<ul class="list-group list-group-flush mb-3">
									<li class="list-group-item list-group-item-action">{seller.firstName + ' ' + seller.lastName}</li>
									<li class="list-group-item list-group-item-action">{seller.companyName}</li>
									<li class="list-group-item list-group-item-action">{seller.country}</li>
									<li class="list-group-item list-group-item-action">{seller.city}</li>
									<li class="list-group-item list-group-item-action">{seller.street}</li>
									<li class="list-group-item list-group-item-action">{seller.postalCode}</li>
									<li class="list-group-item list-group-item-action">{seller.nip}</li>
									<li class="list-group-item list-group-item-action">{seller.regon}</li>
								</ul>
							</div>
						</div>
					</div>

                <h5 class="mt-4 mb-3">Customer Information</h5>
				<div class="container">
					<div class="row align-items-start ms-2">
						<div class="col-3">
							<ul class="list-group list-group-flush">
                                <li class="list-group-item list-group-item-action fw-bold">Customer name:</li>
                                <li class="list-group-item list-group-item-action fw-bold">Customer email:</li>
                                <li class="list-group-item list-group-item-action fw-bold">Company name:</li>
                                <li class="list-group-item list-group-item-action fw-bold">Country:</li>
								<li class="list-group-item list-group-item-action fw-bold">City:</li>
								<li class="list-group-item list-group-item-action fw-bold">Street:</li>
								<li class="list-group-item list-group-item-action fw-bold">Postal code:</li>
								<li class="list-group-item list-group-item-action fw-bold">Phone number:</li>
							</ul>
						</div>
							<div class="col-3">
								<ul class="list-group list-group-flush mb-3">
                                    <li class="list-group-item list-group-item-action">{customer.firstName + ' ' + customer.lastName}</li>
                                    <li class="list-group-item list-group-item-action">{customer.email}</li>
                                    <li class="list-group-item list-group-item-action">{customer.companyName}</li>
                                    <li class="list-group-item list-group-item-action">{customer.country}</li>
                                    <li class="list-group-item list-group-item-action">{customer.city}</li>
									<li class="list-group-item list-group-item-action">{customer.street}</li>
									<li class="list-group-item list-group-item-action">{customer.postalCode}</li>
									<li class="list-group-item list-group-item-action">{customer.phone}</li>
								</ul>
							</div>
						</div>
					</div>

                <h5 class="mt-4 mb-3">Payment Information</h5>
				<div class="container">
					<div class="row align-items-start ms-2">
						<div class="col-3">
							<ul class="list-group list-group-flush">
                                <li class="list-group-item list-group-item-action fw-bold">Currency name:</li>
                                <li class="list-group-item list-group-item-action fw-bold">currency code:</li>
                                <li class="list-group-item list-group-item-action fw-bold">Payment type:</li>
							</ul>
						</div>
							<div class="col-3">
								<ul class="list-group list-group-flush mb-3">
                                    <li class="list-group-item list-group-item-action">{payment.name}</li>
									<li class="list-group-item list-group-item-action">{payment.code}</li>
									<li class="list-group-item list-group-item-action">{payment.paymentType}</li>
								</ul>
							</div>
						</div>
					</div>
                

                <div class="alert clearfix mt-2">
                    <button type="button" class="btn btn-lg me-3 mb-3 btn-primary rounded-pill float-center" onClick={handleDelete}>Delete Invoice</button>
                    <a href={"#"} class="btn btn-lg mb-3 btn-primary rounded-pill float-center me-3">Edit informations</a>
                    <a href={"#"} class="btn btn-lg mb-3 btn-primary rounded-pill float-center">Generate PDF</a>
                </div>
                <Modal show={show} onHide={handleClose}>
                    <Modal.Header closeButton>
                    <Modal.Title>Customer deletion</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>Are you sure you want to remove {<span class="fw-bold">{invoice.invoiceNumber}</span>} from your invoice list?</Modal.Body>
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
 
export default InvoiceDetails;