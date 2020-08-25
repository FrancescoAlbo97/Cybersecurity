const mongoose = require('mongoose');

const ImageDataSchema = mongoose.Schema({
    url: {
        type: String,
        required: true
    },
    result: {
        tags: [{
            confidence: {
                type: Number,
                required: true
            },
            tag: {
                en: {
                    type: String,
                    required: true
                }
            }
        }],
        status: {
            text: {
                type: String,
                required: false
            },
            type: {
                type: String,
                required: true
            }

        }
    }
});

module.exports = mongoose.model('ImageDataSchema', ImageDataSchema);