import { Marginer } from '../../../components/marginer'
import LoginImage from '../../../images/login.png'
import Copyright from '../HomePage/copyright'

const Login = () => {
    return ( 
        <div class="container-fluid h-custom">
            <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-9 col-lg-6 col-xl-5">
                <img src={LoginImage} class="img-fluid mt-5" alt="Sample image"/>
            </div>
            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                <form>
                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                    <p class="lead fw-normal mt-5 mb-5 me-3 display-3">Sign in</p>

                </div>

                <div class="form-outline form-floating mb-4">
                    <input type="email" class="form-control form-control-lg"
                    placeholder="Enter a valid email address" />
                    <label class="form-label">Email address</label>
                </div>

                <div class="form-floating form-outline mb-3">
                    <input type="password" class="form-control form-control-lg" placeholder="Enter password" />
                    <label class="form-label" for="form3Example4">Password</label>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <div class="form-check mb-0">
                    <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3" />
                    <label class="form-check-label" for="form2Example3">Remember me</label>
                    </div>
                    <a href="#!" class="text-body">Forgot password?</a>
                </div>

                <div class="text-center text-lg-start mt-4 pt-2">
                    <a href="/user/admin" type="button" class="btn btn-primary btn-lg rounded-pill"
                    style={{paddingLeft: "2.5rem", paddingRight: "2.5rem"}}>Login</a>
                    <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? <a href="/register"
                        class="link-primary">Register</a></p>
                </div>
                    <Marginer direction="vertical" margin={20} />
                </form>
            </div>
            </div>
        </div>
     );
}
 
export default Login;