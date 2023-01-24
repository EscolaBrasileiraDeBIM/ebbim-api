const Telefone = require('../models/Telefone');

module.exports = class TelefoneController {
    static async getTelefoneById(req, res) {
        const id = req.params.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Telefone.getTelefoneByID(id);

        res.status(result.status).json(result.body);
    }

    static async getTelefonesByAA(req, res) {
        const id = req.params.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Telefone.getTelefonesByAA(id);

        res.status(result.status).json(result.body);
    }

    static async deleteById(req, res) {
        const id = req.body.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Telefone.deleteById(id);

        res.status(result.status).json(result.body);
    }

    static async deleteByAa(req, res) {
        const id = req.body.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Telefone.deleteByAa(id);

        res.status(result.status).json(result.body);
    }

    static async create(req, res) {
        if(!req.body.numero || !req.body.idaa) {
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const telefone = new Telefone({
            id: req.body.id,
            tipo: req.body.tipo,
            ddi: req.body.ddi,
            ddd: req.body.ddd,
            numero: req.body.numero,
            ramal: req.body.ramal,
            idaa: req.body.idaa,
        });

        const result = await telefone.create();
        res.status(result.status).json(result.body);
    }

    static async update(req, res) {
        if(!req.body.id || !req.body.numero || !req.body.idaa) {
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const telefone = new Telefone({
            id: req.body.id,
            tipo: req.body.tipo,
            ddi: req.body.ddi,
            ddd: req.body.ddd,
            numero: req.body.numero,
            ramal: req.body.ramal,
            idaa: req.body.idaa,
        });

        const result = await telefone.update();
        res.status(result.status).json(result.body);
    }
}