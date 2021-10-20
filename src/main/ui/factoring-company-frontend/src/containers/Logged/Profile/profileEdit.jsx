import { useHistory } from "react-router-dom";
import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import Select from 'react-select'
import countryList from 'react-select-country-list'
import { useEffect, useMemo, useState } from "react";
import { Spinner } from 'react-bootstrap';
import PhoneInput from 'react-phone-number-input'
import { updateWithToken } from "../../../services/useUpdateWithToken";
import { errorToast, infoToast } from "../../../components/toast/makeToast";


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

    const { data: user, error, isPending } = useFetchWithToken(`${config.API_URL}/api/user/current`);
    const history = useHistory();

    useEffect(() => {
        getProfileInfo();
    }, [user])


    const getProfileInfo = () => {
        if (user) {
            const countryObject = { value: countryList().getValue(user.country), label: user.country };
            setFirstName(user.firstName);
            setLastName(user.lastName);
            setEmail(user.email);
            setCountryInList(countryObject);
            setCountry(user.country);
            setCity(user.city);
            setStreet(user.street);
            setPostalCode(user.postalCode);
            setPhone(user.phone);
        }
    }

    const handleSubmit = (e) => {
        e.preventDefault();

        const profile = { firstName, lastName, email, country, city, street, postalCode, phone };

        setIsPendingN(true);

        fetch(`${config.API_URL}/api/user/current`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(profile)
        })
            .then((response) => {
                setIsPendingN(false);
                if (response.ok) {
                    history.push('/user/customers');
                    window.location.reload();
                    return response;
                }
                else {
                    return response;
                }
            })
            .then((response) => {
                if (response.ok) {
                    infoToast('Your profile was updated');
                }
                else {
                    errorToast('Some of inputs were incorrect');
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
            {isPending && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
            {error && <div>{error}</div>}
            {user && (
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
                                        placeholder="Enter password" value={postalCode} onChange={(e) => setPostalCode(e.target.value)} />
                                    <label class="form-label">Postal code</label>
                                </div>

                                <div class="form-floating form-outline form-control form-control-lg mb-3">
                                    <PhoneInput class="form-control form-control-lg"
                                        placeholder="Phone number" required value={phone} onChange={setPhone} />
                                </div>

                                <div class="mb-3">
                                    {!isPendingN && <button class="btn btn-primary rounded-pill btn-lg">Edit Profile</button>}
                                    {isPendingN && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing profile...</button>}
                                </div>

                            </form>
                        </div>
                    </div>
                </div>)}
        </div>
    );
}

export default ProfileEdit;