import { EnvelopeFill, Facebook, Github, Google, HouseFill, Instagram, Linkedin, PrinterFill, TelephoneFill, Twitter } from "react-bootstrap-icons"
import styled from 'styled-components'
import { Marginer } from "../../components/marginer";

const Footer = () => {

    const FullWidth = styled.div`
    width: 100%;
    `;
    return ( 
        <FullWidth>
            <footer class="text-center text-lg-start bg-primary text-white">
            <div class="d-flex justify-content-center p-4 border-bottom">
                <div class="me-5 d-none d-lg-block">
                    <span>
                        <Marginer direction="horizontal" margin={200} />
                        Get connected with us on social networks:
                        <Marginer direction="horizontal" margin={200} />

                    </span>
                </div>

                <div>
                <a href="https://www.facebook.com" class="me-4 text-reset">
                    <Facebook />
                </a>
                <a href="https://twitter.com/" class="me-4 text-reset">
                    <Twitter />
                </a>
                <a href="https://google.com/" class="me-4 text-reset">
                    <Google />
                </a>
                <a href="https://instagram.com/" class="me-4 text-reset">
                    <Instagram />
                </a>
                <a href="https://linkedin.com/" class="me-4 text-reset">
                    <Linkedin />
                </a>
                <a href="https://github.com/" class="me-4 text-reset">
                    <Github />
                </a>
                </div>
            </div>

            <section class="">
                <div class="container text-center text-md-start mt-5">
                <div class="row mt-3">
                    <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-4">
                        <i class="fas fa-gem me-3"></i>Factoring Company
                    </h6>
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolorem reprehenderit deleniti ratione necessitatibus, voluptate, earum, sapiente minima libero corporis beatae soluta quasi quibusdam sunt. Iste officia veniam illum esse et.
                        <div style={{fontSize:"12px"}} class="mt-2">    
                            <a href="http://www.freepik.com" class="text-white text-decoration-none">Graphics and icons designed by Freepik</a>
                        </div>
                    </p>
                    </div>

                    <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-4">
                        Products
                    </h6>
                    <p>
                        <a href="#!" class="text-reset text-decoration-none">Factoring</a>
                    </p>
                    <p>
                        <a href="#!" class="text-reset text-decoration-none">Payments</a>
                    </p>
                    <p>
                        <a href="#!" class="text-reset text-decoration-none">Banking</a>
                    </p>
                    <p>
                        <a href="#!" class="text-reset text-decoration-none">Credit</a>
                    </p>
                    </div>

                    <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-4">
                        Useful links
                    </h6>
                    <p>
                        <a href="#!" class="text-reset text-decoration-none">Pricing</a>
                    </p>
                    <p>
                        <a href="#!" class="text-reset text-decoration-none">Blog</a>
                    </p>
                    <p>
                        <a href="#!" class="text-reset text-decoration-none">Orders</a>
                    </p>
                    <p>
                        <a href="#!" class="text-reset text-decoration-none">Help</a>
                    </p>
                    </div>

                    <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                    <h6 class="text-uppercase fw-bold mb-4">
                        Contact
                    </h6>
                    <p><HouseFill className="me-2"/>New York, NY 10012, US</p>
                    <p><EnvelopeFill className="me-2"/>info@example.com</p>
                    <p><TelephoneFill className="me-2"/>+ 01 234 567 88</p>
                    <p><PrinterFill className="me-2"/>+ 01 234 567 89</p>
                    </div>
                </div>
                </div>
            </section>

            <div class="text-center p-4" style={{backgroundColor: "rgba(0, 17, 255, 0.9)"}}>
                © 2021 Copyright:    
                <span class="text-reset fw-bold ms-1">Factoring Company Inc.</span>
            </div>
            </footer>
        </FullWidth>
            
     );
}
 
export default Footer;