import Knex = require('knex');

export class MenuItemModels {
  listall(knex: Knex) {
    return knex('rep_menu_item')

  }

  selectgroup(knex: Knex, querygroups: any) {
    return knex('rep_menu_item')
      .whereIn('item_id', querygroups)
  }

  listone(knex: Knex, menu_id: any) {
    return knex('rep_menu_item')
      .where('menu_id', menu_id);
  }

  add(knex: Knex, data: any) {
    return knex('rep_menu_item')
      .insert(data);
  }

  update(knex: Knex, item_id: any, data: any) {
    return knex('rep_menu_item')
      .where('item_id', item_id)
      .update(data);
  }

  del(knex: Knex, item_id: any) {
    return knex('rep_menu_item')
      .where('item_id', item_id)
      .del();
  }

}