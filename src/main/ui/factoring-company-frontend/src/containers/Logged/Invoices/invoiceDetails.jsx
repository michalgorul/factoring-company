import { useHistory, useParams } from "react-router-dom";
import { Spinner, Modal, Button } from 'react-bootstrap';
import { useState } from "react";
import { errorToast, infoToast } from "../../../components/toast/makeToast";
import useFetchWithTokenInvoice from "../../../services/invoiceService";
import { useEffect } from "react";
import config from "../../../services/config";
import axios from 'axios'

const InvoiceDetails = () => {
	const { id } = useParams();
	const { invoice, errorI, isPendingI,
		customer, errorC, isPendingC,
		paymentType, errorP, isPendingP,
		currency, errorCu, isPendingCu,
		seller, errorS, isPendingS } = useFetchWithTokenInvoice(id);

	const history = useHistory();

	const [show, setShow] = useState(false);

	useEffect(() => {
		if (invoice) {
			invoice.creationDate = new Date(invoice.creationDate).toDateString();
			invoice.paymentDeadline = new Date(invoice.paymentDeadline).toDateString();
			invoice.saleDate = new Date(invoice.saleDate).toDateString();
		}

	}, [invoice]);


	const handleDeleteRequest = () => {
		fetch(`${config.API_URL}/api/invoice/${invoice.id}`, {
			method: 'DELETE',
			headers: {
				"Authorization": `Bearer ${localStorage.getItem("token")}`
			}
		})
			.then((response) => {
				if(response.ok){
					history.push('/user/invoices');
				}
				else{
					handleClose();

				}
				return response;
			})
			.then((response) => {
				if(response.ok){
					infoToast('Invoice was deleted');

				}
				else{
					errorToast('Invoice was not deleted');
				}

			})
	}

	const handleDelete = () => {
		setShow(true);
	}

	const handleShowPdf = () => {
		try {
			axios
			  .get(config.API_URL + `/api/invoice/pdf/${id}`, {
				responseType: "blob",
				headers: {
					"Authorization": `Bearer ${localStorage.getItem("token")}`
				}
			  })
			  .then((response) => {
				//Create a Blob from the PDF Stream
				const file = new Blob([response.data], { type: "application/pdf" });
				//Build a URL from the file
				const fileURL = URL.createObjectURL(file);
				//Open the URL on new Window
				 const pdfWindow = window.open();
				 pdfWindow.location.href = fileURL;            
			  })
			  .catch((error) => {
				console.log(error);
			  });
		  } catch (error) {
			return { error };
		  }
	}
	const handleClose = () => setShow(false);
	const handleShow = () => setShow(true);

	return (
		<div className="">
			{isPendingI && isPendingC && isPendingCu && isPendingP && isPendingS &&
				<div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
			{errorI && <div>{errorI}</div>}
			{errorC && <div>{errorC}</div>}
			{errorCu && <div>{errorCu}</div>}
			{errorP && <div>{errorP}</div>}
			{errorS && <div>{errorS}</div>}
			{invoice && customer && seller && paymentType && currency && (
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
									<li class="list-group-item list-group-item-action fw-bold">Status:</li>
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
									<li class="list-group-item list-group-item-action">{invoice.status}</li>
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
									<li class="list-group-item list-group-item-action">{currency.name}</li>
									<li class="list-group-item list-group-item-action">{currency.code}</li>
									<li class="list-group-item list-group-item-action">{paymentType.name}</li>
								</ul>
							</div>
						</div>
					</div>


					<div class="alert clearfix mt-2">
						<button type="button" class="btn btn-lg me-3 mb-3 btn-primary rounded-pill float-center" onClick={handleDelete}>Delete Invoice</button>
						<a href={"edit/general-info/" + id} class="btn btn-lg mb-3 btn-primary rounded-pill float-center me-3">Edit general info</a>
						<button type="button" class="btn btn-lg me-3 mb-3 btn-primary rounded-pill float-center" onClick={handleShowPdf}>Generate PDF</button>
					</div>
					<Modal show={show} onHide={handleClose}>
						<Modal.Header closeButton>
							<Modal.Title>Invoice deletion</Modal.Title>
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