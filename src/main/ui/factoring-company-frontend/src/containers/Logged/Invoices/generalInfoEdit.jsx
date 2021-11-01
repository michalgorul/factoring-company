import { useState } from "react";
import { useHistory, useParams } from "react-router";
import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import { useEffect } from "react";
import { errorToast, infoToast } from "../../../components/toast/makeToast";
import { Spinner } from "react-bootstrap";


const GeneralInfoEdit = () => {
    
    const [invoiceNumber, setInvoiceNumber] = useState('');
    const [creationDate, setCreationDate] = useState('');
    const [saleDate, setSaleDate] = useState('');
    const [paymentDeadline, setPaymentDeadline] = useState('');
    const [toPay, setToPay] = useState('');
    const [paid, setPaid] = useState('');
    const [remarks, setRemarks] = useState('');
    const [status, setStatus] = useState('')
    const [sellerId, setSellerId] = useState('')
    const [customerId, setCustomerId] = useState('')
    const [paymentTypeId, setPaymentTypeId] = useState('')
    const [currencyId, setCurrencyId] = useState('')
    const [isPendingN, setIsPendingN] = useState('')


    const { id } = useParams();
    const { data: invoice, error, isPending } = useFetchWithToken(`${config.API_URL}/api/invoice/${id}`);
    const history = useHistory();

    useEffect(() => {
        getInvoiceGeneralInfo();
    }, [invoice])


    const getInvoiceGeneralInfo = () => {

        if(invoice){
            setCreationDate(invoice.creationDate);
            setSaleDate(invoice.saleDate);
            setPaymentDeadline(invoice.paymentDeadline);
            setToPay(invoice.toPay);
            setPaid(invoice.paid);
            setRemarks(invoice.remarks);
            setStatus(invoice.status);
            setSellerId(invoice.sellerId);
            setCustomerId(invoice.customerId);
            setPaymentTypeId(invoice.paymentTypeId);
            setCurrencyId(invoice.currencyId);
        }
    }

    const handleSubmit = (e) => {
        e.preventDefault();

        const invoice = { creationDate, saleDate, paymentDeadline, toPay, paid, 
            remarks, status, sellerId, customerId, paymentTypeId, currencyId };

        setIsPendingN(true);

        fetch(`${config.API_URL}/api/user/invoice/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(invoice)
        })
            .then((response) => {
                setIsPendingN(false);
                if (response.ok) {
                    history.push('/user/invoices');
                    window.location.reload();
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
    }

    return (
        <div>
            {isPending && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
            {error && <div>{error}</div>}
            {invoice && (
                <div class="container-fluid h-custom">
                    <div class="row d-flex justify-content-start align-items-center">
                        <div class="col-md-8 col-lg-8 col-xl-6">
                            <form onSubmit={handleSubmit}>
                                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                                    <p class="lead fw-normal mt-2 mb-3 display-4">Edit General Invoice Information</p>

                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" required value={creationDate} onChange={(e) => setCreationDate(e.target.value)} />
                                    <label class="form-label">Creation date</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="email" class="form-control form-control-lg"
                                        placeholder="Enter password" required value={saleDate} onChange={(e) => setSaleDate(e.target.value)} />
                                    <label class="form-label">Sale date</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" required value={paymentDeadline} onChange={(e) => setPaymentDeadline(e.target.value)} />
                                    <label class="form-label">Payment deadline</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" required value={toPay} onChange={(e) => setToPay(e.target.value)} />
                                    <label class="form-label">To pay</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" value={paid} onChange={(e) => setPaid(e.target.value)} />
                                    <label class="form-label">Paid</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" value={remarks} onChange={(e) => setRemarks(e.target.value)} />
                                    <label class="form-label">Remarks</label>
                                </div>

                                <div class="form-floating form-outline mb-3">
                                    <input type="text" class="form-control form-control-lg"
                                        placeholder="Enter password" value={status} onChange={(e) => setStatus(e.target.value)} />
                                    <label class="form-label">Status</label>
                                </div>

                                <div class="mb-3">
                                    {!isPendingN && <button class="btn btn-primary rounded-pill btn-lg">Edit invoice info</button>}
                                    {isPendingN && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing invoice info...</button>}
                                </div>

                            </form>
                        </div>
                    </div>
                </div>)}
        </div>
    );
}

export default GeneralInfoEdit;