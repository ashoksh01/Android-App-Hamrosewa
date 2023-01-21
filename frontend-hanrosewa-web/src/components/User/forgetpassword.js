

import React, { Fragment, useRef, useState, useEffect } from "react";

import MailOutlineIcon from "@material-ui/icons/MailOutline";

import "./ForgetPassword.css";
import { useDispatch, useSelector } from "react-redux";
import { clearError, forgotPassword } from "../../actions/userAction";
import { useAlert } from "react-alert";
import Loader from "../Loading/Loader";



const Forgetpassword = () => {
   
     const dispatch = useDispatch();
     const alert = useAlert();
     const [email, setEmail] = useState("");

     const { error, message, loading } = useSelector( (state) => state.forgotPassword );
      const ForgotPasswordSubmit = (e) => {
        e.preventDefault();

        const myForm = new FormData();

        myForm.set("email", email);
        dispatch(forgotPassword(myForm));
      };

      
  useEffect(() => {
    if (error) {
      alert.error(error);
      dispatch(clearError());
    }
    if (message) {
      alert.success(message);

    }
  }, [dispatch, alert, error, message]);




    return (
      <Fragment>
        {loading ? (
          <Loader />
        ) : (
          <Fragment>
            <div className="forgotPasswordContainer">
              <div className="forgotPasswordBox">
                <div className="forget-image">
                  <img
                    src="https://png.pngtree.com/png-vector/20191113/ourmid/pngtree-lock-password-password-lock-secure-password-blue-icon-on-abst-png-image_1985473.jpg"
                    alt=""
                  />
                </div>
                <h2 className="forgetpassword">Forget Password</h2>
                <form
                  className="forgotPasswordForm"
                  encType="multipart/form-data"
                  onSubmit={ForgotPasswordSubmit}
                >
                  <div className="forgotPasswordEmail">
                    <MailOutlineIcon />
                    <input
                      type="email"
                      placeholder="Email"
                      required
                      name="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                    />
                  </div>

                  <input
                    type="submit"
                    value="forgotPassword"
                    className="forgotPasswordBtn"
                  />
                </form>
              </div>
            </div>
          </Fragment>
        )}
      </Fragment>
    );
}

export default Forgetpassword;
