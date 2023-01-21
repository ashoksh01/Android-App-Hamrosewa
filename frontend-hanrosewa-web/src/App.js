import "./App.css";
import React from "react";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import axios from "axios";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

import Header from "./components/header/Header";
import Pages from "./pages/pages";
import ProductsDetails from "./components/product/productsDetails";
// import Footer from "./components/footer/Footer";
// import Product from "./components/product/Allproducts";
import Shop from "./components/shops/Shop";
import Login from "./components/User/login";
import store from "./store";

import { loadUser } from "./actions/userAction";
import UserOptions from "./components/header/userOptions";
import Profile from "./components/User/profile";
import UpdateProfile from "./components/User/UpdateProfile";
import UpdatePassword from "./components/User/UpdatePassword";
import Forgetpassword from "./components/User/forgetpassword";
import Cart from "./components/cart/Cart";
import Shipping from "./components/cart/Shipping";
import ConfirmOrder from "./components/cart/ConfirmOrder";
import Payment from "./components/cart/Payment";
import { Elements } from "@stripe/react-stripe-js";
import { loadStripe } from "@stripe/stripe-js";
import OrderSuccess from "./components/cart/OrderSuccess";
import MyOrders from "./components/order/Myorder";
import OrderDetails from "./components/order/OrderDetails";
import Dashboard from "./components/admin/Dashboard";
import ProductList from "./components/admin/ProductList";
import NewProduct from "./components/admin/NewProduct";
import UpdateProduct from "./components/admin/UpdateProduct";
import OrderList from "./components/admin/OrderList";
import ProcessOrder from "./components/admin/ProcessOrder";
import Footer from "./components/footer/Footer";
import UsersList from "./components/admin/ALLUserList";
import UpdateUser from "./components/admin/UpdateUser";
import NotFound from "./components/pagenotfound/PageNot";

// import ProtectedRoute from "./components/Route/ProtuctedRoute";

function App() {
  const { isAuthenticated, user } = useSelector((state) => state.user);
  const [stripeApiKey, setStripeApiKey] = useState("");

  async function getStripeApiKey() {
    const { data } = await axios.get("/api/v2/stripeapikey");

    setStripeApiKey(data.stripeApiKey);
  }
  console.log(stripeApiKey);

  useEffect(() => {
    store.dispatch(loadUser());
    getStripeApiKey();
  }, []);

  return (
    <Router>
      <Header />
      {isAuthenticated && <UserOptions user={user} />}
      <Routes>
        
        <Route path="/login" element={<Login />} />
        <Route path="/" element={<Pages />} />
        <Route path="/product/:id" element={<ProductsDetails />} />
        <Route path="/products" element={<Shop />} />
        <Route path="/products/:keyword" element={<Shop />} />
        <Route
          path="/me/update"
          element={isAuthenticated ? <UpdateProfile /> : <Pages />}
        />
        <Route
          path="/profile"
          element={isAuthenticated ? <Profile /> : <Pages />}
        />
        <Route
          path="/password/update"
          element={isAuthenticated ? <UpdatePassword /> : <Pages />}
        />
        <Route path="/password/forget" element={<Forgetpassword />} />
        <Route path="/cart" element={<Cart />} />
        <Route
          path="/shipping"
          element={isAuthenticated ? <Shipping /> : <Pages />}
        />
        <Route path="/order/confirm" element={<ConfirmOrder />} />
        <Route
          path="/orders"
          element={isAuthenticated ? <MyOrders /> : <Pages />}
        />
        <Route
          path="/process/payment"
          element={
            isAuthenticated ? (
              <Elements stripe={loadStripe(stripeApiKey)}>
                <Payment />
              </Elements>
            ) : (
              <Pages />
            )
          }
        />
        <Route
          path="/success"
          element={isAuthenticated ? <OrderSuccess /> : <Pages />}
        />
        <Route path="/order/:id" element={<OrderDetails />} />
        // addmin Routes and protected routes and now want to merge
        <Route
          path="/admin/users"
          element={
            isAuthenticated && user.role === "admin" ? <UsersList /> : <Shop />
          }
        />
        <Route
          path="/admin/user/:id"
          element={
            isAuthenticated && user.role === "admin" ? <UpdateUser /> : <Shop />
          }
        />
        <Route
          path="/admin/dashboard"
          element={
            isAuthenticated && user.role === "admin" ? <Dashboard /> : <Shop />
          }
        />
        <Route
          path="/admin/products"
          element={
            isAuthenticated && user.role === "admin" ? (
              <ProductList />
            ) : (
              <Shop />
            )
          }
        />
        <Route
          path="/admin/product"
          element={
            isAuthenticated && user.role === "admin" ? <NewProduct /> : <Shop />
          }
        />
        <Route
          path="/admin/product/:aid"
          element={
            isAuthenticated && user.role === "admin" ? (
              <UpdateProduct />
            ) : (
              <Shop />
            )
          }
        />
        <Route
          path="/admin/orders"
          element={
            isAuthenticated && user.role === "admin" ? <OrderList /> : <Shop />
          }
        />
        <Route
          path="/admin/order/:aoid"
          element={
            isAuthenticated && user.role === "admin" ? (
              <ProcessOrder />
            ) : (
              <Shop />
            )
          }
        />

        <Route path='*' element={<NotFound />} />
      </Routes>
      <Footer />
    </Router>
  );
}

export default App;
