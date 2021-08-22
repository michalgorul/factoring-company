import { useHistory } from "react-router-dom";
import useFetch from "../../../components/useFetch/useFetch";
import Select from 'react-select'
import countryList from 'react-select-country-list'
import { useState, useEffect, useMemo } from "react";
import { Spinner } from 'react-bootstrap';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
toast.configure();

const CompanyEdit = () => {
    const [companyName, setCompanyName] = useState('');
    const [country, setCountry] = useState('');
    const [countryInList, setCountryInList] = useState('');
    const [city, setCity] = useState('');
    const [street, setStreet] = useState('');
    const [postalCode, setPostalCode] = useState('');
    const [nip, setNip] = useState('');
    const [regon, setRegon] = useState('');
    const [isPendingN, setIsPendingN] = useState(false);
    const options = useMemo(() => countryList().getData(), [])

    const {data: company, error, isPending} = useFetch('http://localhost:8000/company');
    const history = useHistory();

    useEffect(() => {
        getCompany();
      }, [])

    function getCompany() {
        fetch('http://localhost:8000/company/')
        .then((result) => {
          result.json()
          .then((response) => {
            const countryObject = {value: countryList().getValue(response.country), label: response.country };
            setCompanyName(response.companyName)
            setCountryInList(countryObject)
            setCity(response.city)
            setStreet(response.street)
            setPostalCode(response.postalCode)
            setNip(response.nip)
            setRegon(response.regon)
          })
        })
      }

      const handleSubmit = (e) => {
        e.preventDefault();

        const company = {companyName, country, city, street, postalCode, nip, regon};

        setIsPendingN(true);

        fetch('http://localhost:8000/company', {
            method: 'POST',
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(company)
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
                            <p class="lead fw-normal mt-2 mb-3 display-4">Edit Company</p>

                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={companyName} onChange={(e) => setCompanyName(e.target.value)} />
                            <label class="form-label">Company name</label>
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

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password"  value={nip} onChange={(e) => setNip(e.target.value)} />
                            <label class="form-label">Nip</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password"  value={regon} onChange={(e) => setRegon(e.target.value)} />
                            <label class="form-label">Regon</label>
                        </div>

                        <div class="mb-3">
                            {!isPending && <button class="btn btn-primary rounded-pill btn-lg">Edit Company</button>}
                            {isPending && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing company...</button>}
                        </div>
                            
                        </form>
                    </div>
                </div>
            </div>)}
        </div>
     );
}
 
export default CompanyEdit;