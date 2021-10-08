import useFetch from "../../../components/useFetch/useFetch";
import { useHistory, useParams } from "react-router-dom";
import { Button, Modal, Spinner } from 'react-bootstrap';
import { useState } from "react";
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import { infoToast } from "../../../components/toast/makeToast";
import { useEffect } from "react";

toast.configure();

const CustomerDetails = () => {
    const { id } = useParams();

    const [customer, setCustomer] = useState(null);
    const [company, setCompany] = useState(null);
    const [companyId, setCompanyId] = useState(0);

    useEffect(() => {
        fetch(`${config.API_URL}/api/customer/${id}`, {
            method: 'GET',
            headers: {
                "Authorization": `Bearer ${localStorage.getItem('token')}`
            }
        })
            .then(res => {
                if (!res.ok) {
                    throw Error("could not fetch the data for that resource");
                }
                return res.json();
            })
            .then(data => {
                setCustomer(data);
                return data;

            })
            .then(data => {
                fetch(`${config.API_URL}/api/company/${data.companyId}`, {
                    method: 'GET',
                    headers: {
                        "Authorization": `Bearer ${localStorage.getItem('token')}`
                    }
                })
                    .then(res => {
                        return res.json();
                    })
                    .then(data => {
                        setCompany(data);
                        setCompanyId(data.id);
                    })
                    .catch(err => {
                        if (err.name === "AbortError") {
                            console.log('fetch aborted');
                        }
                    })
            })
            .catch(err => {
                if (err.name === "AbortError") {
                    console.log('fetch aborted');
                }
            })
    }, [])

    const history = useHistory();

    const [show, setShow] = useState(false);

    const handleClose = () => setShow(false);

    const handleDeleteRequest = () => {
        fetch(`${config.API_URL}/api/customer/${id}`, {
            method: 'DELETE',
            headers: {
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            }
        })
            .then(() => {
                history.push('/user/customers');
            })
            .then(() => {
                infoToast('Customer was deleted')
            })
    }

    const handleDelete = () => {
        setShow(true);
    }

    const showCompanyDetails = (comapny) => {
        if (comapny != null) {
            return (
                <ul class="list-group list-group-flush mb-3">
                    <li class="list-group-item list-group-item-action">{company.companyName}</li>
                    <li class="list-group-item list-group-item-action">{company.country}</li>
                    <li class="list-group-item list-group-item-action">{company.city}</li>
                    <li class="list-group-item list-group-item-action">{company.street}</li>
                    <li class="list-group-item list-group-item-action">{company.postalCode}</li>
                    <li class="list-group-item list-group-item-action">{company.nip}</li>
                    <li class="list-group-item list-group-item-action">{company.regon}</li>
                </ul>)
        }
        else {
            return (
                <ul class="list-group list-group-flush mb-3">
                    <li class="list-group-item list-group-item-action"> - </li>
                    <li class="list-group-item list-group-item-action"> - </li>
                    <li class="list-group-item list-group-item-action"> - </li>
                    <li class="list-group-item list-group-item-action"> - </li>
                    <li class="list-group-item list-group-item-action"> - </li>
                    <li class="list-group-item list-group-item-action"> - </li>
                    <li class="list-group-item list-group-item-action"> - </li>
                </ul>)
        }

    };
    return (
        <div className="">
            {customer && (
                <article class="mt-5 ms-3">
                    <div class="media align-items-center py-3">
                        <div class="media-body ml-4">
                            <h4 class="display-3">{customer.firstName + ' ' + customer.lastName}</h4>
                        </div>
                    </div>
                    <h5 class="mt-4 mb-3">Details</h5>
                    <div class="container">
                        <div class="row align-items-start ms-2">
                            <div class="col-3">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item list-group-item-action fw-bold">Email:</li>
                                    <li class="list-group-item list-group-item-action fw-bold">Country:</li>
                                    <li class="list-group-item list-group-item-action fw-bold">City:</li>
                                    <li class="list-group-item list-group-item-action fw-bold">Street:</li>
                                    <li class="list-group-item list-group-item-action fw-bold">Postal code:</li>
                                    <li class="list-group-item list-group-item-action fw-bold">Phone number:</li>
                                </ul>
                            </div>
                            <div class="col-3">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item list-group-item-action">{customer.email}</li>
                                    <li class="list-group-item list-group-item-action">{customer.country}</li>
                                    <li class="list-group-item list-group-item-action">{customer.city}</li>
                                    <li class="list-group-item list-group-item-action">{customer.street}</li>
                                    <li class="list-group-item list-group-item-action">{customer.postalCode}</li>
                                    <li class="list-group-item list-group-item-action">{customer.phone}</li>
                                </ul>
                            </div>
                        </div>
                    </div>


                    <h5 class="mt-4 mb-3">Company</h5>
                    <div class="container">
                        <div class="row align-items-start ms-2">
                            <div class="col-3">
                                <ul class="list-group list-group-flush">
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
                                {showCompanyDetails(company)}
                            </div>
                        </div>
                    </div>


                    <div class="alert clearfix mt-2">
                        <button type="button" class="btn btn-lg me-3 mb-3 btn-primary rounded-pill float-center" onClick={handleDelete}>Delete customer</button>
                        <a href={"/user/customers/edit/" + id} class="btn btn-lg mb-3 btn-primary rounded-pill float-center me-3">Edit customer</a>
                        <a href={`/user/profile/company/edit/${companyId}`} class="btn btn-lg mb-3 btn-primary rounded-pill float-center">Edit company</a>
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

// const BackButton = styled.div`
//    font-size: 5rem;
//    z-index: 1;
//    cursor: pointer;
//    color: #0d6efd;
// `

export default CustomerDetails;