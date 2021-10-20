import {Spinner} from 'react-bootstrap';
import config from "../../../services/config";
import useFetchWithToken from "../../../services/useFetchWithToken";


const Profile = () => {

	const { data: user, error: errorU, isPending: isPendingU } = useFetchWithToken(`${config.API_URL}/api/user/current`);
	const { data: company, error: errorC, isPending: isPendingC } = useFetchWithToken(`${config.API_URL}/api/company/current`);
	const { data: bank, error: errorB, isPending: isPendingB } = useFetchWithToken(`${config.API_URL}/api/bank-account/current`);

	return (
		<>

			{isPendingU && isPendingC && isPendingB && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
			{errorU && <div>{errorU}</div>}
			{errorC && <div>{errorC}</div>}
			{errorB && <div>{errorB}</div>}
			{user && company && bank && (
				<div class="container flex-grow-1 container-p-y">

					<div class="media align-items-center py-3">
						<div class="media-body ml-4">
							<h4 class="font-weight-bold display-2">Your profile</h4>
							<h4 class="display-3 mt-5">{user.firstName + ' ' + user.lastName}</h4>
							<h4 class="lead display-6">{user.email}</h4>
						</div>
					</div>


					<h5 class="mt-4 mb-3">Address & Phone</h5>
					<div class="container">
						<div class="row align-items-start ms-3">
							<div class="col-3">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action fw-bold">Country:</li>
									<li class="list-group-item list-group-item-action fw-bold">City:</li>
									<li class="list-group-item list-group-item-action fw-bold">Street:</li>
									<li class="list-group-item list-group-item-action fw-bold">Postal code:</li>
									<li class="list-group-item list-group-item-action fw-bold">Phone number:</li>
								</ul>
							</div>
							<div class="col-5">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action">{user.country}</li>
									<li class="list-group-item list-group-item-action">{user.city}</li>
									<li class="list-group-item list-group-item-action">{user.street}</li>
									<li class="list-group-item list-group-item-action">{user.postalCode}</li>
									<li class="list-group-item list-group-item-action">{user.phone}</li>
								</ul>
							</div>
						</div>
					</div>

					<h5 class="mt-4 mb-3">Bank account</h5>
					<div class="container">
						<div class="row align-items-start ms-3">
							<div class="col-3">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action fw-bold">Bank name:</li>
									<li class="list-group-item list-group-item-action fw-bold">Bank account number:</li>
									<li class="list-group-item list-group-item-action fw-bold">SWIFT:</li>
								</ul>
							</div>
							<div class="col-5">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action">{bank.bankName}</li>
									<li class="list-group-item list-group-item-action">{bank.bankAccountNumber}</li>
									<li class="list-group-item list-group-item-action">{bank.bankSwift}</li>
								</ul>
							</div>
						</div>
					</div>


					<h5 class="mt-4 mb-3">Company</h5>
					<div class="container">
						<div class="row align-items-start ms-3">
							<div class="col-3">
								<ul class="list-group list-group-flush">
									<li class="list-group-item list-group-item-action fw-bold">Company name:</li>
									<li class="list-group-item list-group-item-action fw-bold">Country:</li>
									<li class="list-group-item list-group-item-action fw-bold">City:</li>
									<li class="list-group-item list-group-item-action fw-bold">Street:</li>
									<li class="list-group-item list-group-item-action fw-bold">Postal code:</li>
									<li class="list-group-item list-group-item-action fw-bold">NIP:</li>
									<li class="list-group-item list-group-item-action fw-bold">REGON:</li>
								</ul>
							</div>
							<div class="col-5">
								<ul class="list-group list-group-flush mb-3">
									<li class="list-group-item list-group-item-action">{company.companyName}</li>
									<li class="list-group-item list-group-item-action">{company.country}</li>
									<li class="list-group-item list-group-item-action">{company.city}</li>
									<li class="list-group-item list-group-item-action">{company.street}</li>
									<li class="list-group-item list-group-item-action">{company.postalCode}</li>
									<li class="list-group-item list-group-item-action">{company.nip}</li>
									<li class="list-group-item list-group-item-action">{company.regon}</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="align-items-center mt-3 ms-5">
						<a href={"/user/profile/edit"} class="btn btn-lg mb-3 btn-primary rounded-pill me-4">Edit your profile</a>
						<a href={"/user/profile/company/edit/" + company.id} class="btn btn-lg mb-3 btn-primary rounded-pill me-4">Edit your company</a>
						<a href={"/user/bank-account/edit/" + bank.id} class="btn btn-lg mb-3 btn-primary rounded-pill ">Edit your bank account</a>
					</div>

				</div>)}
		</>
	);
}

export default Profile;