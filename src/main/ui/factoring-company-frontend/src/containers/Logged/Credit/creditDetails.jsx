import useFetch from "../../../components/useFetch/useFetch";
import { useParams } from "react-router-dom";
import { Spinner } from 'react-bootstrap';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import config from "../../../services/config";
import useFetchWithToken from "../../../services/useFetchWithToken";
toast.configure();

const CreditDetails = () => {
	const { id } = useParams();
	const { data: credit, errorC, isPendingC } = useFetchWithToken(`${config.API_URL}/api/credit/${id}`);


	return (
		<div className="">
			{isPendingC && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
			{errorC && <div>{errorC}</div>}
			{credit && (
				<article class="mt-2 ms-3">
					<div class="media align-items-center py-1">
						<div class="media-body ml-4">
							<h4 class="display-3">Credit details</h4>
						</div>
					</div>
					<h5 class="mt-4 mb-3">General</h5>
					<div class="container">
						<div class="row align-items-start ms-2">
							<div class="col-6 col-lg-3">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action fw-bold">Remaining to be paid:</li>
									<li class="list-group-item list-group-item-action fw-bold">Loan amount:</li>
									<li class="list-group-item list-group-item-action fw-bold">Next payment:</li>
									<li class="list-group-item list-group-item-action fw-bold">Number of remaining installments:</li>
									<li class="list-group-item list-group-item-action fw-bold">Account balance to be paid:</li>
								</ul>
							</div>
							<div class="col-6 col-lg-3">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action">{credit.leftToPay}</li>
									<li class="list-group-item list-group-item-action">{credit.amount}</li>
									<li class="list-group-item list-group-item-action">{credit.nextPayment}</li>
									<li class="list-group-item list-group-item-action">{credit.installments}</li>
									<li class="list-group-item list-group-item-action">{credit.balance}</li>
								</ul>
							</div>
						</div>
					</div>


					<h5 class="mt-4 mb-3">Other</h5>
					<div class="container">
						<div class="row align-items-start ms-2">
							<div class="col-6 col-lg-3">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action fw-bold">Rate of interest:</li>
									<li class="list-group-item list-group-item-action fw-bold">Next payment date:</li>
									<li class="list-group-item list-group-item-action fw-bold">Creation Date:</li>
									<li class="list-group-item list-group-item-action fw-bold">Last installment Date:</li>
								</ul>
							</div>
							<div class="col-6 col-lg-3">
								<ul class="list-group list-group-flush mb-3">
									<li class="list-group-item list-group-item-action">{credit.rateOfInterest + '%'}</li>
									<li class="list-group-item list-group-item-action">{credit.nextPaymentDate}</li>
									<li class="list-group-item list-group-item-action">{credit.creationDate}</li>
									<li class="list-group-item list-group-item-action">{credit.lastInstallmentDate}</li>
								</ul>
							</div>
						</div>
					</div>


					<div className="container mb-4">
						<div className="row align-items-start">
							<div class="mt-3 col-12 col-lg-3 text-center">
								<button class="btn btn-lg mb-3 btn-primary rounded-pill me-3">Overpay the loan</button>

							</div>

							<div class="mt-3 col-12 col-lg-3 text-center">
								<button class="btn btn-lg mb-3 btn-primary rounded-pill">Requests</button>

							</div>
						</div>
					</div>
				</article>
			)}
		</div>
	);
}

export default CreditDetails;