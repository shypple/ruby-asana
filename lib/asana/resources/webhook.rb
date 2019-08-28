### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # Webhooks allow an application to be notified of changes. This is in addition
    # to the ability to fetch those changes directly as
    # [Events](/developers/api-reference/events) - in fact, Webhooks are just a way
    # to receive Events via HTTP POST at the time they occur instead of polling for
    # them. For services accessible via HTTP this is often vastly more convenient,
    # and if events are not too frequent can be significantly more efficient.
    #
    # In both cases, however, changes are represented as Event objects - refer to
    # the [Events documentation](/developers/api-reference/events) for more
    # information on what data these events contain.
    #
    # **NOTE:** While Webhooks send arrays of Event objects to their target, the
    # Event objects themselves contain *only IDs*, rather than the actual resource
    # they are referencing. So while a normal event you receive via GET /events
    # would look like this:
    #
    #     {\
    #       "resource": {\
    #         "id": 1337,\
    #         "resource_type": "task",\
    #         "name": "My Task"\
    #       },\
    #       "parent": null,\
    #       "created_at": "2013-08-21T18:20:37.972Z",\
    #       "user": {\
    #         "id": 1123,\
    #         "resource_type": "user",\
    #         "name": "Tom Bizarro"\
    #       },\
    #       "action": "changed",\
    #       "type": "task"\
    #     }
    #
    # In a Webhook payload you would instead receive this:
    #
    #     {\
    #       "resource": 1337,\
    #       "parent": null,\
    #       "created_at": "2013-08-21T18:20:37.972Z",\
    #       "user": 1123,\
    #       "action": "changed",\
    #       "type": "task"\
    #     }
    #
    # Webhooks themselves contain only the information necessary to deliver the
    # events to the desired target as they are generated.
    class Webhook < Resource


      attr_reader :id

      attr_reader :gid

      attr_reader :resource_type

      attr_reader :resource

      attr_reader :target

      attr_reader :active

      attr_reader :created_at

      attr_reader :last_success_at

      attr_reader :last_failure_at

      attr_reader :last_failure_content

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'webhooks'
        end

        # Establishing a webhook is a two-part process. First, a simple HTTP POST
        # similar to any other resource creation. Since you could have multiple
        # webhooks we recommend specifying a unique local id for each target.
        #
        # Next comes the confirmation handshake. When a webhook is created, we will
        # send a test POST to the `target` with an `X-Hook-Secret` header as
        # described in the
        # [Resthooks Security documentation](http://resthooks.org/docs/security/).
        # The target must respond with a `200 OK` and a matching `X-Hook-Secret`
        # header to confirm that this webhook subscription is indeed expected.
        #
        # If you do not acknowledge the webhook's confirmation handshake it will
        # fail to setup, and you will receive an error in response to your attempt
        # to create it. This means you need to be able to receive and complete the
        # webhook *while* the POST request is in-flight.
        #
        # resource - [Id] A resource ID to subscribe to. The resource can be a task or project.
        #
        # target - [String] The URL to receive the HTTP POST.
        #
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create(client, resource: required("resource"), target: required("target"), options: {}, **data)
          with_params = data.merge(resource: resource, target: target).reject { |_,v| v.nil? || Array(v).empty? }
          self.new(parse(client.post("/webhooks", body: with_params, options: options)).first, client: client)
        end

        # Returns the compact representation of all webhooks your app has
        # registered for the authenticated user in the given workspace.
        #
        # workspace - [Id] The workspace to query for webhooks in.
        #
        # resource - [Id] Only return webhooks for the given resource.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def get_all(client, workspace: required("workspace"), resource: nil, per_page: 20, options: {})
          params = { workspace: workspace, resource: resource, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/webhooks", params: params, options: options)), type: self, client: client)
        end

        # Returns the full record for the given webhook.
        #
        # id - [Id] The webhook to get.
        #
        # options - [Hash] the request I/O options.
        def get_by_id(client, id, options: {})

          self.new(parse(client.get("/webhooks/#{id}", options: options)).first, client: client)
        end
      end

      # This method permanently removes a webhook. Note that it may be possible
      # to receive a request that was already in flight after deleting the
      # webhook, but no further requests will be issued.
      def delete_by_id()

        self.class.new(parse(client.delete("/webhooks/#{gid}")).first, client: client)
      end

    end
  end
end
