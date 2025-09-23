import { mount } from 'svelte'
import './app.css'
import App3D from './App3D.svelte'

const app = mount(App3D, {
  target: document.getElementById('app'),
})

export default app
