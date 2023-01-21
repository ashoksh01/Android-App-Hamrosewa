import React,{ useEffect} from "react";
import "./style.css";
import { useSelector, useDispatch } from "react-redux";
import Footer from "../footer/Footer";
import { addItemsToCart, getCartItems, removeItemsFromCart } from "../../actions/cartAction";
import { useNavigate } from "react-router-dom";

const Cart = () => {
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { cartItems } = useSelector((state) => state.cart);
  console.log(cartItems);
  // Stpe: 7   calucate total of items
  const totalPrice = cartItems.reduce(
    (price, item) => price + item.quantity * item.price,
    0
  );

  const increaseQuantity = (id, quantity, stock) => {
    const newQty = quantity + 1;
    if (stock <= quantity) {
      return;
    }
    dispatch(addItemsToCart(id, newQty));

  };

  const decreaseQuantity = (id, quantity) => {
    const newQty = quantity - 1;
    if (1 >= quantity) {
      return;
    }
    dispatch(addItemsToCart(id, newQty));
  };

  const deleteCartItems = (id) => {
    dispatch(removeItemsFromCart(id));
  };
  
    const checkoutHandler = () => {
    navigate("/login?redirect=shipping");
  };

  // useEffect(() =>{
  //   dispatch(getCartItems());

  // },[])




  // prodcut qty total
  return (
    <>
      <section className="cart-items">
        <div className="container d_flex">
          {/* if hamro cart ma kunai pani item xaina bhane no diplay */}

          <div className="cart-details">
            {cartItems.length === 0 && (
              <h1 className="no-items product">No Items are add in Cart</h1>
            )}

            {/* yasma hami le cart item lai display garaaxa */}
            {cartItems &&
              cartItems.map((item) => {
                const productQty = item.price * item.quantity;

                return (
                  <div className="cart-list product d_flex" key={item.id}>
                    <div className="img">
                      <img src={item.image} alt="" />
                    </div>
                    <div className="cart-details">
                      <h3>{item.name}</h3>
                      <h4>
                        ${item.price}.00 * {item.quantity}
                        <span>${productQty}.00</span>
                      </h4>
                    </div>
                    <div className="cart-items-function">
                      <div className="removeCart">
                        <button
                          className="removeCart"
                          onClick={() => deleteCartItems(item.product)}
                        >
                          <i className="fa-solid fa-xmark"></i>
                        </button>
                      </div>
                      {/* stpe: 5 
                    product ko qty lai inc ra des garne
                    */}
                      <div className="cartControl d_flex">
                        <button
                          className="incCart"
                          onClick={() =>
                            increaseQuantity(
                              item.product,
                              item.quantity,
                              item.stock
                            )
                          }
                        >
                          <i className="fa-solid fa-plus"></i>
                        </button>
                        <button
                          className="desCart"
                          onClick={() =>
                            decreaseQuantity(item.product, item.quantity)
                          }
                        >
                          <i className="fa-solid fa-minus"></i>
                        </button>
                      </div>
                      {/* <button onClick={()=>deleteCartItems(item.product) }>Remove</button> */}
                    </div>

                    <div className="cart-item-price"></div>
                  </div>
                );
              })}
          </div>

          <div className="cart-total product">
            <h2>Cart Summary</h2>
            <div className=" d_flex">
              <h4>Total Price :</h4>
              <h3>₹{totalPrice}.00</h3>
            </div>
            <div className="checkOutBtn">
              <button onClick={checkoutHandler}>Check Out</button>
            </div>
          </div>
        </div>
      </section>

      {/* <Footer /> */}
    </>
  );
};

export default Cart;
