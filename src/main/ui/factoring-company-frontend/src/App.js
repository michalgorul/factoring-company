import {HomePage} from './containers/NotLogged/HomePage'
import {BrowserRouter as Router, Switch, Route, Redirect} from 'react-router-dom';
import NotFound from './containers/NotFound';
import Login from './containers/NotLogged/LoginPage';
import Register from './containers/NotLogged/RegisterPage';
import TermsOfUse from './containers/TermsOfUse/termsOfUse';
import MainPageLoged from './containers/Logged/MainPage';
import Customers from './containers/Logged/Customers';
import Invoices from './containers/Logged/Invoices';
import Credit from './containers/Logged/Credit';
import Reports from './containers/Logged/Reports';
import Documents from './containers/Logged/Documents';
import FileListPage from './containers/Logged/Documents/fileListPage';
import Profile from './containers/Logged/Profile';
import Layout from './containers/Logged/Layout';
import CustomerDetails from './containers/Logged/Customers/customerDetails';
import CustomerCreate from './containers/Logged/Customers/customerCreate';
import CustomerEdit from './containers/Logged/Customers/customerEdit';
import CompanyEdit from './containers/Logged/Profile/companyEdit';
import ProfileEdit from './containers/Logged/Profile/profileEdit';
import Support from './containers/Logged/Support';
import InvoiceDetails from './containers/Logged/Invoices/invoiceDetails';
import EditBankAccount from './containers/Logged/BankAccount';
import CreditDetails from './containers/Logged/Credit/creditDetails';
import InvoiceCreate from './containers/Logged/Invoices/invoiceCreate';
import ProtectedRoute from './components/protectedRoute/protectedRoute';
import GeneralInfoEdit from './containers/Logged/Invoices/generalInfoEdit';
import PaymentInfoEdit from './containers/Logged/Invoices/paymentInfoEdit';


const UserComponents = ({match}) => {
  return(
      <Layout>
        <Switch>
          <ProtectedRoute path={`${match.url}/main`} exact component={MainPageLoged} />
          <ProtectedRoute path={`${match.url}/help`} exact component={Support} />
          <ProtectedRoute path={`${match.url}/customers`} exact component={Customers} />
          <ProtectedRoute path={`${match.url}/customers/create`} exact component={CustomerCreate}/>
          <ProtectedRoute path={`${match.url}/customers/edit/:id`} exact component={CustomerEdit}/>
          <ProtectedRoute path={`${match.url}/bank-account/edit/:id`} exact component={EditBankAccount}/>
          <ProtectedRoute path={`${match.url}/customers/:id`} component={CustomerDetails}/>
          <ProtectedRoute path={`${match.url}/invoices`} exact component={Invoices} />
          <ProtectedRoute path={`${match.url}/invoices/create`} exact component={InvoiceCreate} />
          <ProtectedRoute path={`${match.url}/invoices/edit/general-info/:id`} exact component={GeneralInfoEdit} />
          <ProtectedRoute path={`${match.url}/invoices/edit/payment-info/:id`} exact component={PaymentInfoEdit} />
          <ProtectedRoute path={`${match.url}/invoices/:id`} exact component={InvoiceDetails} />
          <ProtectedRoute path={`${match.url}/credit`} exact component={Credit} />
          <ProtectedRoute path={`${match.url}/credit/:id`} exact component={CreditDetails} />
          <ProtectedRoute path={`${match.url}/reports`} exact component={Reports} />
          <ProtectedRoute path={`${match.url}/documents`} exact component={Documents} />
          <ProtectedRoute path={`${match.url}/documents/list/:catalog`} exact component={FileListPage} />
          <ProtectedRoute path={`${match.url}/profile`} exact component={Profile} />
          <ProtectedRoute path={`${match.url}/profile/edit`} exact component={ProfileEdit} />
          <ProtectedRoute path={`${match.url}/profile/company/edit/:id`} exact component={CompanyEdit} />
          <ProtectedRoute path="*" render={() => (<Redirect to="/404" />)} />
        </Switch>
      </Layout>
  );
};


function App() {
  return (
      <Router>
        <div className="App">
          <div className="content">
            <Switch>
              <Route exact path="/" component={HomePage} />
              <Route path="/login" exact component={Login} />
              <Route path="/register" exact component={Register} />
              <Route path="/terms-of-use" exact component={TermsOfUse} />
              <Route path="/user" component={UserComponents} />
              <Route path="*" component={NotFound} />
            </Switch>
          </div>
        </div>
      </Router>
  );
}

export default App;
