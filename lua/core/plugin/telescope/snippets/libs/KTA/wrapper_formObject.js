class myForm {
    constructor(type){
        this.type = type
    }
    public get(name){
        if(this.type == "control"){
            return Forms.SDK.GetFormControlValue(name)
        }
        else if(this.type == "variable"){
            return Forms.SDK.GetFormVariableValue(name)
        }
        else{ return new Error(`type = [control, variable] not ${this.type}`) }
    }
    public set(name, value){
        if(this.type == "control"){
            return Forms.SDK.SetFormControlValue(name, value)
        }
        else if(this.type == "variable"){
            return Forms.SDK.SetFormVariableValue(name, value)
        }
        else{ return new Error(`type = [control, variable] not ${this.type}`) }
    }
}
