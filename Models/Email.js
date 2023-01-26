const pool = require('../db/conn');
const Response = require('../helpers/response');

module.exports = class Email {
    constructor({id, email, principal, idaa}) {
        this.id = id;
        this.email = email;
        this.principal = principal;
        this.idaa = idaa;       
    }

    static async getEmailByID(id){
        const query = "SELECT * FROM ab_email WHERE cd_email = '" + id+"'";

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

    static async getEmailsByAA(id) {
        const query = "SELECT * FROM ab_email WHERE cd_pessoa = '" + id+"'";

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
        const query = "DELETE FROM ab_email WHERE cd_email = '"+id+"'";

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
        const query = "DELETE FROM ab_email WHERE cd_pessoa = '"+id+"'";

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
            const query = "SELECT max(cd_email) as maxId FROM ab_email";
            const [result, columns] = await pool.execute(query);
            const maxId = result[0].maxId ?? "AB00000";
            const newNum = parseInt(maxId.substring(2)) + 1;
            const newId = "AB".concat(newNum.toString().padStart(5,'0'));
            this.id = newId;
        } catch(err) {
            const res = new Response(500, {
                message: "Can't create new ID_AB: "+err
            });
            return res;
        }

        try {
            this.prepareQuery();
            const query = "INSERT INTO ab_email VALUES ("+this.id+","+this.email+","+this.principal+","+this.idaa+")";
            await pool.execute(query);
            this.restoreValues();

            const res = new Response(201, {
                message: "Created",
                data: this
            });
            return res;
        } catch(err) {
            const res = new Response(500, {
                message: "Can't create new Email: "+err
            });
            return res;
        }
    }

    async update() {
        try {
            this.prepareQuery();
            const query = "UPDATE ab_email SET nm_email = "+this.email+", ic_principal = "+this.principal+", cd_pessoa = "+this.idaa+" WHERE cd_email = "+this.id+"";
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

    prepareQuery() {
        this.id = this.id ? "'"+this.id+"'" : null;
        this.email = this.email ? "'"+this.email+"'" : null;
        this.principal = this.principal ? "'"+this.principal+"'" : null;
        this.idaa = this.idaa ? "'"+this.idaa+"'" : null;
    }

    restoreValues(){
        this.id = this.id ? this.id.replaceAll("'", "") : null;
        this.email = this.email ? this.email.replaceAll("'", "") : null;
        this.principal = this.principal ? this.principal.replaceAll("'", "") : null;
        this.idaa = this.idaa ? this.idaa.replaceAll("'", "") : null;
    }
}