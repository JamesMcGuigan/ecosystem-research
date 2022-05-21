import { render } from 'preact'
// import render from 'preact-render-to-string';
import { App } from './app'
import './index.css'

render(<App />, document.getElementById('app')!)
