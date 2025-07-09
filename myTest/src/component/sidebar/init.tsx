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
