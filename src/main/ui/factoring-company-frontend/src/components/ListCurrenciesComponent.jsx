import React, {Component} from 'react';
import CurrencyService from '../services/CurrencyService';

class ListCurrenciesComponent extends Component {
    constructor(props) {
        super(props);
        this.state = {
            currencies: []

        }
    }
    
    componentDidMount(){
        CurrencyService.getCurrencies().then((res)=>{
            this.setState({currencies: res.data});
        });
    }

    render() {
        return (
            <div>
                <h2 className="text-center">Currency List </h2>
                <div className ="row">
                    <table className = "table table-striped table-boarded">
                        <thead>
                            <tr>
                                <th> ID </th>
                                <th> Code </th>
                                <th> Name </th>
                            </tr>
                        </thead>

                        <tbody>
                            {
                                this.state.currencies.map(
                                    currency =>
                                    <tr key = {currency.id}>
                                        <td> {currency.id} </td>
                                        <td> {currency.code} </td>
                                        <td> {currency.name} </td>
                                    </tr>
                                )
                            }
                        </tbody>
                    </table>
                </div>
                
            </div>
        );
    }
}

export default ListCurrenciesComponent;