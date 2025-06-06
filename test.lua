local now = os.date("*t")

function addZero(value)
    local v = tostring(value)
    if #v == 1 then return "0"..v 
    else return v
    end
end

print(addZero(now["day"]).."-"..addZero(now["month"]).."-"..now["year"])
