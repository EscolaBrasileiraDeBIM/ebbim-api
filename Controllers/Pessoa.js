const Pessoa = require('../models/Pessoa');

module.exports = class PessoaController {
    static async getPessoaById(req, res) {
        const id = req.params.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Pessoa.getPessoaById(id);

        res.status(result.status).json(result.body);
    }

    static async create(req, res) {
        if(!req.body.nome || !req.body.pf || !req.body.genero){
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const pessoa = new Pessoa({
            nome: req.body.nome,
            apelido: req.body.apelido,
            razaoSocial: req.body.razaoSocial,
            estrangeiro: req.body.estrangeiro,
            genero: req.body.genero,
            pf: req.body.pf,
            cpfCnpj: req.body.cpfCnpj,
            inscricaoEstadual: req.body.inscricaoEstadual,
            inscricaoMunicipal: req.body.inscricaoMunicipal,
            fornecedor: req.body.fornecedor,
            empresa: req.body.empresa,
            comentario: req.body.comentario,
            rg: req.body.rg,
            nascimento: req.body.nascimento
        });

        const result = await pessoa.create();

        res.status(result.status).json(result.body);
    }

    static async delete(req, res) {
        const id = req.body.id;

        if(!id) {
            res.status(400).json({message: "Parâmetro incorreto"});
            return;
        }

        const result = await Pessoa.delete(id);

        res.status(result.status).json(result.body);
    }

    static async update(req, res) {
        if(!req.body.id || !req.body.nome || !req.body.pf || !req.body.genero){
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const pessoa = new Pessoa({
            id: req.body.id,
            nome: req.body.nome,
            apelido: req.body.apelido,
            razaoSocial: req.body.razaoSocial,
            estrangeiro: req.body.estrangeiro,
            genero: req.body.genero,
            pf: req.body.pf,
            cpfCnpj: req.body.cpfCnpj,
            inscricaoEstadual: req.body.inscricaoEstadual,
            inscricaoMunicipal: req.body.inscricaoMunicipal,
            fornecedor: req.body.fornecedor,
            empresa: req.body.empresa,
            comentario: req.body.comentario,
            rg: req.body.rg,
            nascimento: req.body.nascimento
        });

        const result = await pessoa.update();

        res.status(result.status).json(result.body);
    }

    static async login(req, res) {
        if(!req.body.login || !req.body.senha){
            res.status(400).json({message: "Parâmetros incorretos"});
            return;
        }

        const result = await Pessoa.login(req.body.login, req.body.senha);

        res.status(result.status).json(result.body);
    }
}