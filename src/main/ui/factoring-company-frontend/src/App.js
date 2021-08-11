import {HomePage} from './containers/HomePage'
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import NotFound from './containers/NotFound/notFound';

function App() {
  return (
    <div className="App">
      <Router>
        <Switch>
          <Route exact path="/" component={HomePage} />
          <Route path="*" component={NotFound} />
        </Switch>
      </Router>

    </div>
  );
}

export default App;
