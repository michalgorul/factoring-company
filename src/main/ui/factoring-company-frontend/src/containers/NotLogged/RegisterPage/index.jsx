import {Marginer} from '../../../components/marginer'
import RegisterImage from '../../../images/register.png'

const Register = () => {
    return ( 
        <div class="container-fluid h-custom">
            <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-9 col-lg-6 col-xl-5">
                <img src={RegisterImage} class="img-fluid mt-5" alt="Sample"/>
            </div>
            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                <form>
                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                    <p class="lead fw-normal mt-5 mb-5 me-3 display-3">Register</p>

                </div>

                <div class="form-outline form-floating mb-4">
                    <input type="name" class="form-control"
                    placeholder="Enter your first and last name" />
                    <label class="form-label">Username</label>
                </div>

                <div class="form-outline form-floating mb-4">
                    <input type="phone" class="form-control"
                    placeholder="Enter your preferred phone number" />
                    <label class="form-label">Email address</label>
                </div>

                <div class="form-floating form-outline mb-3">
                    <input type="password" class="form-control" placeholder="Enter password" />
                    <label class="form-label" for="form3Example4">Create Password</label>
                </div>

                <div class="form-floating form-outline mb-3">
                    <input type="password" class="form-control" placeholder="Enter password" />
                    <label class="form-label" for="form3Example4">Confirm Password</label>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <div class="form-check mb-0">
                    <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3" />
                    <label class="form-check-label" for="form2Example3">
                      I agree all statements in <a href="/terms-of-use" class="text-decoration-none">Terms of use</a>
                    </label>
                    </div>
                </div>

                <div class="text-center text-lg-start mt-4 pt-2">
                    <button type="button" class="btn btn-primary btn-lg rounded-pill"
                    style={{paddingLeft: "2.5rem", paddingRight: "2.5rem"}}>Register</button>
                    <p class="small fw-bold mt-2 pt-1 mb-0">Already have an account? <a href="/login"
                        class="link-primary text-decoration-none">Sign In</a></p>
                </div>
                    <Marginer direction="vertical" margin={20} />
                </form>
            </div>
            </div>
        </div>
     );
}
 
export default Register;