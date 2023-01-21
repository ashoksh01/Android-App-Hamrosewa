import React, { Fragment, useRef, useState, useEffect } from "react";
import { Link } from "react-router-dom";
import LockOpenIcon from "@material-ui/icons/LockOpen";

import LockIcon from "@material-ui/icons/Lock";
import { UPDATE_PASSWORD_RESET } from "../../contants/userContants";
import "./UpdatePassword.css";
import { useDispatch, useSelector } from "react-redux";
import { clearError, loadUser, updatePassword } from "../../actions/userAction";
import { useAlert } from "react-alert";
import Loader from "../Loading/Loader";
import { useNavigate } from "react-router-dom";


import VpnKeyIcon from "@material-ui/icons/VpnKey";

const UpdatePassword = () => {
  const dispatch = useDispatch();
  const alert = useAlert();
  const navigate = useNavigate();

  const { error, isUpdated, loading } = useSelector((state) => state.profile);

  const [oldPassword, setOldPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");

  const updatePasswordSubmit = (e) => {
    e.preventDefault();

    const myForm = new FormData();

    myForm.set("oldPassword", oldPassword);
    myForm.set("newPassword", newPassword);
    myForm.set("confirmPassword", confirmPassword);

    dispatch(updatePassword(myForm));
  };

  useEffect(() => {
    if(error){
      alert.error(error);
      dispatch(clearError());
    }
   

    if (isUpdated) {
      alert.success("Profile Updated Successfully");

      navigate("/");

      dispatch({
        type: UPDATE_PASSWORD_RESET,
      });
    }
  }, [dispatch,  alert, navigate, error,isUpdated]);

  return (
    <>
      {loading ? (
        <Loader />
      ) : (
        <Fragment>
          <div className="updatePasswordContainer">
            <div className="updatePasswordBox">
              <h2 className="head-change">Update Password</h2>

              <form
                className="updatePasswordForm"
                onSubmit={updatePasswordSubmit}
              >
                <div className="loginPassword">
                  <VpnKeyIcon />
                  <input
                    type="password"
                    placeholder="Old Password"
                    required
                    value={oldPassword}
                    onChange={(e) => setOldPassword(e.target.value)}
                  />
                </div>

                <div className="loginPassword">
                  <LockOpenIcon />
                  <input
                    type="password"
                    placeholder="New Password"
                    required
                    value={newPassword}
                    onChange={(e) => setNewPassword(e.target.value)}
                  />
                </div>
                <div className="loginPassword">
                  <LockIcon />
                  <input
                    type="password"
                    placeholder="Confirm Password"
                    required
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                  />
                </div>
                <input
                  type="submit"
                  value="Change"
                  className="updatePasswordBtn"
                />
              </form>
            </div>
          </div>
        </Fragment>
      )}
    </>
  );
};

export default UpdatePassword;
