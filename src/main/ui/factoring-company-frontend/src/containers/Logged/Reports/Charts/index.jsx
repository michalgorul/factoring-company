import React, {useState} from 'react';
import {Bar, Pie} from 'react-chartjs-2';
import {randColor} from "../../../../services/chartsService";
import {Marginer} from "../../../../components/marginer";

const Charts = () => {
    const colors = [
        randColor(),
        randColor(),
        randColor(),
        randColor(),
        randColor(),
        randColor(),
    ]
    const data = {
        labels: ['1', '2', '3', '4', '5', '6'],
        datasets: [
            {
                label: '# of Votes',
                data: [12, 19, 3, 5, 2, 30],
                backgroundColor: [
                    `rgba(${colors[0]}, 0.2)`,
                    `rgba(${colors[1]}, 0.2)`,
                    `rgba(${colors[2]}, 0.2)`,
                    `rgba(${colors[3]}, 0.2)`,
                    `rgba(${colors[4]}, 0.2)`,
                    `rgba(${colors[5]}, 0.2)`,
                ],
                borderColor: [
                    `rgba(${colors[0]}, 1.0)`,
                    `rgba(${colors[1]}, 1.0)`,
                    `rgba(${colors[2]}, 1.0)`,
                    `rgba(${colors[3]}, 1.0)`,
                    `rgba(${colors[4]}, 1.0)`,
                    `rgba(${colors[5]}, 1.0)`,

                ],
                borderWidth: 4,
            },
        ],
    };

    const options = {
        scales: {
            yAxes: [
                {
                    ticks: {
                        beginAtZero: true,
                    },
                },
            ],
        },
    };
    const [whatTransactions, setWhatTransactions] = useState('credit');
    const handleWhatTransactionsChange = (changeEvent) => {
        setWhatTransactions(changeEvent.target.value);
    }
    return(
        <>
            <div className='header'>
                <h1 className='title'>Vertical Bar Chart</h1>
            </div>
        <div className="container mt-5 mb-4 h4">
            <div className="row align-items-start ms-1">
                <div className="col-6 col-lg-3">
                    <div className="form-check">
                        <input className="form-check-input" type="radio" name="payOption" value="credit"
                               checked={whatTransactions === 'credit'} onChange={handleWhatTransactionsChange}/>
                        <label className="form-check-label">Credits</label>
                    </div>
                </div>
                <div className="col-6 col-lg-3">
                    <div className="form-check">
                        <input className="form-check-input" type="radio" name="payOption" value="invoice"
                               checked={whatTransactions === 'invoice'} onChange={handleWhatTransactionsChange}/>
                        <label className="form-check-label">Invoices</label>
                    </div>
                </div>
            </div>
        </div>

        <Marginer direction={'vertical'} margin={60}/>
        <div className="row justify-content-center">
            <div className="col-5 ">
                <Pie data={data} options={options}/>

            </div>
        </div>

    </>)
};

export default Charts;