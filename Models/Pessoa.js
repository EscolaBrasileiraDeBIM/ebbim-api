const pool = require('../db/conn');
const Response = require('../helpers/response');

module.exports = class Pessoa {
    constructor({id, nome, apelido, razaoSocial, estrangeiro, genero, pf, cpfCnpj, inscricaoEstadual, inscricaoMunicipal, fornecedor, empresa, comentario, rg, nascimento}){
        this.id = id;
        this.nome = nome;
        this.apelido = apelido;
        this.razaoSocial = razaoSocial;
        this.estrangeiro = estrangeiro;
        this.genero = genero;
        this.pf = pf;
        this.cpfCnpj = cpfCnpj;
        this.inscricaoEstadual = inscricaoEstadual;
        this.inscricaoMunicipal = inscricaoMunicipal;
        this.fornecedor = fornecedor;
        this.empresa = empresa;
        this.comentario = comentario;
        this.rg = rg;
        this.nascimento = nascimento;
    }

    static async getPessoaById(id) {
        const query = "SELECT * FROM aa_pessoas WHERE cd_pessoa = '" + id+"'";

        try {
            const [result, columns] = await pool.execute(query);

            if(Object.keys(result).length === 0) {
                const res = new Response(404, {
                    message: "Not Found"
                });
            
                return res;
            } else {
                const res = new Response(201, {
                    message: "Found",
                    data: result[0]
                });
            
                return res;
            }
        } catch(err) {
            const res = new Response(500, {message: err});
            return res;
        }
    }

    static async delete(id) {
        const query = "DELETE FROM aa_pessoas WHERE cd_pessoa = '"+id+"'";

        try {
            await pool.execute(query);
            const res = new Response(200, {
                message: "Deleted"
            });
        
            return res;
        } catch (err) {
            const res = new Response(404, {
                message: err
            });
        
            return res;
        }
    }

    async create() {
        try {
            const query = "SELECT max(cd_pessoa) as maxId FROM aa_pessoas";
            const [result, columns] = await pool.execute(query);
            const maxId = result[0].maxId ?? "AA00000";
            const newNum = parseInt(maxId.substring(2)) + 1;
            const newId = "AA".concat(newNum.toString().padStart(5,'0'));
            this.id = newId;
        } catch(err) {
            const res = new Response(500, {
                message: "Can't create new ID_AA: "+err
            });
            return res;
        }

        try {
            this.prepareForQuery();

            const query = "INSERT INTO aa_pessoas VALUES ("+this.id+","+this.nome+","+this.apelido+","+this.razaoSocial+","+this.estrangeiro+","+this.genero+","+this.pf+","+this.cpfCnpj+","+this.inscricaoEstadual+","+this.inscricaoMunicipal+","+this.fornecedor+","+this.empresa+","+this.comentario+","+this.rg+","+this.nascimento+");";

            await pool.execute(query);

            this.restoreValues();
            
            const res = new Response(201, {
                message: "Created",
                data: this
            });
            return res;
        } catch(err) {
            const res = new Response(500, {
                message: "Can't create new Person: "+err
            });
            return res;
        }
    }

    async update() {
        try {
            this.prepareForQuery();

            const query = "UPDATE aa_pessoas SET nm_pessoa="+this.nome+",nm_apelido="+this.apelido+",nm_razao_social="+this.razaoSocial+",ic_estrangeiro="+this.estrangeiro+",ic_genero="+this.genero+",ic_pf="+this.pf+",cd_cpf_cnpj="+this.cpfCnpj+",cd_inscricao_estadual="+this.inscricaoEstadual+",cd_inscricao_municipal="+this.inscricaoMunicipal+",nm_fornecedor="+this.fornecedor+",nm_empresa="+this.empresa+",ds_comentario="+this.comentario+",cd_rg="+this.rg+",dt_nascimento="+this.nascimento+" WHERE cd_pessoa="+this.id+"";

            await pool.execute(query);

            this.restoreValues();
            
            const res = new Response(201, {
                message: "Updated",
                data: this
            });
            return res;
        } catch(err) {
            const res = new Response(500, {
                message: "Can't create new Person: "+err
            });
            return res;
        }
    }

    static async login(email, senha){
        const query = "SELECT * FROM tb_usuario WHERE cd_login = '" +email+"' AND nm_senha = '"+senha+"'";

        try {
            const [result, columns] = await pool.execute(query);

            if(Object.keys(result).length === 0) {
                const res = new Response(404, {
                    message: "Not Found"
                });
            
                return res;
            } else {
                const res = new Response(201, {
                    message: "Found",
                    data: result[0]
                });
            
                return res;
            }
        } catch(err) {
            const res = new Response(500, {message: err});
            return res;
        }
    }

    prepareForQuery() {
        this.id = this.id ? "'"+this.id+"'" : null;
        this.nome = this.nome ? "'"+this.nome+"'" : null;
        this.apelido = this.apelido ? "'"+this.apelido+"'" : null;
        this.razaoSocial = this.razaoSocial ? "'"+this.razaoSocial+"'" : null;
        this.estrangeiro = this.estrangeiro ? this.estrangeiro : null;
        this.genero = this.genero ? "'"+this.genero+"'" : null;
        this.cpfCnpj = this.cpfCnpj ? "'"+this.cpfCnpj+"'" : null;
        this.inscricaoEstadual = this.inscricaoEstadual ? this.inscricaoEstadual : null;
        this.inscricaoMunicipal = this.inscricaoMunicipal ? this.inscricaoMunicipal : null;
        this.fornecedor = this.fornecedor ? "'"+this.fornecedor+"'" : null;
        this.empresa = this.empresa ? "'"+this.empresa+"'" : null;
        this.comentario = this.comentario ? "'"+this.comentario+"'" : null;
        this.rg = this.rg ? "'"+this.rg+"'" : null;
        this.nascimento = this.nascimento ? "'"+this.nascimento+"'" : null;
    }

    restoreValues() {
        this.id = this.id ? this.id.replaceAll("'", "") : null;
        this.nome = this.nome ? this.nome.replaceAll("'", "") : null;
        this.apelido = this.apelido ? this.apelido.replaceAll("'", "") : null;
        this.razaoSocial = this.razaoSocial ? this.razaoSocial.replaceAll("'", "") : null;
        this.estrangeiro = this.estrangeiro ? this.estrangeiro : null;
        this.genero = this.genero ? this.genero.replaceAll("'", "") : null;
        this.cpfCnpj = this.cpfCnpj ? this.cpfCnpj.replaceAll("'", "") : null;
        this.inscricaoEstadual = this.inscricaoEstadual ? this.inscricaoEstadual : null;
        this.inscricaoMunicipal = this.inscricaoMunicipal ? this.inscricaoMunicipal : null;
        this.fornecedor = this.fornecedor ? this.fornecedor.replaceAll("'", "") : null;
        this.empresa = this.empresa ? this.empresa.replaceAll("'", "") : null;
        this.comentario = this.comentario ? this.comentario.replaceAll("'", "") : null;
        this.rg = this.rg ? this.rg.replaceAll("'", "") : null;
        this.nascimento = this.nascimento ? this.nascimento.replaceAll("'", "") : null;
    }
}