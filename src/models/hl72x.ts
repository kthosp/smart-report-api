import Knex = require('knex');

export class Hl7Models {
  getLastVn(knex: Knex, PID: any) {
    return knex('ovst')
      .select('vn')
      .max('vn')
      .where('hn', PID)
  }

  getPID(knex: Knex, CID: any) {
    return knex('pt')
      .select('hn')
      .where('pop_id', CID)
  }

  update(knex: Knex, vn: any, data: any) {
    return knex('ovst')
      .where('vn', vn)
      .update(data);
  }

  updateBP(knex: Knex, vn: any, DIASTOLIC: any, SYSTOLIC: any, PULSE: any) {
    return knex.raw(`update ovst set dbp = ${DIASTOLIC},sbp = ${SYSTOLIC}, pr= ${PULSE} where vn = ${vn}`);
  }

  updateBW(knex: Knex, vn: any, WEIGHT: any, HEIGHT: any, BMI: any) {
    return knex.raw(`update ovst set bw = ${WEIGHT},height = ${HEIGHT}, bmi= ${BMI} where vn = ${vn}`);
  }
  updateBP_o(knex: Knex, vn: any, DIASTOLIC: any, SYSTOLIC: any, PULSE: any, table: any) {
    return knex.raw(`update ${table} set dbp = ${DIASTOLIC},sbp = ${SYSTOLIC}, pr= ${PULSE} where vn = ${vn}`);
  }

  updateBW_o(knex: Knex, vn: any, WEIGHT: any, HEIGHT: any, BMI: any, table: any) {
    return knex.raw(`update ${table} set bw = ${WEIGHT},height = ${HEIGHT}, bmi= ${BMI} where vn = ${vn}`);
  }
}