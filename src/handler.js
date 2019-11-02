'use strict';

exports.demo = (request, response, context) => {
    const responseObject = {
        message: 'Hello Function Compute :)'
    };

    response.setStatusCode(200);
    response.setHeader('Content-Type', 'application/json');
    response.send(JSON.stringify(responseObject));
};
