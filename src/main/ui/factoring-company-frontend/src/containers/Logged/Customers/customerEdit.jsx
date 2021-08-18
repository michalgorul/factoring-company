import { useHistory, useParams } from "react-router-dom";
import useFetch from "../../../components/useFetch/useFetch";
import { useState } from "react";
import { Spinner } from 'react-bootstrap';
import PhoneInput from 'react-phone-number-input'


const CustomerEdit = () => {

    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [companyName, setCompanyName] = useState('');
    const [country, setCountry] = useState('');
    const [city, setCity] = useState('');
    const [street, setStreet] = useState('');
    const [postalCode, setPostalCode] = useState('');
    const [phone, setPhone] = useState('');
    const [blacklisted, setBlacklisted] = useState('false');
    const [isPendingN, setIsPendingN] = useState(false);
    
    const { id } = useParams();
    const {data: editCustomer, error, isPending} = useFetch('http://localhost:8000/customers/' + id);
    const history = useHistory();

    const handleSubmit = (e) => {
        e.preventDefault();

        const customer = { firstName, lastName, companyName, country, city, street, postalCode, phone, blacklisted};

        setIsPendingN(true);

        fetch('http://localhost:8000/customers', {
            method: 'PUT',
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(customer)
        })
        .then(() => {
            setIsPendingN(false);
            history.push('/user/customers');
        });
    }


    return ( 
        <div>
            {isPending && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div>}
            {error && <div>{error}</div>}
            {editCustomer && (
            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-start align-items-center">
                    <div class="col-md-8 col-lg-8 col-xl-6">
                        <form onSubmit={handleSubmit}>
                        <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                            <p class="lead fw-normal mt-2 mb-3 display-4">Edit Customer</p>

                        </div>
                        <div class="form-outline form-floating mb-3">
                            <input type="text" class="form-control form-control-lg"
                            
                            placeholder="Enter a valid email address" required value={firstName} onChange={(e) => setFirstName(e.target.value)} />
                            <label class="form-label">First name</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={lastName} onChange={(e) => setLastName(e.target.value)} />
                            <label class="form-label">Last name</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={companyName} onChange={(e) => setCompanyName(e.target.value)} />
                            <label class="form-label">Company name</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={country} onChange={(e) => setCountry(e.target.value)} />
                            <label class="form-label">Country</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={city} onChange={(e) => setCity(e.target.value)} />
                            <label class="form-label">City</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={street} onChange={(e) => setStreet(e.target.value)} />
                            <label class="form-label">Street</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={postalCode} onChange={(e) => setPostalCode(e.target.value)} />
                            <label class="form-label">Postal code</label>
                        </div>

                        <div class="form-floating form-outline form-control form-control-lg mb-3">
                            <PhoneInput class="form-control form-control-lg"
                            placeholder="Phone number" value={phone} onChange={setPhone}/>
                        </div>
                        <div class="mb-3">
                            {!isPending && <button class="btn btn-primary rounded-pill btn-lg">Edit Customer</button>}
                            {isPending && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing customer...</button>}
                        </div>
                            
                        </form>
                    </div>
                </div>
            </div>)}
        </div>
        
     );
}
 
export default CustomerEdit;