function Create(tag, styles = {}, props = {}) {
    const element = document.createElement(tag);
    Object.assign(element.style, styles);
    for (let key in props) {
        if (key === "class") {
            props[key].forEach(className => element.classList.add(className));
        } 
        else { element.setAttribute(key, props[key]); }
    }
    return element;
}
