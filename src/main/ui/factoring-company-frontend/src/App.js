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
import Profile from './containers/Logged/Profile';
import Layout from './containers/Logged/Layout';
import CustomerDetails from './containers/Logged/Customers/customerDetails';



const UserComponents = ({match}) => {
  return(
      <Layout>
        <Switch>
          <Route path={`${match.url}/admin`} exact component={MainPageLoged} />
          <Route path={`${match.url}/customers`} exact component={Customers} />
          <Route path={`${match.url}/customers/:id`} component={CustomerDetails}/>
          <Route path={`${match.url}/invoices`} exact component={Invoices} />
          <Route path={`${match.url}/credit`} exact component={Credit} />
          <Route path={`${match.url}/reports`} exact component={Reports} />
          <Route path={`${match.url}/documents`} exact component={Documents} />
          <Route path={`${match.url}/profile`} exact component={Profile} />
          <Route path="*" render={() => (<Redirect to="/404" />)} />
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
              <Route path="user/admin" exact component={MainPageLoged} />
              <Route path="/user" component={UserComponents} />
              <Route path="*" component={NotFound} />
            </Switch>
          </div>
        </div>
      </Router>
  );
}

export default App;
