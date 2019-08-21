import Knex = require('knex');

export class LevelModels {
    listall(knex: Knex) {
        return knex('rep_levels')
    }

    add(knex: Knex, data: any) {
        return knex('rep_levels')
            .insert(data);
    }

    update(knex: Knex, level_id: any, data: any) {
        return knex('rep_levels')
            .where('level_id', level_id)
            .update(data);
    }

    del(knex: Knex, level_id: any) {
        return knex('rep_levels')
            .where('level_id', level_id)
            .del();
    }

}