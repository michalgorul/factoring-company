import { useEffect } from "react";
import { useState } from "react";
import { Spinner } from "react-bootstrap";
import { useHistory, useParams } from "react-router";
import { errorToast, infoToast } from "../../../components/toast/makeToast";
import useFetchWithTokenPayment from "../../../services/paymentService";
import config from "../../../services/config";
import useFetchWithToken from "../../../services/useFetchWithToken";
import Select from 'react-select'


const PaymentInfoEdit = () => {

    const [currencyName, setCurrencyName] = useState('Dollar');
    const [paymentTypeName, setPaymentTypeName] = useState('');
    const [isPendingI, setIsPendingI] = useState(false)
    const [isPendingN, setIsPendingN] = useState(false)

    const { id } = useParams();
    const history = useHistory();
    const { paymentType, errorP, isPendingP,
        currency, errorCu, isPendingCu } = useFetchWithTokenPayment(id);

    const { data: currencies, errorCu: errorCur, isPendingCu: isPendingCur} = useFetchWithToken(`${config.API_URL}/api/currency`);
    const { data: paymentTypes, errorP: errorPt, isPendingP: isPendingPt} = useFetchWithToken(`${config.API_URL}/api/payment-type`);

    const makeCurrencyOptions = (currencies) => {
        let currercyArray = [];

        if (currencies) {
            currencies.forEach((item) => {
                let it = {
                    value: item.code.toString(),
                    label: item.name.toString(),
                };
                currercyArray.push(it);
            })
        }
        return currercyArray;
    }

    const makePaymentOptions = (paymentTypes) => {
        let paymentArray = [];

        if (paymentTypes) {
            paymentTypes.forEach((item) => {
                let it = {
                    value: item.paymentTypeName.toString(),
                    label: item.paymentTypeName.toString(),
                };
                paymentArray.push(it);
            })
        }
        return paymentArray;
    }

    const optionsCurrencies = makeCurrencyOptions(currencies);
    const optionsPaymentTypes = makePaymentOptions(paymentTypes);


   

    const handleSubmit = (e) => {
        e.preventDefault();

        const payment = { currencyName, paymentTypeName };

        setIsPendingN(true);

        fetch(`${config.API_URL}/api/invoice/payment/currency/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(payment)
        })
            .then((response) => {
                setIsPendingN(false);
                if (response.ok) {
                    history.push(`/user/invoices/${id}`);
                    return response;
                }
                else {
                    return response;
                }
            })
            .then((response) => {
                if (response.ok) {
                    infoToast('Invoice payment info was updated');
                }
                else {
                    errorToast('Please fill all fields');
                }
            })
            .catch(err => {
                console.error(err);
            })

    }

    return (
        <div>
            {isPendingCu && isPendingCur && isPendingP && isPendingPt && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
            {errorCu && <div>{errorCu}</div>}
            {errorCur && <div>{errorCur}</div>}
            {errorP && <div>{errorP}</div>}
            {errorPt && <div>{errorPt}</div>}
            {currency && paymentType &&(
                <div class="container-fluid h-custom">
                    <div class="row d-flex justify-content-start align-items-center">
                        <div class="col-md-8 col-lg-8 col-xl-6">
                            <form onSubmit={handleSubmit}>
                                <div class="d-flex mb-3 flex-row align-items-center justify-content-center justify-content-lg-start">
                                    <p class="lead fw-normal mt-2 mb-3 display-4">Edit Payment Information</p>

                                </div>

                                <div>
                                    <p className="h4">Current:</p>
                                    <ul class="list-group list-group-flush mb-5">
                                        <li class="list-group-item">Currency: <b>{currency.name} </b></li>
                                        <li class="list-group-item">Payment type: <b> {paymentType.paymentTypeName} </b></li>
                                    </ul>
                                </div>

                                <div class="row mb-5">
                                    <div class="col-12 mb-4">
                                        <span style={{ marginLeft: "5px" }} className="h5">Currency</span>
                                        <Select onChange={(e) => setCurrencyName(e.label)} options={optionsCurrencies} />
                                    </div>

                                    <div class="col-12">
                                        <span style={{ marginLeft: "5px" }} className="h5">Payment type</span>
                                        <Select onChange={(e) => setPaymentTypeName(e.value)} options={optionsPaymentTypes} />
                                    </div>
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