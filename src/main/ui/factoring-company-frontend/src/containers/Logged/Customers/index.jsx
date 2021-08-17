import useFetch from "../../../components/useFetch/useFetch";
import CustomerList from "./customerList";
import { Spinner } from 'react-bootstrap';

const Customers = () => {
const { error, isPending, data: customers } = useFetch('http://localhost:8000/customers')

    return ( 
<>
        <div class="text-centered display-3 d-flex justify-content-center">Customer List</div>

        <div class="alert  clearfix">
            <button type="button" class="btn btn-primary btn-lg float-end rounded-pill">
            Add New
            </button>
        </div>
        <ol class="list-group list-group-numbered list-group-flush">
                { error &&<> <div class="alert alert-warning fs-3" role="alert">{error} </div> 
                            <a class="text-decoration-none ms-3 fs-3" href="" onClick={() => {window.location.href="/something"}}> Click to refresh </a></>}
                { isPending && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div> }
                { customers && <CustomerList customers={customers} /> }   
        </ol>
        </>
     );
}
 
export default Customers;