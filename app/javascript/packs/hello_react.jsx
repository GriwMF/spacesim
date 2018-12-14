// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Fragment } from 'react'
import ReactDOM from 'react-dom'
import ActionCable from 'actioncable'
import PropTypes from 'prop-types'
import History from '../src/js/components/history'

const Hello = props => (
  <div>Hello {props.name}!</div>
)

let cable = ActionCable.createConsumer('ws://localhost:3000/cable');

Hello.defaultProps = {
  name: 'David'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Fragment>
      <Hello name="React" />
      <History cable={cable} />
    </Fragment>,
    document.body.appendChild(document.createElement('div'))
  )
})
