/// <reference path="../../typings.d.ts" />

import * as knex from 'knex';
import * as fastify from 'fastify';
import * as HttpStatus from 'http-status-codes';
import * as moment from 'moment'

const router = (fastify, { }, next) => {
  var db: knex = fastify.db;

  fastify.get('/', async (req: fastify.Request, reply: fastify.Reply) => {
    const hl7v2 = require('@redoxengine/redox-hl7-v2');
    const parser = new hl7v2.Parser();
    var hl7Message = `MSH|^~\&|LABOLINK||HIS||20151013104430||ORU^R01|1001|P|2.3\rPID|1||000\rOBR|1|||||20151013104427||||||||20151013104430\rOBX|1|NM|SYSTOLIC||100|mmHg|||||F|||20151013104427\rOBX|2|NM|DIASTOLIC||100|mmHg|||||F|||20151013104427\rOBX|3|NM|PULSE||100|bpm|||||F|||20151013104427\rOBX|4|NM|HEIGHT||150.0|cm|||||F|||20151013104428\rOBX|5|NM|WEIGHT||50.0|kg|||||F|||20151013104428\rOBX|6|NM|BMI||22.22222222222222|kg/m2|||||F|||20151013104428\rOBX|7|NM|SPO2||95.0|%|||||F|||20151013104429\rOBX|8|NM|TEMP||25.0|C|||||F|||20151013104429`;

    const jsonData = parser.parse(hl7Message);
    // console.log(jsonData);
    // console.log(jsonData.PATIENT_RESULT);
    // console.log(jsonData.PATIENT_RESULT[0].PATIENT.PID);
    // console.log(jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION);
    let pid = jsonData.PATIENT_RESULT[0].PATIENT.PID[3];
    let order = jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION;
    let colum = jsonData.MSH[3][1];
    let row = jsonData.MSH[7][1]
    var msh = {
      msh: [colum, row],
    }
    reply.status(HttpStatus.OK).send({ statusCode: HttpStatus.OK, MSH: msh, PID: pid, ORDERE: order });

  });


  fastify.post('/', async (req: fastify.Request, reply: fastify.Reply) => {
    const hl7v2 = require('@redoxengine/redox-hl7-v2');
    const parser = new hl7v2.Parser();
    var isodate = new Date().toISOString();
    const thDate = `${(moment(isodate).get('year') + 543) - 2500}`;

    var table = 'o' + moment(isodate).format('DDMM') + thDate;
    const jsonData = parser.parse(req.body.hl7);
    console.log(jsonData);

    var info = {
      MSH: [jsonData.MSH[3][1], jsonData.MSH[7][1]],
      PID: [jsonData.PATIENT_RESULT[0].PATIENT.PID[3][0][1]],
      OBR: [
        jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBR[6][1],
        jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBR[14][1]
      ],
      OBSERVATION: {
        OBX0:
          [
            jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[0].OBX[3][1],
            jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[0].OBX[5][0],
            jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[0].OBX[6][1],
            jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[0].OBX[14][1]
          ]
        ,
        OBX1: [
          jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[1].OBX[3][1],
          jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[1].OBX[5][0],
          jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[1].OBX[6][1],
          jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[1].OBX[14][1]
        ],
        OBX2: [
          jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[2].OBX[3][1],
          jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[2].OBX[5][0],
          jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[2].OBX[6][1],
          jsonData.PATIENT_RESULT[0].ORDER_OBSERVATION[0].OBSERVATION[2].OBX[14][1]
        ]
      },
    }

    reply.status(HttpStatus.OK).send({ statusCode: HttpStatus.OK, info: info });

  });

  next();

}

module.exports = router;