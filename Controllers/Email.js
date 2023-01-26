const Email = require('../models/Email');

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

    static async deleteById(req, res) {
        const id = req.body.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Email.deleteById(id);

        res.status(result.status).json(result.body);
    }

    static async deleteByAa(req, res) {
        const id = req.body.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Email.deleteByAa(id);

        res.status(result.status).json(result.body);
    }

    static async create(req, res) {
        if(!req.body.email || !req.body.principal || !req.body.idaa) {
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const email = new Email({
            email: req.body.email, 
            principal: req.body.principal, 
            idaa: req.body.idaa
        });

        const result = await email.create();
        res.status(result.status).json(result.body);
    }

    static async update(req, res) {
        if(!req.body.id, !req.body.email || !req.body.principal || !req.body.idaa) {
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const email = new Email({
            id: req.body.id,
            email: req.body.email, 
            principal: req.body.principal, 
            idaa: req.body.idaa
        });

        const result = await email.update();
        res.status(result.status).json(result.body);
    }
}