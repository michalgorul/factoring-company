import { useMemo, useState } from "react";
import { useHistory } from "react-router-dom";
import 'react-phone-number-input/style.css'
import PhoneInput from 'react-phone-number-input'
import Select from 'react-select'
import countryList from 'react-select-country-list'
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { infoToast, warningToast } from "../../../components/toast/makeToast";
import config from "../../../services/config";

toast.configure();

const CustomerCreate = () => {

    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [companyName, setCompanyName] = useState('');
    const [country, setCountry] = useState('');
    const [countryInList, setCountryInList] = useState('');
    const [city, setCity] = useState('');
    const [street, setStreet] = useState('');
    const [postalCode, setPostalCode] = useState('');
    const [phone, setPhone] = useState('');
    const [blacklisted, setBlacklisted] = useState(false);
    const [isPending, setIsPending] = useState(false);
    const history = useHistory();
    const options = useMemo(() => countryList().getData(), [])

    const handleSubmit = (e) => {
        e.preventDefault();
        setBlacklisted(false);

        const customer = { firstName, lastName, companyName, country, city, street, postalCode, phone, blacklisted };
        setIsPending(true);

        fetch(`${config.API_URL}/api/customer`, {
            method: 'POST',
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(customer)
        })
            .then((response) => {
                setIsPending(false);
                if (response.ok) {
                    history.push('/user/customers');
                    return response;
                }
                else {
                    return response
                }
            })
            .then((response) => {
                if (response.ok) {
                    infoToast('Customer was added')
                }
                else {
                    warningToast('Some of inputs are incorrect')
                }
            })
    }
    const changeHandler = country => {
        setCountryInList(country)
        setCountry(country.label)
    }

    return (
        <>

            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-start align-items-center">
                    <div class="col-md-8 col-lg-8 col-xl-6">
                        <form onSubmit={handleSubmit}>
                            <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                                <p class="lead fw-normal mt-2 mb-3 display-4">New Customer</p>

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
                                <Select className="" options={options} value={countryInList} onChange={changeHandler} />
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
                                    placeholder="Phone number" value={phone} onChange={setPhone} />
                            </div>
                            <div class="mb-3">
                                {!isPending && <button class="btn btn-primary rounded-pill btn-lg">Add Customer</button>}
                                {isPending && <button class="btn btn-primary rounded-pill btn-lg" disabled>Adding blog...</button>}
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </>
    );
}

export default CustomerCreate;