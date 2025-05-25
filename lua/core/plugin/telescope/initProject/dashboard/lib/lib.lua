local M = {}

M.dropdown_config = [[
{
    "sidebar": {
       "container": "pl-5 w-full flex flex-col",
       "element": "w-full h-full  flex flex-row items-center rounded-lg p-2 hover:bg-white/10"
    }
}
]]

M.dropdown = [[
"use client"
import { useState } from "react";
import Link from "next/link"
import { AiFillCaretRight, AiFillAccountBook, AiFillAlert, AiFillAliwangwang } from "react-icons/ai";
import { GoWorkflow } from "react-icons/go";
import Config from "./config.json";


const event_mouseover = "transition duration-200"

const List = ({check, data})=>{
    return (
        <ul
          className={`overflow-hidden transition-[max-height] duration-500 ease-in-out text-black ${
            check ? "max-h-[200px]" : "max-h-0"
          }`}
        >
          {data.map((e, i) => (
            <Link 
            href={e.link}
            className={`hover:translate-x-2 rounded-sm flex flex-row pl-10 p-2 cursor-pointer ${event_mouseover} text-base`} key={i}>
              <span>• {e.title}</span>
            </Link>
          ))}
        </ul>
    )
}


export const Dropdown = ({ item }) => {
  const [isOpen, setIsOpen] = useState(false);
  const if_submenu = Array.isArray(item.submenu) && item.submenu.length > 0;

  const iconMap = {
    Home: <AiFillAccountBook />,
    "Call Api": <AiFillAlert />,
    WorkFlows: <GoWorkflow />,
    Settings: <AiFillAliwangwang />,
  };

  return (
    <div
      id={`Dropdown_${item.title}`}
      className={`${Config.sidebar.container}`}
      onMouseEnter={() => setIsOpen(true)}
      onMouseLeave={() => setIsOpen(false)}
    >
      <div className={`${Config.sidebar.element}`}>
        <Link 
          href={item.link} 
          className={`flex flex-row items-center w-full p-2 ${event_mouseover} rounded text-lg text-black ${if_submenu ? "" : "hover:translate-x-2"}`}
        >
          {iconMap[item.title]}

          <span className="ml-2 flex flex-row items-center justify-between w-full">
            <b>{item.title}</b>
            {if_submenu && (
              <AiFillCaretRight
                className={`transition-transform duration-300 ${isOpen ? "rotate-90" : ""}`}
              />
            )}
          </span>
        </Link>
      </div>

      {if_submenu && <List check={isOpen} data={item.submenu} />}
    </div>
  );
};
]]

M.input = [[
"use client";
import { useState, useEffect } from "react";
import { TbXboxXFilled } from "react-icons/tb";
import { createPortal } from "react-dom";
import { FaRegEye } from "react-icons/fa";

interface InputProps {
  label: {
    errorDescription: string;
    field?: string;
  };
  options: {
    type: string;
    placeholder?: string;
  };
  mandatory: boolean;
}

// Popup con animazione di discesa
const Popup = ({ status, title, details, onClose }: { status: string; title: string; details: string; onClose: () => void }) => {
  const [popupVisible, setPopupVisible] = useState(false);

  useEffect(() => {
    setPopupVisible(true); // Attiva l'animazione

    const timer = setTimeout(() => {
      setPopupVisible(false);
      setTimeout(onClose, 500); // Attendi la fine dell'animazione prima di rimuoverlo
    }, 3000);

    return () => clearTimeout(timer);
  }, [onClose]);

  return createPortal(
    <div className="fixed inset-0 bg-opacity-50 flex justify-center z-50">
      <div
        className={`bg-white p-5 rounded-lg shadow-sm border-1 border-solid transition-transform duration-500 h-max ${
          popupVisible ? "translate-y-10 opacity-100" : "-translate-y-20"
        }`}
      >
        <div className="flex flex-row gap-3 text-black">
          {status=="error"&&<TbXboxXFilled className="text-xl text-red-500"/>}
          <span className="font-bold">{title}</span>
        </div>
        <div className="text-black">{details}</div>
      </div>
    </div>,
    document.body
  );
};

export function Input({ label, options, mandatory }: InputProps) {
  const [err, setErr] = useState("default");
  const [viewPassword, setViewPassword] = useState("password");
  const [showPopup, setShowPopup] = useState(false);

  const validation = (e) => {
    const { type, value, dataset } = e.target;
    let isValid = true;

    switch (type) {
      case "email":
        isValid = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]{2,}$/.test(value);
        if (!mandatory && value === "") isValid = true;
        break;

      case "password":
        isValid = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d$@$.!%*#?&]{16,}$/.test(value);
        break;
    }

    if (!isValid) {
      setErr(false);
      setShowPopup(true);
    } else {
      setErr(true);
    }
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="w-full flex justify-start gap-1 relative bottom-[-10px]">
        {label.field && <label className="text-small text-black">{label.field}</label>}
        {mandatory && <span className="text-red-600">*</span>}
      </div>
      <div className={`grid ${options.type=="password"?"grid-cols-10":"grid-cols-1"}`}>
        <input
          type={options.type}
          className={`border 
            ${options.type=="password"?"col-span-9":""} 
            focus:border-blue-500 p-2 outline-none rounded transition-all text-black duration-300
            ${err==false ? "border-red-400 hover:border-gray-200" : err==true ? "border-green-400" : "border-gray-200"}`}
          required={mandatory}
          placeholder={options.placeholder}
          onFocus={() => setErr("default")}
          onBlur={validation}
        />
        {options.type=="password"&&(
            <div className="col-span-1 flex items-center pl-3 cursor-pointer"
                onClick={(e)=>{
                    const I = e.target.parentElement.firstChild
                    console.log(I)
                    I.type = I.type=="password"?"text":"password"
                }}
                >
                <FaRegEye className="text-blue-800 text-3xl pointer-events-none"/>
            </div>
        )}
      </div>
      {showPopup && (
        <Popup
          status="error"
          title="Email e/o password non corretti"
          details={label.errorDescription}
          onClose={() => setShowPopup(false)}
        />
      )}
    </div>
  );
}
]]


return M
