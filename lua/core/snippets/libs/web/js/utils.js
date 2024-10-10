function Create({tag, style = {}, props = {}, event=null}) {
    const element = document.createElement(tag)
    Object.assign(element.style, style)
    for (let key in props) {
        if (key === "class") { props[key].forEach(className => element.classList.add(className)) } 
        else { Object.assign(element, props) }
    }
    if(event){element.addEventListener(event["type"], event["func"])}
    return element
}
