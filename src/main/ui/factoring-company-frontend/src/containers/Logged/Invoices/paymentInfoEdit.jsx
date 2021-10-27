import { useEffect } from "react";
import { useState } from "react";
import { Spinner } from "react-bootstrap";
import { useHistory, useParams } from "react-router";
import { errorToast, infoToast } from "../../../components/toast/makeToast";
import useFetchWithTokenPayment from "../../../services/paymentService";
import config from "../../../services/config";

const PaymentInfoEdit = () => {

    const [name, setName] = useState('');
    const [code, setCode] = useState('');
    const [paymentTypeName, setPaymentTypeName] = useState('');
    const [, setIsPendingN] = useState('')

    const { id } = useParams();
    const { invoice, errorI, isPendingI,
        paymentType, errorP, isPendingP,
        currency, errorCu, isPendingCu } = useFetchWithTokenPayment(id);
    const history = useHistory();

    useEffect(() => {
        getInfo();
    }, [invoice, currency, paymentType])

    const getInfo = () => {

        if (invoice && currency && paymentType) {
            setName(currency.name);
            setCode(currency.code);
            setPaymentTypeName(paymentType.paymentTypeName);
        }
    }

    const handleSubmit = (e) => {
        e.preventDefault();

        const currency = { name, code };

        setIsPendingN(true);

        fetch(`${config.API_URL}/api/currency/${invoice.currencyId}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(currency)
        })
            .then((response) => {
                setIsPendingN(false);
                if (response.ok) {
                    history.goBack();
                    return response;
                }
                else {
                    return response;
                }
            })
            .then((response) => {
                if (response.ok) {
                    infoToast('Invoice general info was updated');
                }
                else {
                    errorToast('Some of inputs were incorrect');
                }
            })
            .catch(err => {
                console.error(err);
            })

            fetch(`${config.API_URL}/api/payment-type/${invoice.paymentTypeId}?paymentTypeName=${paymentTypeName}`, {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": `Bearer ${localStorage.getItem("token")}`
                }
            });
    }

    return (
        <div>
            {isPendingI && isPendingCu && isPendingP && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
            {errorI && <div>{errorI}</div>}
            {errorCu && <div>{errorCu}</div>}
            {errorP && <div>{errorP}</div>}
            {invoice && paymentTypeName && currency && (
                <div class="container-fluid h-custom">
                    <div class="row d-flex justify-content-start align-items-center">
                        <div class="col-md-8 col-lg-8 col-xl-6">
                            <form onSubmit={handleSubmit}>
                                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                                    <p class="lead fw-normal mt-2 mb-3 display-4">Edit Payment Information</p>

                                </div>

                                <div class="form-outline form-floating mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter a valid email address" required value={name} onChange={(e) => setName(e.target.value)} />
                                    <label class="form-label">Currency name</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" required value={code} onChange={(e) => setCode(e.target.value)} />
                                    <label class="form-label">Currency code</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" required value={paymentTypeName} onChange={(e) => setPaymentTypeName(e.target.value)} />
                                    <label class="form-label">Payment type</label>
                                </div>


                                <div class="mb-3">
                                    {!isPendingI && <button class="btn btn-primary rounded-pill btn-lg">Edit payment info</button>}
                                    {isPendingI && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing payment info...</button>}
                                </div>

                            </form>
                        </div>
                    </div>
                </div>)}
        </div>
    );
}

export default PaymentInfoEdit;