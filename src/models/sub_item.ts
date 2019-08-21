import Knex = require('knex');

export class SubMenuItemModels {
  tableName: string = 'rep_sub_menu_item';

  listall(knex: Knex) {
    return knex(this.tableName)
      .orderBy('sub_item_id', 'DESC');
  }

  selectsub(knex: Knex) {
    return knex.select('main_query_id').from(this.tableName)

  }

  select(knex: Knex, data: any) {
    return knex(this.tableName)
      .whereNotIn('sub_item_id', data)

  }

  insert(knex: Knex, data: any) {
    return knex(this.tableName)
      .insert(data);

  }

  listone(knex: Knex, sub_item_id: any) {
    return knex(this.tableName)
      .where('sub_item_id', sub_item_id);

  }

  listtwo(knex: Knex, item_id: any, userLevel: any) {
    return knex(this.tableName)
      .where('item_id', item_id)
      .andWhere(function () {
        this.where('level_id', '<=', userLevel)
          .orWhere(function () {
            this.orWhere('level_id', '=', '0')
              .orWhere('level_id', '=', '')
              .orWhereNull('level_id')
          })
      })
  }

  add(knex: Knex, data: any) {
    return knex(this.tableName)
      .insert(data);
  }

  update(knex: Knex, sub_item_id: any, data: any) {
    return knex(this.tableName)
      .where('sub_item_id', sub_item_id)
      .update(data);
  }

  del(knex: Knex, sub_item_id: any) {
    return knex(this.tableName)
      .where('sub_item_id', sub_item_id)
      .del();
  }

}