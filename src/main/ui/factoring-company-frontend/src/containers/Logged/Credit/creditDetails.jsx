import {useHistory, useParams} from "react-router-dom";
import {Spinner} from 'react-bootstrap';
import config from "../../../services/config";
import useFetchWithToken from "../../../services/useFetchWithToken";
import axios from "axios";
import {infoToast} from "../../../components/toast/makeToast";

const CreditDetails = () => {
    const {id} = useParams();
    const {data: credit, errorC, isPendingC} = useFetchWithToken(`${config.API_URL}/api/credit/${id}`);
    const {data: user, error: errorU, isPending: isPendingU} = useFetchWithToken(`${config.API_URL}/api/user/current`);
    const history = useHistory();
    const handleSigning = () => {
        let tempCreditNumber = credit.creditNumber.replaceAll('/', ',');
        axios
            .get(config.API_URL + `/api/credit/document/${tempCreditNumber}`, {
                responseType: "blob",
                headers: {
                    "Authorization": `Bearer ${localStorage.getItem("token")}`
                }
            })
            .then(response => {
                const file = new Blob([response.data], {type: 'application/pdf'});
                const fileURL = URL.createObjectURL(file);
                let a = document.createElement('a');
                a.href = fileURL;
                a.download = user.firstName + '_' + user.lastName + '_' + credit.creditNumber;
                a.click();
            });
    }

    const handleRemoving = () => {
        fetch(`${config.API_URL}/api/credit/${id}`, {
            method: 'DELETE',
            headers: {
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            }
        })
            .then(() => {
                history.push('/user/credit');
            })
            .then(() => {
                infoToast('Credit was removed')
            })
    }

    const displayButtons = (credit) => {
        if (credit && credit.status === 'processing') {
            return (
                <div className="container">
                    <div className="row align-items-start">
                        <div className="mt-3 col-12 col-lg-6 text-center">
                            <button className="btn btn-lg btn-primary rounded-pill" onClick={handleSigning}>Sign document</button>
                        </div>
                    </div>
                </div>
            )
        } else if (credit && credit.status === 'funded') {
            return (
                <div className="container">
                    <div className="row align-items-start">
                        <div className="mt-3 col-12 col-lg-6 text-center">
                            <button className="btn btn-lg btn-primary rounded-pill" onClick={handleRemoving}>Remove credit
                            </button>
                        </div>
                    </div>
                </div>
            )
        }
    }

    return (
        <div className="">
            {isPendingC && isPendingU &&
            <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary"/></div>}
            {errorC && <div>{errorC}</div>}
            {errorU && <div>{errorU}</div>}
            {credit && user && (
                <article className="mt-2 ms-3">
                    <div className="media align-items-center py-1">
                        <div className="media-body ml-4">
                            <h4 className="display-3">Credit details</h4>
                        </div>
                    </div>
                    <h5 className="mt-4 mb-3">General</h5>
                    <div className="container">
                        <div className="row align-items-start ms-2">
                            <div className="col-6 col-lg-3">
                                <ul className="list-group list-group-flush">
                                    <li className="list-group-item list-group-item-action fw-bold">Remaining to be paid:</li>
                                    <li className="list-group-item list-group-item-action fw-bold">Loan amount:</li>
                                    <li className="list-group-item list-group-item-action fw-bold">Next payment:</li>
                                    <li className="list-group-item list-group-item-action fw-bold">Remaining installments:</li>
                                    <li className="list-group-item list-group-item-action fw-bold">Account balance:</li>
                                </ul>
                            </div>
                            <div className="col-6 col-lg-3">
                                <ul className="list-group list-group-flush">
                                    <li className="list-group-item list-group-item-action">{credit.leftToPay}</li>
                                    <li className="list-group-item list-group-item-action">{credit.amount}</li>
                                    <li className="list-group-item list-group-item-action">{credit.nextPayment}</li>
                                    <li className="list-group-item list-group-item-action">{credit.installments}</li>
                                    <li className="list-group-item list-group-item-action">{credit.balance}</li>
                                </ul>
                            </div>
                        </div>
                    </div>


                    <h5 className="mt-4 mb-3">Other</h5>
                    <div className="container">
                        <div className="row align-items-start ms-2">
                            <div className="col-6 col-lg-3">
                                <ul className="list-group list-group-flush">
                                    <li className="list-group-item list-group-item-action fw-bold">Rate of interest:</li>
                                    <li className="list-group-item list-group-item-action fw-bold">Next payment date:</li>
                                    <li className="list-group-item list-group-item-action fw-bold">Creation Date:</li>
                                    <li className="list-group-item list-group-item-action fw-bold">Last installment Date:</li>
                                </ul>
                            </div>
                            <div className="col-6 col-lg-3">
                                <ul className="list-group list-group-flush mb-3">
                                    <li className="list-group-item list-group-item-action">{credit.rateOfInterest + '%'}</li>
                                    <li className="list-group-item list-group-item-action">{credit.nextPaymentDate}</li>
                                    <li className="list-group-item list-group-item-action">{credit.creationDate}</li>
                                    <li className="list-group-item list-group-item-action">{credit.lastInstallmentDate}</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    {displayButtons(credit)}

                </article>
            )}
        </div>
    );
}

export default CreditDetails;