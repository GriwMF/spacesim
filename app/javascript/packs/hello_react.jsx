// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Fragment } from 'react'
import ReactDOM from 'react-dom'
import ActionCable from 'actioncable'
import PropTypes from 'prop-types'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import Reducer from '../src/js/reducers'
import HistoryContainer from '../src/js/containers/history_container'
import MenuBar from '../src/js/components/menu_bar'

let store = createStore(Reducer, {history: { histories: INITIAL_STATE, filteredHistories: INITIAL_STATE, currentFilter: 'All'}}, window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__())

let cable = ActionCable.createConsumer('ws://localhost:3000/cable');

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Provider store={store}>
      <MenuBar name="React" />
      <HistoryContainer cable={cable}/>
    </Provider>,
    document.body.appendChild(document.createElement('div'))
  )
})
