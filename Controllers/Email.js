const Email = require('../Models/Email');

module.exports = class EmailController {
    static async getEmailById(req, res) {
        const id = req.params.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Email.getEmailByID(id);

        res.status(result.status).json(result.body);
    }

    static async getEmailsByAA(req, res) {
        const id = req.params.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Email.getEmailsByAA(id);

        res.status(result.status).json(result.body);
    }

    static async delete(req, res) {
        const id = req.body.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Email.delete(id);

        res.status(result.status).json(result.body);
    }

    static async create(req, res) {
        if(!req.body.email || !req.body.principal || !req.body.idaa) {
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const email = new Email(req.body.email, req.body.principal, req.body.idaa);

        const result = await email.create();
        res.status(result.status).json(result.body);
    }

    static async update(req, res) {
        if(!req.body.id, !req.body.email || !req.body.principal || !req.body.idaa) {
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const email = new Email(req.body.email, req.body.principal, req.body.idaa, req.body.id);

        const result = await email.update();
        res.status(result.status).json(result.body);
    }
}