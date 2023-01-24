
module.exports = class Response {
    constructor (status, {message, data}) {
        this.status = status;
        this.body = {message, data};
    }
}