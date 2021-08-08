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
        height: 730px;
        background: url(${TopSectionBGImage});
        background-position: 0px -170px;
        background-size: cover;
`;

const BackgroundFilter = styled.div`
  width: 100%;
  height: 100%;
  background-color: rgba(38, 70, 83, 0.9);
  display: flex;
  flex-direction: column;
`;

const TopSectionInnerContainer = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-evenly;
`;

const StandoutImage = styled.div`
  width: 30em;
  height: 30em;
  img {
    width: 100%;
    height: 100%;
  }
`;

const LogoContainer = styled.div`
  display: flex;
  align-items: flex-start;
  flex-direction: column;
`;

const SloganText = styled.h3`
  margin-left: 175px;
  line-height: 1.4;
  color: #fff;
  font-weight: 500;
  font-size: 36px;
`;

export function TopSection(props) {

    const {children} = props;
    return (
        <TopSectionContainer>
            <BackgroundFilter>
                {children}
                <TopSectionInnerContainer>        
                    <LogoContainer>
                        <BrandLogo logoSize={160} />
                        <SloganText>Best funding</SloganText>
                        <SloganText>for your business</SloganText>
                        <Marginer direction="vertical" margin={15} />
                        <Button>Apply Now</Button>
                    </LogoContainer>
                    <StandoutImage>
                        <img src={TopSectionIllustration} alt="best in the field" />
                    </StandoutImage>
                </TopSectionInnerContainer>
            </BackgroundFilter>
        </TopSectionContainer>

    )

}