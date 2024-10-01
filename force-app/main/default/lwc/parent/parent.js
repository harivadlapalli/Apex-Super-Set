import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {
    message = 'Hello from Parent!'; // Message to pass to child

    ifvalchange(event){
        this.message=event.target.value;
    }
    
}

