

import React, { Fragment, useRef, useState, useEffect } from "react";
import { Link } from "react-router-dom";
import MailOutlineIcon from "@material-ui/icons/MailOutline";

import FaceIcon from "@material-ui/icons/Face";
 import "./UpdateProfile.css";
import { useDispatch, useSelector } from "react-redux";
import { clearError, loadUser, updateProfile } from "../../actions/userAction";
import { useAlert } from "react-alert";
import Loader from "../Loading/Loader";
import { useNavigate } from "react-router-dom";
import { UPDATE_PROFILE_RESET } from "../../contants/userContants";

const UpdateProfile = () => {
    const navigate = useNavigate();
    const dispatch = useDispatch();
    const alert = useAlert();
   
    const { error, isUpdated, loading } = useSelector((state) => state.profile);
    const { user } = useSelector((state) => state.user);

     

    const [name, setname] = useState("");
    const [email, setemail] = useState("");
      const [avatar, setAvatar] = useState();
      const [avatarPreview, setAvatarPreview] = useState("/Profile.png");

      
  const updateProfileSubmit = (e) => {
    e.preventDefault();

    const myForm = new FormData();

    myForm.set("name", name);
    myForm.set("email", email);
    myForm.set("avatar", avatar);
    dispatch(updateProfile(myForm));
  };

  const updateProfileDataChange = (e) => {

      const reader = new FileReader();

      reader.onload = () => {
        if (reader.readyState === 2) {
          setAvatarPreview(reader.result);
          setAvatar(reader.result);
        }
      };

      reader.readAsDataURL(e.target.files[0]);

  };
  useEffect(() => {
    if(error){
      alert.error(error);
      dispatch(clearError());
    }
    if(user){
        setname(user.name);
        setemail(user.email);
        setAvatarPreview(user.image.url);
       
    }
    if (isUpdated) {
      alert.success("Profile Updated Successfully");
      dispatch(loadUser());
      navigate("/profile");
      dispatch({type:UPDATE_PROFILE_RESET});
    }
   
  }, [dispatch, error, alert , navigate, user,isUpdated]);
    return (
        <Fragment>
            {loading ? <Loader/> :   <Fragment>
        <div className="updateProfileContainer">
          <div className="updateProfileBox">
            <h2 className="">Update Profile</h2>
            <form
              className="updateProfileForm"
              encType="multipart/form-data"
              onSubmit={updateProfileSubmit}
            >
              <div className="updateProfileName">
                <FaceIcon />
                <input
                  type="text"
                  placeholder="Name"
                  required
                  name="name"
                  value={name}
                  onChange={(e) => setname(e.target.value)}
                />
              </div>
              <div className="updateProfileEmail">
                <MailOutlineIcon />
                <input
                  type="email"
                  placeholder="Email"
                  required
                  name="email"
                  value={email}
                  onChange={(e) => setemail(e.target.value)}
                />
              </div>

              <div id="updateProfileImage">
                <img src={avatarPreview} alt="Avatar Preview" />
                <input
                  type="file"
                  name="avatar"
                  accept="image/*"
                  onChange={updateProfileDataChange}
                />
              </div>
              <input
                type="submit"
                value="updateProfile"
                className="updateProfileBtn"
              />
            </form>
          </div>
        </div>
      </Fragment>}


        </Fragment>
    );
}

export default UpdateProfile;
