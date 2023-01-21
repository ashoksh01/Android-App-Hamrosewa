
import {
  ADD_TO_CART,
  REMOVE_CART_ITEM,
  SAVE_SHIPPING_INFO,
  ADD_TO_CART_SUCCESS,
} from "../contants/cartConstants";
import axios from "axios";

export const addItemsToCart = (id, quantity) => async (dispatch, getState) => {

  const { data } = await axios.get(`/api/v2/product/${id}`);

  dispatch({
    type: ADD_TO_CART,
    payload: {
      product: data.product._id,
      name: data.product.name,
      price: data.product.price,
      image: data.product.images[0].url,
      stock: data.product.Stock,
      quantity,
    },
  });

  localStorage.setItem("cartItems", JSON.stringify(getState().cart.cartItems));
};

// export const addItemsToCarts = (id, quantity) => async (dispatch) => {

//     const config = { headers: { "Content-Type": "application/json" } };

//     const { data } = await axios.post(
//       `/api/v2/create/cart`,
//       { id, quantity },
//       config
//     );

//   // const { data } = await axios.get(`/api/v2/product/${id}`);

//   dispatch({
//     type: ADD_TO_CART,
//     payload: {
//       product: data.product._id,
//       name: data.product.name,
//       price: data.product.price,
//       image: data.product.images[0].url,
//       stock: data.product.Stock,
//       quantity,
//     },
//   });

//   localStorage.setItem("cartItems", JSON.stringify(getState().cart.cartItems));
// };

// REMOVE FROM CART
export const removeItemsFromCart = (id) => async (dispatch, getState) => {
  console.log(id);
  dispatch({
    type: REMOVE_CART_ITEM,
    payload: id,
  });

  localStorage.setItem("cartItems", JSON.stringify(getState().cart.cartItems));
};

// shipping INFO CART
export const saveShippingInfo = (data) => async (dispatch) => {
  dispatch({
    type: SAVE_SHIPPING_INFO,
    payload: data,
  });

  localStorage.setItem("shippingInfo", JSON.stringify(data));
};

// send product data to cart api
// export const addItemsToCart = (itemId, quantity) => async (dispatch) => {
//   const config = { headers: { "Content-Type": "application/json" } };

//   const { data } = await axios.post(
//     `/api/v2/create/cart`,
//     { itemId, quantity },
//     config
//   );

//   // console.log(data.cartItem.items);
//   // data.cartItem.items.map((item) => item.productId);

//   dispatch({
//     type: ADD_TO_CART,
//      payload: data.items,
//   });
// };

//  export const getCartItems = () => {
//   return async (dispatch) => {
//     try {
    
//       const res = await axios.get(`/api/v2/get/cart`);
//       console.log(res.data);
//       if (res.status === 200) {
//         // const data = res.data;

//         console.log({ getCartItems: res.data});
//         if (res.data) {
//           dispatch({
//             type: ADD_TO_CART_SUCCESS,
//             payload: res.data,
//           });
//         }
//       }
//     } catch (error) {
//       console.log(error);
//     }
//   };
// };
