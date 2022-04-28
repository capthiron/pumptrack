import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';

const app = Elm.Main.init({
	node: document.getElementById('root')
});

app.ports.updateProgressCircle.subscribe(progress => {
	app.ports.onProgressChange.send(progress.done + progress.steps)
})

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
