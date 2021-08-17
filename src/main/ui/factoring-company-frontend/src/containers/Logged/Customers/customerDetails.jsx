import useFetch from "../../../components/useFetch/useFetch";
import { useHistory, useParams } from "react-router-dom";
import { Spinner } from 'react-bootstrap';


const CustomerDetails = () => {
    const { id } = useParams();
    const {data: customer, error, isPending} = useFetch('http://localhost:8000/customers/' + id);
    const history = useHistory();
  
    const handleDelete = () => {
        fetch('http://localhost:8000/customers/' + id, {
            method: 'DELETE'
        })
        .then(() => {
          history.push('/');
        })
    }
    return ( 
        <div className="">
        {isPending && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div>}
        {error && <div>{error}</div>}
        {customer && (
            <article class="mt-5 ms-5">
                <h1 class="display-2 mb-5">{customer.firstName + ' ' + customer.lastName}</h1>
                <p class="mb-2 fs-2">Company: <span class="fw-bold">{customer.companyName}</span></p>
                <p class="mb-2 fs-2">Country: <span class="fw-bold">{customer.country}</span></p>
                <p class="mb-2 fs-2">City: <span class="fw-bold">{customer.city}</span></p>
                <p class="mb-2 fs-2">Street: <span class="fw-bold">{customer.street}</span></p>
                <p class="mb-2 fs-2">Postal code: <span class="fw-bold">{customer.postalCode}</span></p>
                <p class="mb-2 fs-2">Phone number: <span class="fw-bold">{customer.phone}</span></p>
                <p class="mb-2 fs-2 mb-3">Blacklisted: <span class="fw-bold">{customer.blacklisted.toString()}</span></p>

                <div class="alert clearfix mt-2">
                    <button type="button" class="btn btn-lg  btn-primary rounded-pill float-center" onClick={handleDelete}>Delete customer</button>
                    <button type="button" class="btn btn-lg ms-4 btn-primary rounded-pill float-center">Edit customer</button>
                </div>
            </article>
        )}
    </div>
     );
}
 
export default CustomerDetails;