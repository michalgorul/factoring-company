import {useHistory} from "react-router-dom";
import {useEffect, useState} from "react";
import {Spinner} from 'react-bootstrap';
import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import {updateWithToken} from "../../../services/useUpdateWithToken";
import {infoToast} from "../../../components/toast/makeToast";

const EditBankAccount = () => {
    const [bankName, setBankName] = useState('');
    const [bankAccountNumber, setNumber] = useState('');
    const [bankSwift, setSwift] = useState('');
    const [isPendingN, setIsPendingN] = useState(false);

    const history = useHistory();

    const { data: bank, error, isPending } = useFetchWithToken(`${config.API_URL}/api/bank-account/current`);

    useEffect(() => {
        getBankAccountInfo();
    }, [bank]);

    const getBankAccountInfo = () => {
        if(bank){
            setBankName(bank.bankName);
            setNumber(bank.bankAccountNumber);
            setSwift(bank.bankSwift);
        }
    }


    const handleSubmit = (e) => {
        e.preventDefault();
        const account = { bankName, bankAccountNumber, bankSwift };
        setIsPendingN(true);

        updateWithToken(`${config.API_URL}/api/bank-account/current`, account)
        .then(() => {
            setIsPendingN(false);
            history.push('/user/profile');
        })
        .then(() => {
            infoToast('Your comapny was updated');
        })
        .catch(err => {
            console.error(err);
        })
        console.log(account);
    }

    return (
        <div>
            {isPending && isPendingN && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
            {error && <div>{error}</div>}
            {bank && (
                <div class="container-fluid h-custom">
                    <div class="row d-flex justify-content-start align-items-center">
                        <div class="col-md-8 col-lg-8 col-xl-6">
                            <form onSubmit={handleSubmit}>
                                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                                    <p class="lead fw-normal mt-2 mb-3 display-4">Edit Bank Account</p>

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
                                    {!isPending && <button class="btn btn-primary rounded-pill btn-lg">Edit Bank Account</button>}
                                    {isPending && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing account...</button>}
                                </div>

                            </form>
                        </div>
                    </div>
                </div>)}
        </div>
    );
}

export default EditBankAccount;