import React from 'react'
import { Check } from 'react-bootstrap-icons';

export function FundingSolution(props) {

    return (

        <section id="funding" class="bg-light mt-5">
        <div class="container-lg">
            <div class="text-center">
                <h2>Funding Plans</h2>
                <p class="lead text-muted">Funding solutions tailored to your business needs</p>
            </div>

            <div class="row my-5 align-items-center justify-content-center container-fluid">
                <div class="col-10 col-lg-6">
                    <div class="card border-1 h-10">
                        <div class="card-body text-center py-4">
                            <h4 class="card-title">Line of Credit</h4>
                            <p class="lead card-subtitle mb-4">Quick access to capital you want</p>
                            <p class="card-text mx-5 text-muted d-none d-lg-block">
                                <Check /> Credit lines up to
                                <span class="h5 text-muted"> $100,000</span>
                            </p>
                            <p class="card-text mx-5 text-muted d-none d-lg-block">
                                <Check /> Only pay for what you use
                            </p>
                            <p class="card-text mx-5 text-muted d-none d-lg-block">
                                <Check /> No prepayment penalties
                            </p>
                            <a href="/" class="btn btn-outline-success btn-lg mt-3">Learn more</a>
                        </div>
                    </div>
                </div>

                <div class="col-10 col-lg-6">
                    <div class="card border-1">
                        <div class="card-body text-center py-4 flex-fill">
                            <h4 class="card-title">Invoice Factoring</h4>
                            <p class="lead card-subtitle mb-4">Turn unpaid invoices into cash</p>
                            <p class="card-text mx-5 text-muted d-none d-lg-block">
                                <Check /> Credit lines up to
                                <span class="h5 text-muted"> $1 million</span>
                            </p>
                            <p class="card-text mx-5 text-muted d-none d-lg-block">
                                <Check /> Rates from 1%
                            </p>
                            <p class="card-text mx-5 text-muted d-none d-lg-block">
                                <Check /> You choose the period
                            </p>
                            <a href="/" class="btn btn-outline-success btn-lg mt-3">Learn more</a>
                        </div>
                    </div>
                </div> 
            </div>
        </div>
    </section>

    )

}