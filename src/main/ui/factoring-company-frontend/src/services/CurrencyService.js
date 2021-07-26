import axios from 'axios';

const CURRENCY_API_BASE_URL = "http://localhost:8080/currency";
class CurrencyService{

    getCurrencies(){
        return axios.get(CURRENCY_API_BASE_URL);
    }
}

export default new CurrencyService();