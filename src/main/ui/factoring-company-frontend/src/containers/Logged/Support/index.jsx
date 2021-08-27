import styled from "styled-components";
import Chat from '../../../images/forum.png';
import Ticket from '../../../images/receipt.png';
import Phone from '../../../images/telephone.png';
import Email from '../../../images/email.png';
import Twitter from '../../../images/twitter.png';
import Team1 from '../../../images/boy.png';
import Team2 from '../../../images/woman.png';
import Team3 from '../../../images/man.png';
import Team4 from '../../../images/woman2.png';
import React from "react";
import { Accordion } from 'react-bootstrap-accordion'

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

const Support = () => {
    return ( 
			<>
        <div className="container-lg">
					 <div class="text-center mt-3 mb-3">
							<h1>Get Support</h1>
							<p class="lead text-muted">Looking for answers? Our Support tab is where you'll find help fastest. You'll also find information on many topics</p>
						</div>

							<div class="row my-5 align-items-center justify-content-center container-fluid">
								<div class="col-12 col-lg-5">
									<div class="card border-1 h-10">
										<LogoImage>
											<img src={Ticket} class="card-img-top mt-4 mb-2" alt="..."></img>
										</LogoImage>
											<div class="card-body text-center py-4 mt-2">
													<h4 class="card-title">Submit a ticket</h4>
													<p class="lead card-subtitle mb-4">Submit a ticket to out support team. Our average response time is 1 hour and maximum 24 hours</p>
													<a href="#" class="stretched-link"></a>
											</div>
									</div>
								</div>
								<div class="col-12 col-lg-5">
									<div class="card border-1">
										<LogoImage>
											<img src={Chat} class="card-img-top mt-4 mb-2" alt="..."></img>
										</LogoImage>
										<div class="card-body text-center py-4 mt-2">
											<h4 class="card-title">Live chat</h4>
											<p class="lead card-subtitle mb-4">Contact support team via Live Chat. Live Chat is online at 8am to 6 pm from Monday to Friday</p>
											<a href="#" class="stretched-link"></a>
										</div>
									</div>
								</div>  
							</div>

							<div class="row my-5 align-items-center justify-content-center container-fluid">
								<div class="col-12 col-lg-4">
									<div class="card border-1 h-10">
										<LogoImage>
											<img src={Phone} class="card-img-top mt-4 mb-2" alt="..."></img>
										</LogoImage>
										<div class="card-body text-center py-4 mt-2">
											<h4 class="card-title">Phone</h4>
											<a href="tel:123-456-7890" class="stretched-link"></a>
										</div>
									</div>
								</div>

								<div class="col-12 col-lg-4">
									<div class="card border-1">
										<LogoImage>
											<img src={Email} class="card-img-top mt-4 mb-2" alt="..."></img>
										</LogoImage>
										<div class="card-body text-center py-4 mt-2">
											<h4 class="card-title">Email</h4>
											<a href="mailto:support@f.company.com" class="stretched-link"></a>
										</div>
									</div>
								</div> 

								<div class="col-12 col-lg-4">
									<div class="card border-1">
										<LogoImage>
											<img src={Twitter} class="card-img-top mt-4 mb-5" alt="..."></img>
										</LogoImage>
										<div class="card-body text-center py-4 mt-2">
											<h4 class="card-title">Twitter</h4>
											<a href="https://twitter.com/" class="stretched-link"></a>
										</div>
									</div>
								</div> 
              </div>
							
							
        </div>

				<div className="container-lg">
					<div class="text-center mt-5 mb-3">
						<h1>FAQ</h1>
						<p class="lead text-muted">Answers to our most frequently asked questions are just one click away.</p>
					</div>
					<div class="row my-5 align-items-center justify-content-center container-fluid">
							<div class="col-12 col-lg-8">
								<div class="card border-1 h-10">
									<Accordion title="What is invoice factoring?">
										Invoice factoring, also known as accounts receivable financing, is an alternative funding option for small business owners. By financing your accounts receivable, you have fast access to working capital that you can use to build your business.
									</Accordion>
									<Accordion title="Is accounts receivable factoring a loan?">
										Factoring financing is not a loan – rather, it is a way for you to turn existing accounts receivable into cash. The factor actually purchases your receivables at a discount, so there is no interest to repay and no new debt on your balance sheet.
									</Accordion>
									<Accordion title="How do I start factoring?">
										All you have to do is give us a call or fill out an online form!
									</Accordion>
									<Accordion title="What do I need to start the factoring process?">
										To start, you’ll need a completed application, accounts receivable aging report, Articles of Incorporation, a list of your customers and the invoices you want to factor. Learn more about how to get started with factoring.
									</Accordion>
									<Accordion title="What will my customers think?">
										If an account debtor (your customer) receives notice of your factoring and questions the process, simply explain that you have selected a company to manage and finance your accounts receivables. It’s likely your customers are familiar with factoring and many of them may already work with factoring companies. Factoring invoices shouldn’t impact relationships with your customers. The factor may reach out to confirm details from time to time, but communication will be professional and courteous.
									</Accordion>
								</div>
							</div>
						</div>
					</div>

					<div className="container-lg">
					<div class="text-center mt-5 mb-3">
						<h1>Support team</h1>
						<p class="lead text-muted">Answers to our most frequently asked questions are just one click away.</p>
					</div>
					<div class="row my-5 align-items-center justify-content-center container-fluid">
							<div class="col-12 col-lg-3">
								<div class="card border-1 h-10">
										<LogoImage>
											<img src={Team1} class="card-img-top mt-4 mb-5" alt="..."></img>
										</LogoImage>
										<div class="card-body text-center py-4 mt-2">
											<h4 class="card-title">John Doe</h4>
											<p class="lead card-subtitle mb-4">Developer</p>
										</div>
								</div>
							</div>
							<div class="col-12 col-lg-3">
								<div class="card border-1 h-10">
										<LogoImage>
											<img src={Team2} class="card-img-top mt-4 mb-5" alt="..."></img>
										</LogoImage>
										<div class="card-body text-center py-4 mt-2">
											<h4 class="card-title">Sarah Williams</h4>
											<p class="lead card-subtitle mb-4">Account manager</p>
										</div>
								</div>
							</div>
							<div class="col-12 col-lg-3">
								<div class="card border-1 h-10">
										<LogoImage>
											<img src={Team3} class="card-img-top mt-4 mb-5" alt="..."></img>
										</LogoImage>
										<div class="card-body text-center py-4 mt-2">
											<h4 class="card-title">James Brandon</h4>
											<p class="lead card-subtitle mb-4">Support</p>
										</div>
								</div>
							</div>
							<div class="col-12 col-lg-3">
								<div class="card border-1 h-10">
										<LogoImage>
											<img src={Team4} class="card-img-top mt-4 mb-5" alt="..."></img>
										</LogoImage>
										<div class="card-body text-center py-4 mt-2">
											<h4 class="card-title">Natalie Smith</h4>
											<p class="lead card-subtitle mb-4">Support</p>
										</div>
								</div>
							</div>
						</div>
					</div>

</>
     );
}
 
export default Support;