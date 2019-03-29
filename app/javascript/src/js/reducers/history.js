import {
  HANDLE_RECEIVED_HISTORY,
  SELECT_FILTER
} from '../actions'

const history = (state = [], action) => {
  switch (action.type) {
    case SELECT_FILTER:
      return {...state, currentFilter: action.filter}
    case HANDLE_RECEIVED_HISTORY:
      return {...state, histories: [...state.histories, JSON.parse(action.history)]}
    default:
      return state
  }
}

export default history
