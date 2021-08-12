import {HomePage} from './containers/NotLogged/HomePage'
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import NotFound from './containers/NotFound';
import Login from './containers/NotLogged/LoginPage';
import Register from './containers/NotLogged/RegisterPage';
import TermsOfUse from './containers/TermsOfUse/termsOfUse';
import MainPageLoged from './containers/Logged/MainPage';

function App() {
  return (
      <Router>
        <div className="App">
        <Switch>
          <Route exact path="/" component={HomePage} />
          <Route path="/login" component={Login} />
          <Route path="/register" component={Register} />
          <Route path="/terms-of-use" component={TermsOfUse} />
          <Route path="/admin" component={MainPageLoged} />
          <Route path="*" component={NotFound} />
        </Switch>
        </div>
      </Router>
  );
}

export default App;
