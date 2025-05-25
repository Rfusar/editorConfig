local M = {}

M.navbar_config = [[
{
    "Style": "flex flex-row justify-around items-center w-full bg-white h-[8%] shadow-sm",
    "Data": {
        "Header": {"logo": "", "title":"MySite"},
        "Session": [
            {
                "title": "Msg",
                "submenu": [
                    "Send", "Read"
                ]
            },
            {
                "title": "Profile"
            }
        ]
    }
}
]]

M.navbar = [[
import Config from "./config.json"
//import {Dropdown} from "@/mylib/dropdown/init"
import { CgProfile } from "react-icons/cg";
import { MdEmail } from "react-icons/md";

const LayoutNavbar = Config.Style

export default function Navbar() {
    return (
        <nav className={LayoutNavbar}>
            <div className="w-full h-full flex flex-1 items-center justify-center text-black">
                <span>{Config.Data.Header.title}</span>
            </div>
            <div className="w-full h-full flex flex-1 text-black">
                <div className="flex-1"></div>
                <div className="flex flex-1 flex-row items-center gap-3">
                {Config.Data.Session.map((e, i)=>(
                    <span key={i}>
                        {e.title=="Msg"&&<MdEmail className="cursor-pointer size-8"/>}
                        {e.title=="Profile"&&<CgProfile className="cursor-pointer size-8"/>}
                    </span>
                ))} 
                </div>
            </div>
        </nav>
    )
}
]]


M.sidebar_config= [[
{
    "Style": "w-[12%] bg-white border-1 border-gray-100 border-solid h-screen shadow-sm",
    "Data": {
        "Header": {"logo": "", "title":"MySite"},
        "list": [
            {
                "title": "Home",
                "link": "/",
                "submenu": [
                ]
            },
            {
                "title": "Settings",
                "link": "",
                "submenu": [
                    {"title": "Profile", "link": "/user/public"}
                ]
            }
        ]
    }
}
]]

M.sidebar = [[
import Config from "./config.json"
import {Dropdown} from "@/mylib/dropdown/init"


const LayoutSidebar = Config.Style

export default function Sidebar() {
    return (
        <aside className={LayoutSidebar}>
            <div className="w-full h-[15%]">
            </div>
            {Config.Data.list.map((e, i)=>(
                <Dropdown key={i} item={e} />
            ))} 
        </aside>
    )
}
]]

return M
