import { useHistory } from "react-router-dom";
import useFetch from "../../../components/useFetch/useFetch";
import Select from 'react-select'
import countryList from 'react-select-country-list'
import { useState, useEffect, useMemo } from "react";
import { Spinner } from 'react-bootstrap';
import PhoneInput from 'react-phone-number-input'
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
toast.configure();

const ProfileEdit = () => {
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [email, setEmail] = useState('');
    const [country, setCountry] = useState('');
    const [countryInList, setCountryInList] = useState('');
    const [city, setCity] = useState('');
    const [street, setStreet] = useState('');
    const [postalCode, setPostalCode] = useState('');
    const [phone, setPhone] = useState('');
    const [isPendingN, setIsPendingN] = useState(false);
    const options = useMemo(() => countryList().getData(), [])

    const {data: company, error, isPending} = useFetch('http://localhost:8000/company');
    const history = useHistory();

    useEffect(() => {
        getProfile();
      }, [])

    function getProfile() {
        fetch('http://localhost:8000/user')
        .then((result) => {
          result.json()
          .then((response) => {
            setFirstName(response.firstName)
            setLastName(response.lastName)
            setEmail(response.email)
            setCountryInList(response.country)
            setCity(response.city)
            setStreet(response.street)
            setPostalCode(response.postalCode)
            setPhone(response.phone)
          })
        })
      }

      const handleSubmit = (e) => {
        e.preventDefault();

        const profile = {firstName, lastName, email, country, city, street, postalCode, phone};

        setIsPendingN(true);

        fetch('http://localhost:8000/user', {
            method: 'POST',
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(profile)
        })
        .then(() => {
            setIsPendingN(false);
            history.push('/user/profile');
        })
        .then( () => {
            toast.info('Company info was updated', {
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
        }); 
    }

    const changeHandler = country => {
        setCountryInList(country)
        setCountry(country.label)
      }

      
    return ( 
        <div>
            {isPending && isPendingN && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div>}
            {error && <div>{error}</div>}
            {company && (
            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-start align-items-center">
                    <div class="col-md-8 col-lg-8 col-xl-6">
                        <form onSubmit={handleSubmit}>
                        <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                            <p class="lead fw-normal mt-2 mb-3 display-4">Edit Profile</p>

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
                            <input type="email" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={email} onChange={(e) => setEmail(e.target.value)} />
                            <label class="form-label">Email</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                        <Select className="" required options={options} value={countryInList} onChange={changeHandler} />
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
                            placeholder="Enter password"  value={postalCode} onChange={(e) => setPostalCode(e.target.value)} />
                            <label class="form-label">Postal code</label>
                        </div>

                        <div class="form-floating form-outline form-control form-control-lg mb-3">
                            <PhoneInput class="form-control form-control-lg"
                            placeholder="Phone number" required value={phone} onChange={setPhone}/>
                        </div>

                        <div class="mb-3">
                            {!isPending && <button class="btn btn-primary rounded-pill btn-lg">Edit Profile</button>}
                            {isPending && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing profile...</button>}
                        </div>
                            
                        </form>
                    </div>
                </div>
            </div>)}
        </div>
     );
}
 
export default ProfileEdit;