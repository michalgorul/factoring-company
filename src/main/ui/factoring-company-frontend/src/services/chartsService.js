import Select from "react-select";
import React from "react";
import {Pie, Bar} from "react-chartjs-2";

const rand = () => Math.floor(Math.random() * 255);
const randColor = () => `${rand()}, ${rand()}, ${rand()}`;

const datesOptions = [
    {value: 'lastMonth', label: 'Last Month'},
    {value: 'last3Months', label: 'Last 3 months'},
    {value: 'last6Months', label: 'Last 6 months'},
    {value: 'lastYear', label: 'Last year'},
]

const showSelectDateScope = (item, setScope) => {
    return (
        <div className="col-12 col-xl-6">
            <div className="container-sm ">
                <div className="row align-content-center justify-content-start mb-4">
                    <div className="col-9">
                        Select scope: <Select onChange={(e) => setScope(e.value)} options={datesOptions}/>
                    </div>
                </div>
            </div>
        </div>
    )
}

const getLastMonths = (numOfMonths) => {
    if (numOfMonths === 4) {
        return ["Week 1", "Week 2", "Week 3", "Week 4"];
    }
    const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    let today = new Date();
    let d;
    let month;
    let year;
    let months = [];
    for (let i = numOfMonths; i > 0; i -= 1) {
        d = new Date(today.getFullYear(), today.getMonth() - i, 1);
        month = monthNames[d.getMonth()];
        year = d.getFullYear();
        months.push(month + ' ' + year)
    }
    return months;
}

const getRandomDataset = (numOfDatas) => {
    let datas = [];
    for (let i = numOfDatas; i > 0; i -= 1) {
        datas.push(rand())
    }
    return datas;
}

const getColors = (numOfColors) => {
    let colors = [];
    for (let i = numOfColors; i > 0; i -= 1) {
        colors.push(randColor())
    }
    return colors;
}

const getBackgroundColors = (numOfColors, colors) => {
    let backgroundColors = [];
    for (let i = 0; i < numOfColors; i += 1) {
        backgroundColors.push(`rgba(${colors[i]}, 0.3)`)
    }
    return backgroundColors;
}

const getBorderColors = (numOfColors, colors) => {
    let borderColors = [];
    for (let i = 0; i < numOfColors; i += 1) {
        borderColors.push(`rgba(${colors[i]}, 1.0)`)
    }
    return borderColors;
}

const showChart = (whatChart, data, options) => {
    if (whatChart === 'bar') {
        return (
            <div>
                <div className="col-8 mx-auto">
                    <Bar data={data} options={options} type={'bar'}/>
                </div>
            </div>
        )
    } else if (whatChart === 'pie') {
        return (
            <div>
                <div className="col-5 mx-auto">
                    <Pie data={data} options={options} type={'pie'}/>
                </div>
            </div>
        )
    }
}

export {
    rand,
    randColor,
    datesOptions,
    showSelectDateScope,
    getLastMonths,
    getRandomDataset,
    getBackgroundColors,
    getBorderColors,
    getColors,
    showChart
}