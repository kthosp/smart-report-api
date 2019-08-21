/// <reference path="../../typings.d.ts" />

import * as Knex from 'knex';
import * as fastify from 'fastify';
import * as http from 'http'
import * as HttpStatus from 'http-status-codes';

import { SubMenuItemModels } from '../models/sub_item';
import { parse } from 'querystring';

const subMenuItemModels = new SubMenuItemModels();

const router = (fastify, { }, next) => {

  var db: Knex = fastify.db;

  fastify.get('/', async (req: fastify.Request, reply: fastify.Reply) => {
    reply.code(200).send({ message: 'Welcome to SMART HIS API SMART REPORT HIS!', version: '1.0 build 20190820-1' })
  });

  next();

  fastify.get('/info', async (req: fastify.Request, reply: fastify.Reply) => {

    try {
      const rs: any = await subMenuItemModels.listall(db);
      reply.status(HttpStatus.OK).send({ statusCode: HttpStatus.OK, info: rs, });
    } catch (error) {
      fastify.log.error(error);
      reply.status(HttpStatus.INTERNAL_SERVER_ERROR).send({ statusCode: HttpStatus.INTERNAL_SERVER_ERROR, message: HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR) })
    }
  })

  fastify.get('/selectItem/:sub_item_id', async (req: fastify.Request, reply: fastify.Reply) => {
    const sub_item_id = req.params.sub_item_id;

    try {
      const rs: any = await subMenuItemModels.listone(db, sub_item_id);
      reply.status(HttpStatus.OK).send({ statusCode: HttpStatus.OK, info: rs, });
    } catch (error) {
      fastify.log.error(error);
      reply.status(HttpStatus.INTERNAL_SERVER_ERROR).send({ statusCode: HttpStatus.INTERNAL_SERVER_ERROR, message: HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR) })
    }
  })
  fastify.get('/select/:item_id/:userLevel', async (req: fastify.Request, reply: fastify.Reply) => {
    const item_id = req.params.item_id;
    const userLevel = req.params.userLevel;
    try {
      const rs: any = await subMenuItemModels.listtwo(db, item_id, userLevel);
      reply.status(HttpStatus.OK).send({ statusCode: HttpStatus.OK, info: rs, });
    } catch (error) {
      fastify.log.error(error);
      reply.status(HttpStatus.INTERNAL_SERVER_ERROR).send({ statusCode: HttpStatus.INTERNAL_SERVER_ERROR, message: HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR) })
    }
  })

}

module.exports = router;