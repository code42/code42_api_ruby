module Crashplan
  class Computer < Resource

    attribute :id, :from => 'computerId'

    def unblock
      client.unblock_computer(id)
    end

    def block
      client.block_computer(id)
    end

  end
end
