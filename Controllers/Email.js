module.exports = class EmailController {
    static get(req, res) {
        // const id = req.params.id;
        // res.json({
        //     message: id+'Controller'
        // })

        res.json({
            message: 'Controller'
        })
    }

    static getA(req, res) {
        // const id = req.params.id;
        // res.json({
        //     message: id+'Controller'
        // })
        const id = req.params.id;
        res.json({
            message: 'ControllerA'+id
        })
    }
}