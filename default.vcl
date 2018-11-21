#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and https://www.varnish-cache.org/trac/wiki/VCLExamples for more examples.

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;

# Default backend definition. Set this to point to your content server.
#backend default {
#    .host = "a.b.c.d";
#    .port = "xx";
#}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
    set beresp.ttl = 5m;
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
}

## cahce is missin or hit
sub vcl_deliver {
  if (obj.hits > 0)
  {
    set resp.http.X-Varnish-Cache = "HIT";
  }
  else
  {
    set resp.http.X-Varnish-Cache = "MISS";
  }
}

#https://serverfault.com/questions/787953/is-it-possible-to-return-a-json-response-by-varnish-if-backend-is-down
#sub vcl_backend_error {
#    set beresp.http.Content-Type = "application/json; charset=utf-8";
#    synthetic( {"{ "msg" :{ "status": 2 } }"} );
#    return (deliver);
#}