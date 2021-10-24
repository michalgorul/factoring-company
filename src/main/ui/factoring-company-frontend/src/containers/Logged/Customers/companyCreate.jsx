import { useHistory, useParams } from "react-router-dom";
import Select from 'react-select'
import countryList from 'react-select-country-list'
import {useEffect, useMemo, useState} from "react";
import {Spinner} from 'react-bootstrap';
import 'react-toastify/dist/ReactToastify.css';
import config from "../../../services/config";
import {errorToast, infoToast} from "../../../components/toast/makeToast";

const CustomerCompanyCreate = () => {
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
    const { id } = useParams();
    let history = useHistory();


    const handleSubmit = (e) => {
        e.preventDefault();

        const company = { companyName, country, city, street, postalCode, nip, regon };
        setIsPendingN(true);

        fetch(`${config.API_URL}/api/company/customer/${id}`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(company)
        })
            .then((response) => {
                setIsPendingN(false);
                if (response.ok) {
                    history.goBack();
                    return response;
                }
                else {
                    return response
                }
            })
            .then((response) => {
                if (response.ok) {
                    infoToast('Company was updated')
                }
                else {
                    errorToast('Some of inputs were incorrect')
                }
            })
            .catch(err => {
                console.error(err);
            })
    }



    const changeHandler = country => {
        setCountryInList(country)
        setCountry(country.label)
    }


    return (
        <div>
                <div class="container-fluid h-custom">
                    <div class="row d-flex justify-content-start align-items-center">
                        <div class="col-md-8 col-lg-8 col-xl-6">
                            <form onSubmit={handleSubmit}>
                                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                                    <p class="lead fw-normal mt-2 mb-3 display-4">Add customer company</p>

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
                                        placeholder="Enter password" value={postalCode} onChange={(e) => setPostalCode(e.target.value)} />
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
                                    {!isPendingN && <button class="btn btn-primary rounded-pill btn-lg">Add customer company</button>}
                                    {isPendingN && <button class="btn btn-primary rounded-pill btn-lg" disabled>Adding company...</button>}
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
        </div>
    );
}

export default CustomerCompanyCreate;