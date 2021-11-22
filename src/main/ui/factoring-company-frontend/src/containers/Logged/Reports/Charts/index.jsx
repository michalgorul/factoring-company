import React, {useEffect, useState} from 'react';
import {
    getBackgroundColors, getBorderColors, getColors,
    getLastMonths,
    getRandomDataset, randColor, showChart,
    showSelectDateScope
} from "../../../../services/chartsService";
import {Marginer} from "../../../../components/marginer";

const Charts = () => {
    const [whatTransactions, setWhatTransactions] = useState('credit');
    const [whatChart, setWhatChart] = useState('bar');
    const [datesScope, setDatesScope] = useState('last3Months');
    const [labels, setLabels] = useState(getLastMonths(3));
    const [dataset, setDataset] = useState(getRandomDataset(3));
    let colors = getColors(3);
    const [backgroundColors, setBackgroundColors] = useState(getBackgroundColors(3, colors));
    const [borderColors, setBorderColors] = useState(getBorderColors(3, colors));

    let data = {
        labels: labels,
        datasets: [
            {
                label: '$ Amount',
                data: dataset,
                backgroundColor: backgroundColors,
                borderColor: borderColors,
                borderWidth: 3,
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


    const handleWhatTransactionsChange = (changeEvent) => {
        setWhatTransactions(changeEvent.target.value);
    }
    const handleWhatChartChange = (changeEvent) => {
        setWhatChart(changeEvent.target.value);
    }
    const setOptionsForCharts = (numOfColors) => {
        let colors = [];
        for (let i = numOfColors; i > 0; i -= 1) {
            colors.push(randColor())
        }
        setDataset(getRandomDataset(numOfColors));
        setBackgroundColors(getBackgroundColors(numOfColors, colors));
        setBorderColors(getBorderColors(numOfColors, colors));
        setLabels(getLastMonths(numOfColors));

    }
    useEffect(() => {
        if (datesScope === 'lastMonth') {
            setOptionsForCharts(4)
        } else if (datesScope === 'last3Months') {
            setOptionsForCharts(3)
        } else if (datesScope === 'last6Months') {
            setOptionsForCharts(6)
        } else if (datesScope === 'lastYear') {
            setOptionsForCharts(12)
        }
    }, [datesScope]);

    return (
        <>
            <div className="media align-items-center py-2">
                <div className="media-body ml-4">
                    <h4 className="font-weight-bold display-2">Charts</h4>
                </div>
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
            <div className="container mt-5 mb-4 h4">
                <div className="row align-items-start ms-1">
                    <div className="col-6 col-lg-3">
                        <div className="form-check">
                            <input className="form-check-input" type="radio" name="chartOption" value="bar"
                                   checked={whatChart === 'bar'} onChange={handleWhatChartChange}/>
                            <label className="form-check-label">Bar</label>
                        </div>
                    </div>
                    <div className="col-6 col-lg-3">
                        <div className="form-check">
                            <input className="form-check-input" type="radio" name="chartOption" value="pie"
                                   checked={whatChart === 'pie'} onChange={handleWhatChartChange}/>
                            <label className="form-check-label">Pie</label>
                        </div>
                    </div>
                </div>
            </div>

            {showSelectDateScope(whatChart, setDatesScope)}


            <Marginer direction={'vertical'} margin={60}/>
            <div className="col-12 mb-4">
                {showChart(whatChart, data, options)}
            </div>

        </>)
};

export default Charts;