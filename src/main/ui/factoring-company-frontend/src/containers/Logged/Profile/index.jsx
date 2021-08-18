import useFetch from "../../../components/useFetch/useFetch";
import { Spinner } from 'react-bootstrap';

const Profile = () => {

	const {data: user, error, isPending} = useFetch('http://localhost:8000/user/');
	const {data: company} = useFetch('http://localhost:8000/company/');

    return ( 
			<>

			{isPending && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div>}
        {error && <div>{error}</div>}
        {user && company && (
        <div class="container flex-grow-1 container-p-y">

            <div class="media align-items-center py-3">
              <div class="media-body ml-4">
                <h4 class="font-weight-bold display-2">{user.firstName + ' ' + user.lastName}</h4>
                <h4 class="lead display-5">{user.email}</h4>
              </div>
            </div>

            <div class="row my-5 align-items-center justify-content-center container-fluid shadow p-3 mb-5 rounded">
            <div class="col-9 col-lg-4">
                    <div class="card border-1">
                        <div class="card-body text-center py-4 flex-fill">
                            <h4 class="card-title">Invoices</h4>
                            <p class="card-text mx-5 text-muted fs-4">100</p>
                        </div>
                    </div>
                </div> 

                <div class="col-9 col-lg-4">
                    <div class="card border-1">
                        <div class="card-body text-center py-4 flex-fill">
                            <h4 class="card-title">Customers</h4>
                            <p class="card-text mx-5 text-muted fs-4">100</p>
                        </div>
                    </div>
                </div> 

                <div class="col-9 col-lg-4">
                    <div class="card border-1">
                        <div class="card-body text-center py-4 flex-fill">
                            <h4 class="card-title">Comission</h4>
                            <p class="card-text mx-5 text-muted fs-4">10000$</p>
                        </div>
                    </div>
                </div> 
            </div>


								<h5 class="mt-4 mb-3">Address</h5>
                <div class="container">
									<div class="row align-items-start ms-3">
										<div class="col-3">
											<ul class="list-group list-group-flush">
												<li class="list-group-item list-group-item-action fw-bold">Country:</li>
												<li class="list-group-item list-group-item-action fw-bold">City:</li>
												<li class="list-group-item list-group-item-action fw-bold">Street:</li>
												<li class="list-group-item list-group-item-action fw-bold">Postal code:</li>
											</ul>
										</div>
											<div class="col-3">
												<ul class="list-group list-group-flush">
													<li class="list-group-item list-group-item-action">{user.country}</li>
													<li class="list-group-item list-group-item-action">{user.city}</li>
													<li class="list-group-item list-group-item-action">{user.street}</li>
													<li class="list-group-item list-group-item-action">{user.postalCode}</li>
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
										<div class="col-3">
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

                
              </div>)}
</>
     );
    }
 
export default Profile;