import Knex = require('knex');

export class Hl7Models {

  getLastVn(knex: Knex, PID: any) {
    return knex.raw(`selct max(vn) from ovst where hn = ${PID} and date(vstdttm) = date(now())`)
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

  updateBP(knex: Knex, vn: any, _info: any) {
    return knex.raw(`update ovst set dbp = ${_info.DIASTOLIC},sbp = ${_info.SYSTOLIC}, pr= ${_info.PULSE} where vn = ${vn}`);
  }

  updateBW(knex: Knex, vn: any, _info: any) {
    return knex.raw(`update ovst set bw = ${_info.WEIGHT},height = ${_info.HEIGHT}, bmi= ${_info.BMI} where vn = ${vn}`);
  }
  updateBP_o(knex: Knex, vn: any, _info: any, table: any) {
    return knex.raw(`update ${table} set dbp = ${_info.DIASTOLIC},sbp = ${_info.SYSTOLIC}, pr= ${_info.PULSE} where vn = ${vn}`);
  }

  updateBW_o(knex: Knex, vn: any, _info: any, table: any) {
    return knex.raw(`update ${table} set bw = ${_info.WEIGHT},height = ${_info.HEIGHT}, bmi= ${_info.BMI} where vn = ${vn}`);
  }
}