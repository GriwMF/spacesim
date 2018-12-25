import {
  SELECT_FILTER,
} from '../actions/actions'

const filter = (state = [], action) => {
  console.log(action)
  switch (action.type) {
    case SELECT_FILTER:
      return {...state, currentFilter: action.filter}
    default:
      return state
  }
}

export default filter
