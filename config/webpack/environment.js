const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const alias =  require('./alias/alias')

environment.config.merge(alias)
environment.loaders.append('vue', vue)
module.exports = environment
