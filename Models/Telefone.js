const pool = require('../db/conn');
const Response = require('../helpers/response');

module.exports = class Telefone {
    constructor({id, tipo, ddi, ddd, numero, ramal, idaa}) {
        this.id = id;
        this.tipo = tipo;
        this.ddi = ddi;
        this.ddd = ddd;
        this.numero = numero;
        this.ramal = ramal;
        this.idaa = idaa;
    }

    static async getTelefoneByID(id){
        const query = "SELECT * FROM ac_telefone WHERE cd_telefone = '" +id+"'";

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

    static async getTelefonesByAA(id) {
        const query = "SELECT * FROM ac_telefone WHERE cd_pessoa = '" + id+"'";

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
                    data: result
                });
            
                return res;
            }
        } catch(err) {
            const res = new Response(500, {message: err});
            return res;
        }
    }

    static async deleteById(id) {
        const query = "DELETE FROM ac_telefone WHERE cd_telefone = '"+id+"'";

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

    static async deleteByAa(id) {
        const query = "DELETE FROM ac_telefone WHERE cd_pessoa = '"+id+"'";

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
            const query = "SELECT max(cd_telefone) as maxId FROM ac_telefone";
            const [result, columns] = await pool.execute(query);
            const maxId = result[0].maxId ?? "AC00000";
            const newNum = parseInt(maxId.substring(2)) + 1;
            this.id = "AC".concat(newNum.toString().padStart(5,'0'));
        } catch(err) {
            const res = new Response(500, {
                message: "Can't create new ID_AC: "+err
            });
            return res;
        }

        try {
            this.prepareQuery();
            const query = "INSERT INTO ac_telefone VALUES ("+this.id+", "+this.tipo+", "+this.ddi+","+this.ddd+","+this.numero+", "+this.ramal+", "+this.idaa+")";
            await pool.execute(query);

            this.restoreValues();

            const res = new Response(201, {
                message: "Created",
                data: this
            });
            return res;
        } catch(err) {
            const res = new Response(500, {
                message: "Can't create new Telefone: "+err
            });
            return res;
        }
    }

    async update() {
        try {
            this.prepareQuery();
            const query = "UPDATE ac_telefone SET nm_tipo="+this.tipo+",cd_ddi="+this.ddi+",cd_ddd="+this.ddd+",cd_numero="+this.numero+",cd_ramal="+this.ramal+",cd_pessoa="+this.idaa+" WHERE cd_telefone="+this.id+"";
            await pool.execute(query);

            this.restoreValues();

            const res = new Response(200, {
                message: "Updated",
                data: this
            });
            return res;
        } catch(err) {
            const res = new Response(500, {
                message: err
            });
            return res;
        }
    }

    prepareQuery(){        
        this.id = this.id ? "'"+this.id+"'" : null;
        this.tipo = this.tipo ? "'"+this.tipo+"'" : null;
        this.ddi = this.ddi ? "'"+this.ddi+"'" : null;
        this.ddd = this.ddd ? "'"+this.ddd+"'" : null;
        this.numero = this.numero ? "'"+this.numero+"'" : null;;
        this.ramal = this.ramal ? "'"+this.ramal+"'" : null;
        this.idaa = this.idaa ? "'"+this.idaa+"'" : null;
    }

    restoreValues() {
        this.id = this.id ? this.id.replaceAll("'", "") : null;
        this.tipo = this.tipo ? this.tipo.replaceAll("'", "") : null;
        this.ddi = this.ddi ? this.ddi.replaceAll("'", "") : null;
        this.ddd = this.ddd ? this.ddd.replaceAll("'", "") : null;
        this.numero = this.numero ? this.numero.replaceAll("'", "") : null;
        this.ramal = this.ramal ? this.ramal.replaceAll("'", "") : null;
        this.idaa = this.idaa ? this.idaa.replaceAll("'", "") : null;
    }
}