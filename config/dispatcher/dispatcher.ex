  defmodule Dispatcher do
    use Matcher
    define_accept_types [
      html: [ "text/html", "application/xhtml+html" ],
      json: [ "application/json", "application/vnd.api+json" ]
    ]

    @any %{}
    @json %{ accept: %{ json: true } }
    @html %{ accept: %{ html: true } }

    # In order to forward the 'themes' resource to the
    # resource service, use the following forward rule:
    #
    # match "/themes/*path", @json do
    #   Proxy.forward conn, path, "http://resource/themes/"
    # end
    #
    # Run `docker-compose restart dispatcher` after updating
    # this file.

  # RESOURCES 

    get "/decisions/*path", @json do
      Proxy.forward conn, path, "http://resources/decisions"
    end

    get "/agenda-items/*path", @json do
      Proxy.forward conn, path, "http://resources/agenda-items"
    end

    get "/agenda-item-treatments/*path", @json do
      Proxy.forward conn, path, "http://resources/agenda-item-treatments"
    end

    get "/sessions/*path", @json do
      Proxy.forward conn, path, "http://resources/sessions"
    end
    
    get "/governing-agents/*path", @json do
      Proxy.forward conn, path, "http://resources/governing-agents"
    end
    
    get "/governing-units/*path", @json do
      Proxy.forward conn, path, "http://resources/governing-units"
    end
    
    get "/agents/*path", @json do
      Proxy.forward conn, path, "http://resources/agents"
    end

    get "/votings/*path", @json do
      Proxy.forward conn, path, "http://resources/votings"
    end

    get "/locations/*path", @json do
      Proxy.forward conn, path, "http://resources/locations"
    end

  # SERVICES

    get "/*path", @json do
      Proxy.forward conn, path, "http://frontend/"
    end

    match "/*_", %{ last_call: true } do
      send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
    end
  end
