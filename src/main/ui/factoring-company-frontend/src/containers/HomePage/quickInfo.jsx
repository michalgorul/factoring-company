import React, { Component } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import Support from '../../images/check.png'
//<div>Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
import Bulb from '../../images/bulb.png'
//<div>Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
import Basket from '../../images/basket.png'
//<div>Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
import styled from "styled-components";

const LogoImage = styled.div`
  width: ${({ size }) => (size ? size + "px" : "5em")};
  height: ${({ size }) => (size ? size + "px" : "5em")};
  display: block;
  margin-left: auto;
  margin-right: auto;
  img {
    width: 100%;
    height: 100%;
  }
`;

export class QuickInfo extends Component {
    render() {
        return ( 
            <div class="container-lg">
                <div class="text-center">
                    <h2>In short</h2>
                    <p class="lead text-muted">Get peace of mind when you partner with BlueVine</p>
                </div>

                <div class="row my-5 align-items-center justify-content-center container-fluid">
                    <div class="col-10 col-lg-4">
                        <div class="card border-0 h-10">
                        <LogoImage>
                            <img src={Basket} class="card-img-top mt-4 mb-2" alt="..."></img>
                        </LogoImage>
                            <div class="card-body text-center py-4 mt-2">
                                <h4 class="card-title">Easy to get started</h4>
                                <p class="lead card-subtitle mb-4">BlueVine makes business funding quick and painless. Apply online and get approved in as fast as 5 minutes.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-10 col-lg-4">
                        <div class="card border-0">
                        <LogoImage>
                            <img src={Bulb} class="card-img-top mt-4 mb-2" alt="..."></img>
                        </LogoImage>
                            <div class="card-body text-center py-4 mt-2">
                                <h4 class="card-title">As you wish</h4>
                                <p class="lead card-subtitle mb-4">Use your available credit line when you want, for any business need. Enjoy no long-term contracts or prepayment fees.</p>
                            </div>
                        </div>
                    </div> 
                    <div class="col-10 col-lg-4">
                        <div class="card border-0">
                        <LogoImage>
                            <img src={Support} class="card-img-top mt-4 mb-5" alt="..."></img>
                        </LogoImage>
                            <div class="card-body text-center py-4 mt-2">
                                <h4 class="card-title">Dedicated support</h4>
                                <p class="lead card-subtitle mb-4">Our team is available to walk you through the process and help you obtain the funds you need.</p>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
        );
    }
}

export default QuickInfo;