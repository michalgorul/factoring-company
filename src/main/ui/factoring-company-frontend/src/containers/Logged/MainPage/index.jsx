import Image from '../../../images/6685.jpg';

const MainPageLoged = () => {
    return ( 
        <div class="container-lg">
            <div class="mt-5 row g-4 justify-content-center align-items-center">
                <div class="col-md-5 text-center text-md-start">
                    <h1>
                        <div class="display-2">Welcome back!</div>
                        <div class="display-5 text-muted">Happy to see you</div>
                    </h1>
                    <p class="lead my-4 text-muted">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Omnis dolore temporibus reprehenderit culpa nulla labore aperiam recusandae eos tempora.</p>
                    <a href="/user/invoices" class="btn btn-primary btn-lg rounded-pill">Invoices</a>
                </div>
                <div class="col-md-6 text-center d-none d-md-block">
                    <span data-bs-placement="bottom" title="Welcome">
						<img src={Image} class="img-fluid" alt="welcome"/>
					</span>
                </div>
            </div>
        </div> 
     );
}
 
export default MainPageLoged;