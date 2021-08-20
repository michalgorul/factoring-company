import useFetch from "../../../components/useFetch/useFetch";
import CustomerList from "./customerList";
import { Spinner } from 'react-bootstrap';
import { useState, useEffect } from "react";

const Customers = () => {

    const { error, isPending, data: customers } = useFetch('http://localhost:8000/customers')
    const [searchTerm, setSearchTerm] = useState('');
    const [searchResults, setSearchResults] = useState([]);

    const handleChange = event => {
        setSearchTerm(event.target.value);
    };


    useEffect(() => {
        if(customers){
            const results = customers.filter(customer =>
                customer.firstName.toLowerCase().includes(searchTerm) ||
                customer.lastName.toLowerCase().includes(searchTerm)
              );
              setSearchResults(results);
        }

      }, [searchTerm, customers]);

        return ( 
        <>
        <div class="text-centered display-3 d-flex justify-content-center">Customer List</div>

        <div class="container mt-5 mb-2">
            <div class="row">
            <div class="form-outline form-floating mb-3 col-12 col-lg-6">
                <input type="text" class="form-control form-control-sm"
                placeholder="filter items" value={searchTerm} onChange={handleChange}/>
                <label class="form-label">Filter</label>
            </div>
            <div class="col-12 col-lg-6">
                <a href="/user/customers/create" class="btn btn-primary btn-lg float-end rounded-pill ">
                Add New
                </a>
            </div>        
            </div>
        </div>

        <ol class="list-group list-group-numbered list-group-flush">
                { error &&<> <div class="alert alert-warning fs-3" role="alert">{error} </div> 
                            <a class="text-decoration-none ms-3 fs-3" href="" onClick={() => {window.location.href="/something"}}> Click to refresh </a></>}
                { isPending && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div> }
                { customers && <CustomerList customers={searchResults} /> }   
        </ol>
        </>
     );
}
 
export default Customers;