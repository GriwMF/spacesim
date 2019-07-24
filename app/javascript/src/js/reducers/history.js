import {
  HANDLE_RECEIVED_HISTORY,
  SELECT_FILTER,
  SELECT_OBJECT
} from '../actions'

const history = (state = [], action) => {
  switch (action.type) {
    case SELECT_FILTER:
      return {
        ...state,
        currentObject: null,
        currentFilter: action.filter,
        filteredHistories: filteredHistories(state.histories, action.filter)
      }
    case SELECT_OBJECT:
      return { ...state, currentObject: action.objectId }
    case HANDLE_RECEIVED_HISTORY:
      let histories = [...state.histories, JSON.parse(action.history)]
      return {
        ...state,
        histories: histories,
        filteredHistories: filteredHistories(histories, state.currentFilter)
      }
    default:
      return state
  }
}

const filteredHistories = (histories, currentFilter) => {
  console.log(histories)
  return histories.filter(h => currentFilter === 'All' || h.object_type === currentFilter);
}

export default history
