const path = require('path')
var ttf2woff2 = require("ttf2woff2");
var isTtf = require('is-ttf');
var through = require('through2');
var deflate = require('pako').deflate;
var _ = require('lodash');

module.exports = function(opts) {
    opts = _.extend({ clone: true }, opts);

    function compileTtf(buffer, options, cb) {
        var output;
        var ttf2woffOpts = {};

        if (options.deflate) {
            ttf2woffOpts.deflate = deflate;
        }

        try {
            output = ttf2woff2(buffer);
        } catch (ex) {
            cb(ex);
        }

        output && cb(null, output);
    }

    return through.ctor({
        objectMode: true
    }, function(file, enc, cb) {

        // check null
        if (file.isNull()) {
            cb(null, file);
            return;
        }

        // check stream
        if (file.isStream()) {
            cb(new Error('Streaming is not supported'));
            return;
        }

        // check ttf
        if (!isTtf(file.contents)) {
            cb(null, file);
            return;
        }

        // clone
        if (opts.clone) {
            this.push(file.clone(false));
        }

        // replace ext
        file.path = path.join(path.dirname(file.path), path.basename(file.path, path.extname(file.path)) + ".woff2");

        compileTtf(file.contents, opts, function(err, buffer) {

            if (err) {
                cb(err);
                return;
            }

            file.contents = buffer;
            cb(null, file);
        });

    });
};
