import React from "react";
import styled from "styled-components";
import { BrandLogo } from "../brandLogo";
import { Button } from "../button";
import { Marginer } from "../marginer";
import { Divider } from 'rsuite';


const NavbarContainer = styled.div`
  width: 100%;
  height: 65px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 1.5em;
`;

const AccessibilityContainer = styled.div`
  height: 100%;
  display: flex;
  align-items: center;
`;

const AnchorLink = styled.a`
  font-size: 14px;
  color: #fff;
  cursor: pointer;
  text-decoration: none;
  outline: none;
  transition: all 200ms ease-in-out;
  &:hover {
    color: #a0a0a0;
  }
`;

const Seperator = styled.div`
  max-height: 10%;
  min-height: 10%;
  width: 1px;
  background-color: #fff;
`;


export function Navbar(props) {
  const { useTransparent } = props;


  return (
    // <NavbarContainer>
    //   <BrandLogo textSize={20}/>
    //   <AccessibilityContainer>
    //     <AnchorLink>Contact</AnchorLink>
    //     <Marginer direction="horizontal" margin={10} />
    //     <Seperator />
    //     <Button size={14} marginLeft={10}>Register</Button>
    //     <Marginer direction="horizontal" margin={10} />
    //     <AnchorLink>Login</AnchorLink>
    //   </AccessibilityContainer>
    // </NavbarContainer>

      <nav class="navbar navbar-expand-md navbar-light pt-2 pb-2">
              <div class="container-xxl">
                  <a class="navbar-brand" href="#intro">
                      <span class="text-secondary fw-bold"><BrandLogo textSize={22}/></span>
                  </a>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main-nav" aria-controls="main-nav" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

                  <div class="collapse navbar-collapse justify-content-end align-center" id="main-nav">
                      <ul class="navbar-nav">
                        <li class="nav-item">
                          <a class="nav-link text-white" href="#topics" >Contact</a>
                        </li>    
                                           
                        <li class="nav-item">
                            <a class="nav-link text-white" href="#reviews">Login</a>
                        </li>
                        <li class="nav-item d-md-none">
                            <a class="nav-link" href="#pricing">Pricing</a>
                        </li>
                        <li class="nav-item ms-2 d-none d-md-inline">
                            <a class="btn btn-primary rounded-pill" href="#pricing">Register</a>
                        </li>
                      </ul>
                  </div>
              </div>
          </nav>
    
  );
}