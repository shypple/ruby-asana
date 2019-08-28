### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # A _unicorn_ is a fantastic animal.
    class Unicorn < Resource


      attr_reader :id

      attr_reader :gid

      attr_reader :name

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'unicorns'
        end

        # Creates a new unicorn in a world.
        #
        # Returns the full record of the newly created unicorn.
        #
        # world - [Id] The world to create the unicorn in.
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create(client, world: required("world"), options: {}, **data)
          with_params = data.merge(world: world).reject { |_,v| v.nil? || Array(v).empty? }
          self.new(parse(client.post("/unicorns", body: with_params, options: options)).first, client: client)
        end

        # Creates a new unicorn in a world.
        #
        # Returns the full record of the newly created unicorn.
        #
        # world - [Id] The world to create the unicorn in.
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create_in_world(client, world: required("world"), options: {}, **data)

          self.new(parse(client.post("/worlds/#{world}/unicorns", body: data, options: options)).first, client: client)
        end

        # Returns the complete unicorn record for a single unicorn.
        #
        # id - [Id] The unicorn to get.
        # options - [Hash] the request I/O options.
        def find_by_id(client, id, options: {})

          self.new(parse(client.get("/unicorns/#{id}", options: options)).first, client: client)
        end

        # Returns the compact unicorn records for some filtered set of unicorns.
        # Use one or more of the parameters provided to filter the unicorns returned.
        #
        # world - [Id] The world to filter unicorns on.
        # breed - [Id] The breed to filter unicorns on.
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_all(client, world: nil, breed: nil, per_page: 20, options: {})
          params = { world: world, breed: breed, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/unicorns", params: params, options: options)), type: self, client: client)
        end

        # Returns the compact unicorn records for all unicorns in the world.
        #
        # world - [Id] The world to find unicorns in.
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_world(client, world: required("world"), per_page: 20, options: {})
          params = { limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/worlds/#{world}/unicorns", params: params, options: options)), type: self, client: client)
        end
      end

      # Updates the properties of a tag. Only the fields provided in the `data`
      # block will be updated; any unspecified fields will remain unchanged.
      #
      # When using this method, it is best to specify only those fields you wish
      # to change, or else you may overwrite changes made by another user since
      # you last retrieved the task.
      #
      # Returns the complete updated tag record.
      #
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def update(options: {}, **data)

        refresh_with(parse(client.put("/unicorns/#{gid}", body: data, options: options)).first)
      end

      # Returns a collection of paws belonging to the unicorn.
      #
      # per_page - [Integer] the number of records to fetch per page.
      # options - [Hash] the request I/O options.
      def paws(per_page: 20, options: {})
        params = { limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
        Collection.new(parse(client.get("/unicorns/#{gid}/paws", params: params, options: options)), type: Resource, client: client)
      end

      # Returns the newly added paw.
      #
      # paw - [Id] The paw to add.
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def add_paw(paw: required("paw"), options: {}, **data)
        with_params = data.merge(paw: paw).reject { |_,v| v.nil? || Array(v).empty? }
        Resource.new(parse(client.post("/unicorns/#{gid}/paws", body: with_params, options: options)).first, client: client)
      end

      # Returns the updated unicorn record.
      #
      # friends - [Array.Id] The friend IDs to add.
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def add_friends(friends: required("friends"), options: {}, **data)
        with_params = data.merge(friends: friends).reject { |_,v| v.nil? || Array(v).empty? }
        refresh_with(parse(client.post("/unicorns/#{gid}/friends", body: with_params, options: options)).first)
      end

      # Returns the world of the unicorn.
      #
      # options - [Hash] the request I/O options.
      def get_world(options: {})

        World.new(parse(client.get("/unicorns/#{gid}/getWorld", options: options)).first, client: client)
      end

      # A specific, existing unicorn can be deleted by making a DELETE request
      # on the URL for that unicorn.
      #
      # Returns an empty data record.
      def delete()

        client.delete("/unicorns/#{gid}") && true
      end

    end
  end
end
