import { useHistory } from "react-router-dom";
import Select from 'react-select'
import countryList from 'react-select-country-list'
import { useState, useEffect, useMemo } from "react";
import { Spinner } from 'react-bootstrap';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import useUpdateWithToken from "../../../services/useUpdateWithToken";
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

    const {data: company, error, isPending} = useFetchWithToken(`${config.API_URL}/api/company/current`);
    const history = useHistory();

    useEffect(() => {
        getCompanyInfo();
      }, [company])

    const getCompanyInfo = () => {
        if(company){
        const countryObject = {value: countryList().getValue(company.country), label: company.country };
        setCompanyName(company.companyName)
        setCountryInList(countryObject)
        setCity(company.city)
        setStreet(company.street)
        setPostalCode(company.postalCode)
        setNip(company.nip)
        setRegon(company.regon)
        }
    } 

      const handleSubmit = (e) => {
        e.preventDefault();

        const company = {companyName, country, city, street, postalCode, nip, regon};

        setIsPendingN(true);
        useUpdateWithToken(`${config.API_URL}/api/company/current`, company, 'Your company was updated');

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
                            placeholder="Enter password" required value={nip} onChange={(e) => setNip(e.target.value)} />
                            <label class="form-label">Nip</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={regon} onChange={(e) => setRegon(e.target.value)} />
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