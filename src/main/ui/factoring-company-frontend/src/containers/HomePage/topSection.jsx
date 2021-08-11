import React from 'react'
import styled from 'styled-components'
import { BrandLogo } from "../../components/brandLogo";
import { Marginer } from "../../components/marginer";
import { Button } from "../../components/button";

import TopSectionBGImage from '../../images/TopSectionBG.jpg';

//Copy this link and paste it wherever it's visible, close to where you’re using the resource. If that's not possible, place it at the footer of your website, blog or newsletter, or in the credits section.
//<a href="https://www.freepik.com/vectors/business">Business vector created by vectorjuice - www.freepik.com</a>
import TopSectionIllustration from '../../images/illustration.png';

const TopSectionContainer = styled.div`
        width: 100%;
        height: 70%;
`;

const BackgroundFilter = styled.div`
  width: 100%;
  height: 100%;
  background-color: rgba(57, 138, 231, 0.89);
  display: flex;
  flex-direction: column;
`;


export function TopSection(props) {

    const {children} = props;
    return (

          <TopSectionContainer>
            <BackgroundFilter>
              {children}
              <div class="container-lg">
                <div class="row d-flex justify-content-start justify-content-lg-start align-items-center">
                    <div class="col-lg-6 text-center">
                          <BrandLogo logoSize={160} className="d-none d-md-block"/>
                          <h1>
                            <div class="display-2 text-white">Best funding</div>
                            <div class="display-5 text-white">for your business</div>
                        </h1>
                        <Marginer direction="vertical" margin={15} />
                        <Button>Apply Now</Button>
                        <Marginer direction="vertical" margin={30} />
                    </div>
                    <div class="col-lg-6 text-center d-none d-lg-block">
                        <img src={TopSectionIllustration} class="img-fluid" alt="ebook"/>
                    </div>
                </div>
              </div>
            </BackgroundFilter>
        </TopSectionContainer>
    )
}