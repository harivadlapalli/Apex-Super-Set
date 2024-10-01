import { api, LightningElement } from 'lwc';

export default class Child extends LightningElement {
    @api parentMessage; // Correctly binding the message
}

