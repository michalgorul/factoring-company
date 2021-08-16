import {HomePage} from './containers/NotLogged/HomePage'
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
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
import Sidebar from './containers/Logged/Sidebar/sidebar';

function App() {
  return (
      <Router>
        <div className="App">
        <div className="content">
        <Switch>
          <Route exact path="/" component={HomePage} />
          <Route path="/login" component={Login} />
          <Route path="/register" component={Register} />
          <Route path="/terms-of-use" component={TermsOfUse} />
          <Route path="/admin" component={MainPageLoged} />
          <Route path="/customers" component={Customers} />
          <Route path="/invoices" component={Invoices} />
          <Route path="/credit" component={Credit} />
          <Route path="/reports" component={Reports} />
          <Route path="/documents" component={Documents} />
          <Route path="/profile" component={Profile} />
          <Route path="*" component={NotFound} />
        </Switch>
        </div>
        </div>
      </Router>
  );
}

export default App;
