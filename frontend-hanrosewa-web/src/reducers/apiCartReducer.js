import {
  ADD_TO_CART,
  ADD_TO_CART_SUCCESS,
  REMOVE_CART_ITEM,
  SAVE_SHIPPING_INFO,
} from "../contants/cartConstants";

export const cartReducer = (
  state = { cartItems: [] },
  action
) => {
  switch (action.type) {
    case ADD_TO_CART:
      const item = action.payload;
      // console.log(item);
      const isItemExist = state.cartItems.find(
        (i) => i.product === item.product
      );
      if (isItemExist) {
        return {
          ...state,
          cartItems: state.cartItems.map((i) =>
            i.product === isItemExist.product ? item : i
          ),
        };
      } else {
        return {
          ...state,
          cartItems: [...state.cartItems, item],
        };
      }
    case REMOVE_CART_ITEM:
      return {
        ...state,
        cartItems: state.cartItems.filter((i) => i.product !== action.payload),
      };
   

    case ADD_TO_CART_SUCCESS:
         return {
           ...state,
           cartItems: action.payload.cartItems,
         };

    default:
      return state;
  }
};
