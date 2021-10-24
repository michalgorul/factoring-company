import { useHistory } from "react-router-dom";
import { useEffect, useState } from "react";
import { Spinner } from 'react-bootstrap';
import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import { updateWithToken } from "../../../services/useUpdateWithToken";
import { errorToast, infoToast } from "../../../components/toast/makeToast";

const CreateBankAccount = () => {
    const [bankName, setBankName] = useState('');
    const [bankAccountNumber, setNumber] = useState('');
    const [bankSwift, setSwift] = useState('');
    const [isPendingN, setIsPendingN] = useState(false);
    const history = useHistory();

    const handleSubmit = (e) => {
        e.preventDefault();
        const account = { bankName, bankAccountNumber, bankSwift };
        setIsPendingN(true);

        fetch(`${config.API_URL}/api/bank-account/current`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(account)
        })
            .then((response) => {
                setIsPendingN(false);
                if (response.ok) {
                    history.push('/user/profile');
                    window.location.reload();
                    return response;
                }
                else {
                    return response;
                }
            })
            .then((response) => {
                if (response.ok) {
                    infoToast('Your Bank account was added')
                }
                else {
                    errorToast('Some of inputs were incorrect');
                }
            })
            .catch(err => {
                console.error(err);
            })
    }

    return (
        <div>
                <div class="container-fluid h-custom">
                    <div class="row d-flex justify-content-start align-items-center">
                        <div class="col-md-8 col-lg-8 col-xl-6">
                            <form onSubmit={handleSubmit}>
                                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                                    <p class="lead fw-normal mt-2 mb-3 display-4">Add your Bank Account</p>

                                </div>
                                <div class="form-outline form-floating mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter a valid email address" required value={bankName} onChange={(e) => setBankName(e.target.value)} />
                                    <label class="form-label">Bank name</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" required value={bankAccountNumber} onChange={(e) => setNumber(e.target.value)} />
                                    <label class="form-label">Bank account number</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" required value={bankSwift} onChange={(e) => setSwift(e.target.value)} />
                                    <label class="form-label">SWIFT</label>
                                </div>

                                <div class="mb-3">
                                    {!isPendingN && <button class="btn btn-primary rounded-pill btn-lg" type="submit">Add your Bank Account</button>}
                                    {isPendingN && <button class="btn btn-primary rounded-pill btn-lg" disabled>Adding account...</button>}
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
        </div>
    );
}

export default CreateBankAccount;